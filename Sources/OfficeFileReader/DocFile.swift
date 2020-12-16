//
//  DocFile.swift
//  
//
//  Created by Hugh Bellamy on 05/11/2020.
//

import CompoundFileReader
import DataStream
import OleDataTypes
import Foundation
import VBAFileReader

/// [MS-DOC] 2.1 File Structure
/// A Word Binary File is an OLE compound file as specified by [MS-CFB]. The file consists of the following storages and streams.
public class DocFile {
    public let compoundFile: CompoundFile
    public let wordDocumentStream: WordDocumentStream
    private let tableStreamData: Data
    
    public init(data: Data) throws {
        self.compoundFile = try CompoundFile(data: data)

        /// [MS-DOC] 2.1.1 WordDocument Stream
        /// The WordDocument stream MUST be present in the file and MUST have an FIB at offset 0. It also contains the document text
        /// and other information referenced from other parts of the file. The stream has no predefined structure other than the FIB at the
        /// beginning.
        /// In the context of Word Binary Files, the delay stream that is referenced in [MS-ODRAW] is the WordDocument stream.
        /// The WordDocument stream MUST NOT be larger than 0x7FFFFFFF bytes.
        guard let wordDocumentStorage = self.compoundFile.rootStorage.children["WordDocument"] else {
            throw OfficeFileError.missingStream(name: "WordDocument")
        }

        self.wordDocumentStream = try WordDocumentStream(storage: wordDocumentStorage)
        
        /// [MS-DOC] 2.1.2 1Table Stream or 0Table Stream
        /// Either the 1Table stream or the 0Table stream MUST be present in the file. If the FIB at offset 0 in the WordDocument stream has
        /// base.fWhichTblStm set to 1, this stream is called 1Table. Otherwise, it is called 0Table.
        /// If the document is encrypted as specified in section 2.2.6, this stream MUST have an EncryptionHeader at offset 0, as specified
        /// in section 2.2.6. If the document is not encrypted, this stream has no predefined structure. Other than the possible EncryptionHeader,
        /// this stream contains the data that is referenced from the FIB or from other parts of the file.
        /// This documentation refers to this stream as the Table Stream.
        /// If a file contains both a 1Table and a 0Table stream, only the stream that is referenced by base.fWhichTblStm is used. The
        /// unreferenced stream MUST be ignored.
        /// The Table Stream MUST NOT be larger than 0x7FFFFFFF bytes.
        let tableStreamName = self.wordDocumentStream.fib.base.fWhichTblStm ? "1Table" : "0Table"
        guard let tableStreamStorage = self.compoundFile.rootStorage.children[tableStreamName] else {
            throw OfficeFileError.missingStream(name: tableStreamName)
        }
        
        self.tableStreamData = tableStreamStorage.data
    }
    
    public lazy var characters: (text: String, positions: [FileCharacterPosition])? = try? {
        guard let clx = self.clx else {
            return nil
        }
        
        var text = ""
        var fileCharacters: [FileCharacterPosition] = []
        fileCharacters.reserveCapacity(Int(clx.pcdt.plcPcd.aPcd.count))
        
        var dataStream = DataStream(wordDocumentStream.data)
        for (i, pcd) in clx.pcdt.plcPcd.aPcd.enumerated() {
            let count = clx.pcdt.plcPcd.aCP[i + 1] - clx.pcdt.plcPcd.aCP[i]
            let offset = clx.pcdt.plcPcd.aCP[i]
            
            let dataPosition: UInt32
            if pcd.fc.fCompressed {
                dataPosition = (pcd.fc.fc / 2) + offset / 2
                if dataPosition > dataStream.count {
                    throw OfficeFileError.corrupted
                }
                
                // TODO: special characters
                dataStream.position = Int(dataPosition)
                text += try dataStream.readString(count: Int(count), encoding: .ascii)!
            } else {
                dataPosition = (pcd.fc.fc / 2) + offset
                if dataPosition > dataStream.count {
                    throw OfficeFileError.corrupted
                }
                
                dataStream.position = Int(dataPosition)
                text += try dataStream.readString(count: Int(count * 2), encoding: .utf16LittleEndian)!
            }
            
            var prls: [Prl] = []
            try apply(clx: clx, pcd: pcd, to: &prls)
            let fc = FileCharacterPosition(
                dataPosition: dataPosition,
                compressed: pcd.fc.fCompressed,
                count: count,
                prls: prls)
            fileCharacters.append(fc)
        }
        
        return (text, fileCharacters)
    }()
    
    public lazy var paragraphs: [Paragraph]? = try? {
        guard let clx = self.clx, let plcBtePapx = self.plcfBtePapx else {
            return nil
        }
        
        var paragraphs: [Paragraph] = []
        paragraphs.reserveCapacity(plcBtePapx.aPnBtePapx.count)
        
        var dataStream = DataStream(wordDocumentStream.data)
        for (i, pnBtePapx) in plcBtePapx.aPnBtePapx.enumerated() {
            let btePapxPosition = pnBtePapx.pn * 512
            if btePapxPosition > dataStream.count {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position = Int(btePapxPosition)

            let papxFkp = try PapxFkp(dataStream: &dataStream)
            for (j, bxPap) in papxFkp.rgbx.enumerated() {
                var startFc = papxFkp.rgfc[j]
                var endFc = papxFkp.rgfc[j + 1]
                
                guard let fc = characters?.positions.first(where: { !(endFc <= $0.dataPosition || $0.dataPosition + $0.dataCount < startFc) }) else {
                    continue
                }
                
                if startFc < fc.dataPosition {
                    startFc = fc.dataPosition
                }
                if endFc > fc.dataPosition + fc.dataCount {
                    endFc = fc.dataPosition + fc.dataCount
                }
                
                var textPosition = (startFc - fc.dataPosition)
                var count = endFc - startFc
                if !fc.compressed {
                    textPosition /= 2
                    count /= 2
                }

                let papxInFkpPosition = btePapxPosition + 2 * UInt32(bxPap.bOffset)
                if papxInFkpPosition > dataStream.count {
                    throw OfficeFileError.corrupted
                }
                
                dataStream.position = Int(papxInFkpPosition)
                let papxInFkp = try PapxInFkp(dataStream: &dataStream)

                let paragraph = Paragraph(
                    document: self,
                    textPosition: textPosition,
                    count: count,
                    fc: fc,
                    papxInFkp: papxInFkp)
                paragraphs.append(paragraph)
            }
        }
        
        return paragraphs
    }()
    
    public func getTableStream(offset: UInt32, count: UInt32) throws -> DataStream? { 
        if offset >= tableStreamData.count {
            throw OfficeFileError.corrupted
        }
        if count > UInt32(tableStreamData.count) - count {
            throw OfficeFileError.corrupted
        }
        
        return DataStream(tableStreamData[Int(offset)..<Int(offset + count)])
    }
    
    public lazy var stshf: STSH? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbStshf == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcStshf,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbStshf) else {
            return nil
        }
        
        return try STSH(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbStshf)
    }()
    
    public lazy var plcffndRef: PlcffndRef? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcffndRef == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcffndRef,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcffndRef) else {
            return nil
        }
        
        return try PlcffndRef(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcffndRef)
    }()
    
    public lazy var plcffndTxt: PlcffndTxt? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcffndTxt == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcffndTxt,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcffndTxt) else {
            return nil
        }
        
        return try PlcffndTxt(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcffndTxt)
    }()
    
    public lazy var plcfandRef: PlcfandRef? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfandRef == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfandRef,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfandRef) else {
            return nil
        }
        
        return try PlcfandRef(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfandRef)
    }()
    
    public lazy var plcfandTxt: PlcfandTxt? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfandTxt == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfandTxt,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfandTxt) else {
            return nil
        }
        
        return try PlcfandTxt(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfandTxt)
    }()
    
    public lazy var plcfSed: PlcfSed? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfSed == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfSed,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfSed) else {
            return nil
        }
        
        return try PlcfSed(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfSed)
    }()
    
    public lazy var sttbfGlsy: SttbfGlsy? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfGlsy == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbfGlsy,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfGlsy) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfGlsy(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfGlsy {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfGlsy: PlcfGlsy? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfGlsy == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfGlsy,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfGlsy) else {
            return nil
        }
        
        return try PlcfGlsy(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfGlsy)
    }()
    
    public lazy var plcfhdd: Plcfhdd? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfHdd == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfHdd,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfHdd) else {
            return nil
        }
        
        return try Plcfhdd(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfHdd)
    }()
    
    public lazy var plcfBteChpx: PlcBteChpx? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBteChpx == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfBteChpx,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBteChpx) else {
            return nil
        }
        
        return try PlcBteChpx(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBteChpx)
    }()
    
    public lazy var plcfBtePapx: PlcBtePapx? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBtePapx == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfBtePapx,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBtePapx) else {
            return nil
        }
        
        return try PlcBtePapx(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBtePapx)
    }()
    
    public lazy var sttbfFfn: SttbfFfn? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfFfn == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbfFfn,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfFfn) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfFfn(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfFfn {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfFldMom: Plcfld? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldMom == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfFldMom,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldMom) else {
            return nil
        }
        
        return try Plcfld(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldMom)
    }()
    
    public lazy var plcfFldHdr: Plcfld? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldHdr == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfFldHdr,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldHdr) else {
            return nil
        }
        
        return try Plcfld(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldHdr)
    }()
    
    public lazy var plcfFldFtn: Plcfld? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldFtn == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfFldFtn,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldFtn) else {
            return nil
        }
        
        return try Plcfld(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldFtn)
    }()
    
    public lazy var plcfFldAtn: Plcfld? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldAtn == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfFldAtn,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldAtn) else {
            return nil
        }
        
        return try Plcfld(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldAtn)
    }()
    
    public lazy var sttbfBkmk: SttbfBkmk? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfBkmk == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbfBkmk,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfBkmk) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfBkmk(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfBkmk {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfBkf: Plcfbkf? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBkf == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfBkf,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBkf) else {
            return nil
        }
        
        return try Plcfbkf(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBkf)
    }()
    
    public lazy var plcfBkl: Plcfbkl? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBkl == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfBkl,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBkl) else {
            return nil
        }
        
        return try Plcfbkl(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfBkl)
    }()
    
    public lazy var cmds: Tcg? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbCmds == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcCmds,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbCmds) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try Tcg(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbCmds {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var prDrvr: PrDrvr? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPrDrvr == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPrDrvr,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPrDrvr) else {
            return nil
        }
        
        return try PrDrvr(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPrDrvr)
    }()
    
    public lazy var prEnvPort: PrEnvPort? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPrEnvPort == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPrEnvPort,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPrEnvPort) else {
            return nil
        }
        
        return try PrEnvPort(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPrEnvPort)
    }()
    
    public lazy var prEnvLand: PrEnvLand? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPrEnvLand == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPrEnvLand,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPrEnvLand) else {
            return nil
        }
        
        return try PrEnvLand(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPrEnvLand)
    }()
    
    public lazy var wss: Selsf? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbWss == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcWss,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbWss) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try Selsf(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbWss {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var dop: Dop? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbDop == 0 {
            throw OfficeFileError.corrupted
        }
        
        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcDop,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbDop) else {
            return nil
        }

        return try Dop(dataStream: &dataStream, fib: wordDocumentStream.fib, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbDop)
    }()
    
    public lazy var sttbfAssoc: SttbfAssoc? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfAssoc == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbfAssoc,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfAssoc) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfAssoc(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfAssoc {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var clx: Clx? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbClx == 0 {
            throw OfficeFileError.corrupted
        }
        
        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcClx,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbClx) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try Clx(dataStream: &dataStream, fibRgLw97: wordDocumentStream.fib.fibRgLw97)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbClx {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var grpXstAtnOwners: [Xst]? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbGrpXstAtnOwners == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcGrpXstAtnOwners,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbGrpXstAtnOwners) else {
            return nil
        }
        
        let startPosition = dataStream.position
        var result: [Xst] = []
        while dataStream.position - startPosition < wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbGrpXstAtnOwners {
            result.append(try Xst(dataStream: &dataStream))
        }
        
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbGrpXstAtnOwners {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var sttbfAtnBkmk: SttbfAtnBkmk? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfAtnBkmk == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbfAtnBkmk,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfAtnBkmk) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfAtnBkmk(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfAtnBkmk {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcSpaMom: PlcfSpa? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcSpaMom == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcSpaMom,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcSpaMom) else {
            return nil
        }
        
        return try PlcfSpa(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcSpaMom)
    }()
    
    public lazy var plcSpaHdr: PlcfSpa? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcSpaHdr == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcSpaHdr,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcSpaHdr) else {
            return nil
        }
        
        return try PlcfSpa(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcSpaHdr)
    }()
    
    public lazy var plcfAtnBkf: Plcfbkf? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfAtnBkf == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfAtnBkf,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfAtnBkf) else {
            return nil
        }
        
        return try Plcfbkf(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfAtnBkf)
    }()
    
    public lazy var plcfAtnBkl: Plcfbkl? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfAtnBkl == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfAtnBkl,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfAtnBkl) else {
            return nil
        }
        
        return try Plcfbkl(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfAtnBkl)
    }()
    
    public lazy var pms: Pms? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPms == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPms,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPms) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try Pms(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPms {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfendRef: PlcfendRef? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfendRef == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfendRef,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfendRef) else {
            return nil
        }
        
        return try PlcfendRef(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfendRef)
    }()
    
    public lazy var plcfendTxt: PlcfendTxt? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfendTxt == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfendTxt,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfendTxt) else {
            return nil
        }
        
        return try PlcfendTxt(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfendTxt)
    }()
    
    public lazy var plcfFldEdn: Plcfld? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldEdn == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfFldEdn,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldEdn) else {
            return nil
        }
        
        return try Plcfld(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldEdn)
    }()
    
    public lazy var dggInfo: OfficeArtContent? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbDggInfo == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcDggInfo,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbDggInfo) else {
            return nil
        }
        
        return try OfficeArtContent(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbDggInfo)
    }()
    
    public lazy var sttbfRMark: SttbfRMark? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfRMark == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbfRMark,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfRMark) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfRMark(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfRMark {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var sttbfCaption: SttbfCaption? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfCaption == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbfCaption,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfCaption) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfCaption(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfCaption {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var sttbfAutoCaption: SttbfAutoCaption? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfAutoCaption == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbfAutoCaption,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfAutoCaption) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfAutoCaption(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbfAutoCaption {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfWkb: PlcfWKB? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfWkb == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfWkb,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfWkb) else {
            return nil
        }
        
        return try PlcfWKB(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfWkb)
    }()
    
    public lazy var plcfSpl: Plcfspl? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfSpl == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfSpl,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfSpl) else {
            return nil
        }
        
        return try Plcfspl(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfSpl)
    }()
    
    public lazy var plcftxbxTxt: PlcftxbxTxt? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcftxbxTxt == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcftxbxTxt,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcftxbxTxt) else {
            return nil
        }
        
        return try PlcftxbxTxt(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcftxbxTxt)
    }()
    
    public lazy var plcfFldTxbx: Plcfld? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldTxbx == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfFldTxbx,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldTxbx) else {
            return nil
        }
        
        return try Plcfld(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfFldTxbx)
    }()
    
    public lazy var plcfHdrtxbxTxt : PlcfHdrtxbxTxt? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfHdrtxbxTxt  == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfHdrtxbxTxt ,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfHdrtxbxTxt ) else {
            return nil
        }
        
        return try PlcfHdrtxbxTxt(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfHdrtxbxTxt )
    }()
    
    public lazy var plcffldHdrTxbx: Plcfld? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcffldHdrTxbx == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcffldHdrTxbx,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcffldHdrTxbx) else {
            return nil
        }
        
        return try Plcfld(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcffldHdrTxbx)
    }()
    
    public lazy var stwUser: StwUser? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbStwUser == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcStwUser,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbStwUser) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try StwUser(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbStwUser {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var sttbTtmbd: SttbTtmbd? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbTtmbd == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbTtmbd,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbTtmbd) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbTtmbd(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbTtmbd {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var cookieData: RgCdb? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbCookieData == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcCookieData,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbCookieData) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try RgCdb(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbCookieData {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var routeSlip: RouteSlip? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbRouteSlip == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcRouteSlip,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbRouteSlip) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try RouteSlip(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbRouteSlip {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var sttbSavedBy: SttbSavedBy? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbSavedBy == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbSavedBy,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbSavedBy) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbSavedBy(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbSavedBy {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var sttbFnm: SttbFnm? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbFnm == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbFnm,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbFnm) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbFnm(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbFnm {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plfLst: PlfLst? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlfLst == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlfLst,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlfLst) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try PlfLst(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlfLst {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plfLfo: PlfLfo? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlfLfo == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlfLfo,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlfLfo) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try PlfLfo(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlfLfo {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfTxbxBkd: PlcfTxbxBkd? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfTxbxBkd == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfTxbxBkd,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfTxbxBkd) else {
            return nil
        }
        
        return try PlcfTxbxBkd(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfTxbxBkd)
    }()
    
    public lazy var plcfTxbxHdrBkd: PlcfTxbxHdrBkd? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfTxbxHdrBkd == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfTxbxHdrBkd,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfTxbxHdrBkd) else {
            return nil
        }
        
        return try PlcfTxbxHdrBkd(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfTxbxHdrBkd)
    }()
    
    public lazy var sttbGlsyStyle: SttbGlsyStyle? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbGlsyStyle == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbGlsyStyle,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbGlsyStyle) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbGlsyStyle(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbGlsyStyle {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plgosl: PlfGosl? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlgosl == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlgosl,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlgosl) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try PlfGosl(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlgosl {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcocx: RgxOcxInfo? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcocx == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcocx,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcocx) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try RgxOcxInfo(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcocx {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfAsumy: PlcfAsumy? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfAsumy == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcPlcfAsumy,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfAsumy) else {
            return nil
        }
        
        return try PlcfAsumy(dataStream: &dataStream, size: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbPlcfAsumy)
    }()
    
    public lazy var sttbListNames: SttbListNames? = try? {
        if wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbListNames == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.fcSttbListNames,
                count: wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbListNames) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbListNames(dataStream: &dataStream)
        if dataStream.position - startPosition != wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbSttbListNames {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfTch: PlcfTch? = try? {
        guard let fibRgFcLcb2000 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2000 else {
            return nil
        }

        if fibRgFcLcb2000.lcbPlcfTch == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2000.fcPlcfTch,
                count: fibRgFcLcb2000.lcbPlcfTch) else {
            return nil
        }
        
        return try PlcfTch(dataStream: &dataStream, size: fibRgFcLcb2000.lcbPlcfTch)
    }()
    
    public lazy var rmdThreading: RmdThreading? = try? {
        guard let fibRgFcLcb2000 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2000 else {
            return nil
        }

        if fibRgFcLcb2000.lcbRmdThreading == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2000.fcRmdThreading,
                count: fibRgFcLcb2000.lcbRmdThreading) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try RmdThreading(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2000.lcbRmdThreading {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var sttbRgtplc: SttbRgtplc? = try? {
        guard let fibRgFcLcb2000 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2000 else {
            return nil
        }

        if fibRgFcLcb2000.lcbSttbRgtplc == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2000.fcSttbRgtplc,
                count: fibRgFcLcb2000.lcbSttbRgtplc) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbRgtplc(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2000.lcbSttbRgtplc {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var msoEnvelope: MsoEnvelopeCLSID? = try? {
        guard let fibRgFcLcb2000 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2000 else {
            return nil
        }

        if fibRgFcLcb2000.lcbMsoEnvelope == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2000.fcMsoEnvelope,
                count: fibRgFcLcb2000.lcbMsoEnvelope) else {
            return nil
        }
        
        return try MsoEnvelopeCLSID(dataStream: &dataStream, size: fibRgFcLcb2000.lcbMsoEnvelope)
    }()
    
    public lazy var plcfLad: Plcflad? = try? {
        guard let fibRgFcLcb2000 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2000 else {
            return nil
        }

        if fibRgFcLcb2000.lcbPlcfLad == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2000.fcPlcfLad,
                count: fibRgFcLcb2000.lcbPlcfLad) else {
            return nil
        }
        
        return try Plcflad(dataStream: &dataStream, size: fibRgFcLcb2000.lcbPlcfLad)
    }()
    
    public lazy var rgDofr: [Dofrh]? = try? {
        guard let fibRgFcLcb2000 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2000 else {
            return nil
        }

        if fibRgFcLcb2000.lcbRgDofr == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2000.fcRgDofr,
                count: fibRgFcLcb2000.lcbRgDofr) else {
            return nil
        }

        let startPosition = dataStream.position
        var result: [Dofrh] = []
        while dataStream.position - startPosition < fibRgFcLcb2000.lcbRgDofr {
            result.append(try Dofrh(dataStream: &dataStream))
        }
        
        if dataStream.position - startPosition != fibRgFcLcb2000.lcbRgDofr {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcosl: PlfCosl? = try? {
        guard let fibRgFcLcb2000 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2000 else {
            return nil
        }

        if fibRgFcLcb2000.lcbPlcosl == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2000.fcPlcosl,
                count: fibRgFcLcb2000.lcbPlcosl) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try PlfCosl(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2000.lcbPlcosl {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfCookieOld: PlcfcookieOld? = try? {
        guard let fibRgFcLcb2000 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2000 else {
            return nil
        }

        if fibRgFcLcb2000.lcbPlcfCookieOld == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2000.fcPlcfCookieOld,
                count: fibRgFcLcb2000.lcbPlcfCookieOld) else {
            return nil
        }
        
        return try PlcfcookieOld(dataStream: &dataStream, size: fibRgFcLcb2000.lcbPlcfCookieOld)
    }()
    
    public lazy var plcfPgp: PGPArray? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbPlcfPgp == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlcfPgp,
                count: fibRgFcLcb2002.lcbPlcfPgp) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try PGPArray(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2002.lcbPlcfPgp {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfuim: Plcfuim? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbPlcfuim == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlcfuim,
                count: fibRgFcLcb2002.lcbPlcfuim) else {
            return nil
        }
        
        return try Plcfuim(dataStream: &dataStream, size: fibRgFcLcb2002.lcbPlcfuim)
    }()
    
    public lazy var plfguidUim: PlfguidUim? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbPlfguidUim == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlfguidUim,
                count: fibRgFcLcb2002.lcbPlfguidUim) else {
            return nil
        }

        let startPosition = dataStream.position
        let result = try PlfguidUim(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2002.lcbPlrsid {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var atrdExtra: AtrdExtra? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbAtrdExtra == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcAtrdExtra,
                count: fibRgFcLcb2002.lcbAtrdExtra) else {
            return nil
        }
        
        return try AtrdExtra(dataStream: &dataStream, size: fibRgFcLcb2002.lcbAtrdExtra)
    }()
    
    public lazy var plrsid: PLRSID? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbPlrsid == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlrsid,
                count: fibRgFcLcb2002.lcbPlrsid) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try PLRSID(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2002.lcbPlrsid {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var sttbfBkmkFactoid: SttbfBkmkFactoid? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbSttbfBkmkFactoid == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcSttbfBkmkFactoid,
                count: fibRgFcLcb2002.lcbSttbfBkmkFactoid) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfBkmkFactoid(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2002.lcbSttbfBkmkFactoid {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfBkfFactoid: Plcfbkfd? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbPlcfBkfFactoid == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlcfBkfFactoid,
                count: fibRgFcLcb2002.lcbPlcfBkfFactoid) else {
            return nil
        }
        
        return try Plcfbkfd(dataStream: &dataStream, size: fibRgFcLcb2002.lcbPlcfBkfFactoid)
    }()
    
    public lazy var plcfcookie: Plcfcookie? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002  else {
            return nil
        }

        if fibRgFcLcb2002.lcbSttbfBkmkFactoid == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlcfcookie,
                count: fibRgFcLcb2002.lcbPlcfcookie) else {
            return nil
        }
        
        return try Plcfcookie(dataStream: &dataStream, size: fibRgFcLcb2002.lcbPlcfcookie)
    }()
    
    public lazy var plcfBklFactoid: Plcfbkld? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002  else {
            return nil
        }

        if fibRgFcLcb2002.lcbPlcfBklFactoid == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlcfBklFactoid,
                count: fibRgFcLcb2002.lcbPlcfBklFactoid) else {
            return nil
        }
        
        return try Plcfbkld(dataStream: &dataStream, size: fibRgFcLcb2002.lcbPlcfBklFactoid)
    }()
    
    public lazy var factoidData: SmartTagData? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbFactoidData == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcFactoidData,
                count: fibRgFcLcb2002.lcbFactoidData) else {
            return nil
        }
        
        return try SmartTagData(dataStream: &dataStream, size: fibRgFcLcb2002.lcbFactoidData)
    }()
    
    public lazy var sttbfBkmkFcc: SttbfBkmkFcc? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbSttbfBkmkFactoid == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcSttbfBkmkFcc,
                count: fibRgFcLcb2002.lcbSttbfBkmkFcc) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfBkmkFcc(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2002.lcbSttbfBkmkFcc {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfBkfFcc: Plcfbkfd? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002  else {
            return nil
        }

        if fibRgFcLcb2002.lcbPlcfBkfFcc == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlcfBkfFcc,
                count: fibRgFcLcb2002.lcbPlcfBkfFcc) else {
            return nil
        }
        
        return try Plcfbkfd(dataStream: &dataStream, size: fibRgFcLcb2002.lcbPlcfBkfFcc)
    }()
    
    public lazy var sttbfbkmkBPRepairs: SttbfBkmkBPRepairs? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbSttbfbkmkBPRepairs == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcSttbfbkmkBPRepairs,
                count: fibRgFcLcb2002.lcbSttbfbkmkBPRepairs) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfBkmkBPRepairs(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2002.lcbSttbfbkmkBPRepairs {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfbkfBPRepairs: Plcfbkf? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002  else {
            return nil
        }

        if fibRgFcLcb2002.lcbPlcfbkfBPRepairs == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlcfbkfBPRepairs,
                count: fibRgFcLcb2002.lcbPlcfbkfBPRepairs) else {
            return nil
        }
        
        return try Plcfbkf(dataStream: &dataStream, size: fibRgFcLcb2002.lcbPlcfbkfBPRepairs)
    }()
    
    public lazy var plcfbklBPRepairs: Plcfbkl? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002  else {
            return nil
        }

        if fibRgFcLcb2002.lcbPlcfbklBPRepairs == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlcfbklBPRepairs,
                count: fibRgFcLcb2002.lcbPlcfbklBPRepairs) else {
            return nil
        }
        
        return try Plcfbkl(dataStream: &dataStream, size: fibRgFcLcb2002.lcbPlcfbklBPRepairs)
    }()
    
    public lazy var pmsNew: Pms? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbPmsNew == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPmsNew,
                count: fibRgFcLcb2002.lcbPmsNew) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try Pms(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2002.lcbPmsNew {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var odso: [ODSOPropertyBase]? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002 else {
            return nil
        }

        if fibRgFcLcb2002.lcbODSO == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcODSO,
                count: fibRgFcLcb2002.lcbODSO) else {
            return nil
        }

        let startPosition = dataStream.position
        var result: [ODSOPropertyBase] = []
        while dataStream.position - startPosition < fibRgFcLcb2002.lcbODSO {
            result.append(try ODSOPropertyBase(dataStream: &dataStream))
        }
        
        if dataStream.position - startPosition != fibRgFcLcb2002.lcbODSO {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcffactoid: Plcffactoid? = try? {
        guard let fibRgFcLcb2002 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2002  else {
            return nil
        }

        if fibRgFcLcb2002.lcbPlcffactoid == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2002.fcPlcffactoid,
                count: fibRgFcLcb2002.lcbPlcffactoid) else {
            return nil
        }
        
        return try Plcffactoid(dataStream: &dataStream, size: fibRgFcLcb2002.lcbPlcffactoid)
    }()
    
    public lazy var hplxsdr: Hplxsdr? = try? {
        guard let fibRgFcLcb2003 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2003 else {
            return nil
        }

        if fibRgFcLcb2003.lcbHplxsdr == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2003.fcHplxsdr,
                count: fibRgFcLcb2003.lcbHplxsdr) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try Hplxsdr(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2003.lcbHplxsdr {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var sttbfBkmkSdt: SttbfBkmkSdt? = try? {
        guard let fibRgFcLcb2003 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2003 else {
            return nil
        }

        if fibRgFcLcb2003.lcbSttbfBkmkSdt == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2003.fcSttbfBkmkSdt,
                count: fibRgFcLcb2003.lcbSttbfBkmkSdt) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfBkmkSdt(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2003.lcbSttbfBkmkSdt {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfBkfSdt: Plcbkfd? = try? {
        guard let fibRgFcLcb2003 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2003 else {
            return nil
        }

        if fibRgFcLcb2003.lcbPlcfBkfSdt == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2003.fcPlcfBkfSdt,
                count: fibRgFcLcb2003.lcbPlcfBkfSdt) else {
            return nil
        }

        return try Plcbkfd(dataStream: &dataStream, size: fibRgFcLcb2003.lcbPlcfBkfSdt)
    }()
    
    public lazy var plcfBklSdt: Plcbkld? = try? {
        guard let fibRgFcLcb2003 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2003 else {
            return nil
        }

        if fibRgFcLcb2003.lcbPlcfBklSdt == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2003.fcPlcfBklSdt,
                count: fibRgFcLcb2003.lcbPlcfBklSdt) else {
            return nil
        }

        return try Plcbkld(dataStream: &dataStream, size: fibRgFcLcb2003.lcbPlcfBklSdt)
    }()
    
    public lazy var customXForm: String? = try? {
        guard let fibRgFcLcb2003 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2003 else {
            return nil
        }

        if fibRgFcLcb2003.lcbCustomXForm == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2003.fcCustomXForm,
                count: fibRgFcLcb2003.lcbCustomXForm) else {
            return nil
        }
        
        return try dataStream.readString(count: Int(fibRgFcLcb2003.lcbCustomXForm), encoding: .utf16LittleEndian)!
    }()
    
    public lazy var sttbfBkmkProt: SttbfBkmkProt? = try? {
        guard let fibRgFcLcb2003 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2003 else {
            return nil
        }

        if fibRgFcLcb2003.lcbSttbfBkmkProt == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2003.fcSttbfBkmkProt,
                count: fibRgFcLcb2003.lcbSttbfBkmkProt) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbfBkmkProt(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2003.lcbSttbfBkmkProt {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var plcfBkfProt: Plcbkf? = try? {
        guard let fibRgFcLcb2003 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2003 else {
            return nil
        }

        if fibRgFcLcb2003.lcbPlcfBkfProt == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2003.fcPlcfBkfProt,
                count: fibRgFcLcb2003.lcbPlcfBkfProt) else {
            return nil
        }

        return try Plcbkf(dataStream: &dataStream, size: fibRgFcLcb2003.lcbPlcfBkfProt)
    }()
    
    public lazy var plcfBklProt: Plcbkl? = try? {
        guard let fibRgFcLcb2003 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2003 else {
            return nil
        }

        if fibRgFcLcb2003.lcbPlcfBklProt == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2003.fcPlcfBklProt,
                count: fibRgFcLcb2003.lcbPlcfBklProt) else {
            return nil
        }

        return try Plcbkl(dataStream: &dataStream, size: fibRgFcLcb2003.lcbPlcfBklProt)
    }()
    
    public lazy var sttbProtUser: SttbProtUser? = try? {
        guard let fibRgFcLcb2003 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2003 else {
            return nil
        }

        if fibRgFcLcb2003.lcbSttbProtUser == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2003.fcSttbProtUser,
                count: fibRgFcLcb2003.lcbSttbProtUser) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try SttbProtUser(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2003.lcbSttbProtUser {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    public lazy var afd: Afd? = try? {
        guard let fibRgFcLcb2003 = wordDocumentStream.fib.fibRgFcLcbBlob.fibRgFcLcb2003 else {
            return nil
        }

        if fibRgFcLcb2003.lcbAfd == 0 {
            return nil
        }

        guard var dataStream = try getTableStream(
                offset: fibRgFcLcb2003.fcAfd,
                count: fibRgFcLcb2003.lcbAfd) else {
            return nil
        }
        
        let startPosition = dataStream.position
        let result = try Afd(dataStream: &dataStream)
        if dataStream.position - startPosition != fibRgFcLcb2003.lcbAfd {
            throw OfficeFileError.corrupted
        }
        
        return result
    }()
    
    private func getIndex(clx: Clx, characterPosition: CP) -> Int? {
        /// [MS-DOC] 2.4.1 Retrieving Text
        /// 3. The Clx contains a Pcdt, and the Pcdt contains a PlcPcd. Find the largest i such that PlcPcd.aCp[i] ≤ cp. As with all Plcs, the
        /// elements of PlcPcd.aCp are sorted in ascending order. Recall from the definition of a Plc that the aCp array has one more element
        /// than the aPcd array. Thus, if the last element of PlcPcd.aCp is less than or equal to cp, cp is outside the range of valid character
        /// positions in this document.
        guard let i =  clx.pcdt.plcPcd.aCP.lastIndex(where: { $0 <= characterPosition }) else {
            return nil
        }

        if clx.pcdt.plcPcd.aCP.last! <= characterPosition {
            return nil
        }
        
        return i
    }
    
    public func getTextOffset(clx: Clx, characterPosition: CP) throws -> (index: Int, offset: UInt32)? {
        /// [MS-DOC] 2.4.1 Retrieving Text
        /// The following algorithm specifies how to find the text at a particular character position (cp). Negative character positions are not valid.
        /// 1. Read the FIB from offset zero in the WordDocument Stream.
        /// 2. All versions of the FIB contain exactly one FibRgFcLcb97, though it can be nested in a larger structure. FibRgFcLcb97.fcClx
        /// specifies the offset in the Table Stream of a Clx. FibRgFcLcb97.lcbClx specifies the size, in bytes, of that Clx. Read the Clx from
        /// the Table Stream.
        guard let clx = self.clx else {
            return nil
        }

        /// 3. The Clx contains a Pcdt, and the Pcdt contains a PlcPcd. Find the largest i such that PlcPcd.aCp[i] ≤ cp. As with all Plcs, the
        /// elements of PlcPcd.aCp are sorted in ascending order. Recall from the definition of a Plc that the aCp array has one more element
        /// than the aPcd array. Thus, if the last element of PlcPcd.aCp is less than or equal to cp, cp is outside the range of valid character
        /// positions in this document.
        guard let i = getIndex(clx: clx, characterPosition: characterPosition) else {
            return nil
        }
        
        /// 4. PlcPcd.aPcd[i] is a Pcd. Pcd.fc is an FcCompressed that specifies the location in the WordDocument Stream of the text at
        /// character position PlcPcd.aCp[i].
        let pcd = clx.pcdt.plcPcd.aPcd[i]
        if !pcd.fc.fCompressed {
            let offset = pcd.fc.fc + 2 * (characterPosition - clx.pcdt.plcPcd.aCP[i])
            if offset > wordDocumentStream.data.count {
                throw OfficeFileError.corrupted
            }
            
            return (i, offset)
        } else {
            let offset = (pcd.fc.fc / 2) + (characterPosition - clx.pcdt.plcPcd.aCP[i])
            if offset > wordDocumentStream.data.count {
                throw OfficeFileError.corrupted
            }

            return (i, offset)
        }
    }
    
    public func getText(at characterPosition: CP) throws -> String? {
        /// [MS-DOC] 2.4.1 Retrieving Text
        /// The following algorithm specifies how to find the text at a particular character position (cp). Negative character positions are not valid.
        guard let clx = self.clx else {
            return nil
        }
        
        guard let (i, offset) = try getTextOffset(clx: clx, characterPosition: characterPosition) else {
            return nil
        }
        
        let pcd = clx.pcdt.plcPcd.aPcd[i]
        let length = Int(clx.pcdt.plcPcd.aCP[i + 1] - characterPosition)

        var dataStream = DataStream(wordDocumentStream.data)
        dataStream.position = Int(offset)
        if !pcd.fc.fCompressed {
            /// 5. If FcCompressed.fCompressed is zero, the character at position cp is a 16-bit Unicode character at offset
            /// FcCompressed.fc + 2(cp - PlcPcd.aCp[i]) in the WordDocument Stream. This is to say that the text at character position
            /// PlcPcd.aCP[i] begins at offset FcCompressed.fc in the WordDocument Stream and each character occupies two bytes.
            return try dataStream.readString(count: length, encoding: .utf16LittleEndian)
        } else {
            /// 6. If FcCompressed.fCompressed is 1, the character at position cp is an 8-bit ANSI character at offset
            /// (FcCompressed.fc / 2) + (cp - PlcPcd.aCp[i]) in the WordDocument Stream, unless it is one of the special values in the table
            /// defined in the description of FcCompressed.fc. This is to say that the text at character position PlcPcd.aCP[i] begins at offset
            /// FcCompressed.fc / 2 in the WordDocument Stream and each character occupies one byte.
            return try dataStream.readString(count: length, encoding: .ascii)
        }
    }
    
    public func getParagraphStart(containing characterPosition: CP) throws -> CP? {
        /// [MS-OXPROPS] 2.4.2 Determining Paragraph Boundaries
        /// This section specifies how to find the beginning and end character positions of the paragraph that contains a given character position.
        /// The character at the end character position of a paragraph MUST be a paragraph mark, an end-of-section character, a cell mark, or
        /// a TTP mark (See Overview of Tables). Negative character positions are not valid.
        /// To find the character position of the first character in the paragraph that contains a given character position cp:
        guard let clx = self.clx else {
            return nil
        }
        
        /// 1. Follow the algorithm from Retrieving Text up to and including step 3 to find i. Also remember the FibRgFcLcb97 and PlcPcd found
        /// in step 1 of Retrieving Text. If the algorithm from Retrieving Text specifies that cp is invalid, leave the algorithm.
        guard var i = getIndex(clx: clx, characterPosition: characterPosition) else {
            return nil
        }
        
        /// 2. Let pcd be PlcPcd.aPcd[i].
        var characterPosition = characterPosition
        while true {
            let pcd = clx.pcdt.plcPcd.aPcd[i]
            
            /// 3. Let fcPcd be Pcd.fc.fc. Let fc be fcPcd + 2(cp – PlcPcd.aCp[i]). If Pcd.fc.fCompressed is one, set fc to fc / 2, and set
            /// fcPcd to fcPcd/2.
            var fcPcd = pcd.fc.fc
            var fc = fcPcd + 2 * (characterPosition - clx.pcdt.plcPcd.aCP[i])
            if pcd.fc.fCompressed {
                fc /= 2
                fcPcd /= 2
            }
            
            /// 4. Read a PlcBtePapx at offset FibRgFcLcb97.fcPlcfBtePapx in the Table Stream, and of size
            /// FibRgFcLcb97.lcbPlcfBtePapx.
            /// Let fcLast be the last element of plcbtePapx.aFc. If fcLast is less than or equal to fc, examine fcPcd.
            /// If fcLast is less than fcPcd, go to step 8. Otherwise, set fc to fcLast. If Pcd.fc.fCompressed is one, set fcLast to fcLast / 2.
            /// Set fcFirst to fcLast and go to step 7.
            guard let plcBtePapx = plcfBtePapx, var fcLast = plcBtePapx.aFC.last else {
                return nil
            }
            
            if fcLast <= fc {
                if fcLast < fcPcd {
                    /// 8. If PlcPcd.aCp[i] is 0, then the first character of the paragraph is at character position 0. Leave the algorithm.
                    if clx.pcdt.plcPcd.aCP[i] == 0 {
                        return 0
                    }
                    
                    /// 9. Set cp to PlcPcd.aCp[i]. Set i to i - 1. Go to step 2.
                    characterPosition = clx.pcdt.plcPcd.aCP[i]
                    i -= 1
                    continue
                } else {
                    fc = fcLast
                }

                if pcd.fc.fCompressed {
                    fcLast = fcLast / 2
                }
                
                let fcFirst = fcLast
                
                /// 7. If fcFirst is greater than fcPcd, then let dfc be (fcFirst – fcPcd). If Pcd.fc.fCompressed is zero, then set dfc to dfc / 2.
                /// The first character of the paragraph is at character position PlcPcd.aCp[i] + dfc. Leave the algorithm.
                if fcFirst > fcPcd {
                    var dfc = fcFirst - fcPcd
                    if !pcd.fc.fCompressed {
                        dfc /= 2
                    }
                    
                    return clx.pcdt.plcPcd.aCP[i] + dfc
                }
                    
                /// 8. If PlcPcd.aCp[i] is 0, then the first character of the paragraph is at character position 0. Leave the algorithm.
                if clx.pcdt.plcPcd.aCP[i] == 0 {
                    return 0
                }
                
                /// 9. Set cp to PlcPcd.aCp[i]. Set i to i - 1. Go to step 2.
                characterPosition = clx.pcdt.plcPcd.aCP[i]
                i -= 1
                continue
            }
            
            
            /// 5. Find the largest j such that plcbtePapx.aFc[j] ≤ fc. Read a PapxFkp at offset aPnBtePapx[j].pn *512 in the WordDocument
            /// Stream.
            guard let j = plcBtePapx.aFC.lastIndex(where: { $0 <= fc }) else {
                return nil
            }
            
            var papxFkpDataStream = DataStream(wordDocumentStream.data)
            let papxFkpOffset = plcBtePapx.aPnBtePapx[j].pn * 512
            if papxFkpOffset > papxFkpDataStream.count {
                throw OfficeFileError.corrupted
            }
            
            papxFkpDataStream.position = Int(papxFkpOffset)
            let papxFkp = try PapxFkp(dataStream: &papxFkpDataStream)
            
            /// 6. Find the largest k such that PapxFkp.rgfc[k] ≤ fc. If the last element of PapxFkp.rgfc is less than or equal to fc, then cp is outside
            /// the range of character positions in this document, and is not valid. Let fcFirst be PapxFkp.rgfc[k].
            guard let k = papxFkp.rgfc.lastIndex(where: { $0 <= fc }) else {
                return nil
            }
            
            let fcFirst = papxFkp.rgfc[k]
            
            /// 7. If fcFirst is greater than fcPcd, then let dfc be (fcFirst – fcPcd). If Pcd.fc.fCompressed is zero, then set dfc to dfc / 2. The first
            /// character of the paragraph is at character position PlcPcd.aCp[i] + dfc. Leave the algorithm.
            if fcFirst > fcPcd {
                var dfc = fcFirst - fcPcd
                if !pcd.fc.fCompressed {
                    dfc /= 2
                }
                
                return clx.pcdt.plcPcd.aCP[i] + dfc
            }
            
            /// 8. If PlcPcd.aCp[i] is 0, then the first character of the paragraph is at character position 0. Leave the algorithm.
            if clx.pcdt.plcPcd.aCP[i] == 0 {
                return 0
            }
            
            /// 9. Set cp to PlcPcd.aCp[i]. Set i to i - 1. Go to step 2.
            characterPosition = clx.pcdt.plcPcd.aCP[i]
            i -= 1
        }
    }
    
    private func getParagraphEnd(clx: Clx, characterPosition: CP) throws
    -> (pcd: Pcd, papxFkp: PapxFkp, papxFkpOffset: UInt32, index: Int, offset: CP)? {
        /// [MS-OXPROPS] 2.4.2 Determining Paragraph Boundaries
        /// This section specifies how to find the beginning and end character positions of the paragraph that contains a given character position.
        /// The character at the end character position of a paragraph MUST be a paragraph mark, an end-of-section character, a cell mark, or
        /// a TTP mark (See Overview of Tables). Negative character positions are not valid.
        /// To find the character position of the last character in the paragraph that contains a given character position cp:
        guard let clx = self.clx else {
            return nil
        }
        
        /// 1. Follow the algorithm from Retrieving Text up to and including step 3 to find i. Also remember the FibRgFcLcb97, and PlcPcd found
        /// in step 1 of Retrieving Text. If the algorithm from Retrieving Text specifies that cp is invalid, leave the algorithm.
        guard var i = getIndex(clx: clx, characterPosition: characterPosition) else {
            return nil
        }

        /// 2. Let pcd be PlcPcd.aPcd[i].
        var characterPosition = characterPosition
        while true {
            let pcd = clx.pcdt.plcPcd.aPcd[i]
            
            /// 3. Let fcPcd be Pcd.fc.fc. Let fc be fcPcd + 2(cp – PlcPcd.aCp[i]). Let fcMac be fcPcd + 2(PlcPcd.aCp[i+1] - PlcPcd.aCp[i]).
            /// If Pcd.fc.fCompressed is one, set fc to fc/2, set fcPcd to fcPcd /2 and set fcMac to fcMac/2.
            var fcPcd = pcd.fc.fc
            var fc = fcPcd + 2 * (characterPosition - clx.pcdt.plcPcd.aCP[i])
            var fcMac = fcPcd + 2 * (clx.pcdt.plcPcd.aCP[i + 1] - clx.pcdt.plcPcd.aCP[i])
            if pcd.fc.fCompressed {
                fc /= 2
                fcPcd /= 2
                fcMac /= 2
            }
            
            /// 4. Read a PlcBtePapx at offset FibRgFcLcb97.fcPlcfBtePapx in the Table Stream, and of size FibRgFcLcb97.lcbPlcfBtePapx.
            /// Then find the largest j such that plcbtePapx.aFc[j] ≤ fc. If the last element of plcbtePapx.aFc is less than or equal to fc, then
            /// go to step 7. Read a PapxFkp at offset aPnBtePapx[j].pn *512 in the WordDocument Stream.
            guard let plcBtePapx = self.plcfBtePapx else {
                return nil
            }
            
            guard let j = plcBtePapx.aFC.lastIndex(where: { $0 <= fc }) else {
                characterPosition = clx.pcdt.plcPcd.aCP[i + 1]
                i = i + 1
                continue
            }
            
            var papxFkpDataStream = DataStream(wordDocumentStream.data)
            let papxFkpOffset = plcBtePapx.aPnBtePapx[j].pn * 512
            if papxFkpOffset > papxFkpDataStream.count {
                throw OfficeFileError.corrupted
            }
            
            papxFkpDataStream.position = Int(papxFkpOffset)
            let papxFkp = try PapxFkp(dataStream: &papxFkpDataStream)
            
            /// 5. Find largest k such that PapxFkp.rgfc[k] ≤ fc. If the last element of PapxFkp.rgfc is less than or equal to fc, then cp is
            /// outside the range of character positions in this document, and is not valid. Let fcLim be PapxFkp.rgfc[k+1].
            guard let k = papxFkp.rgfc.lastIndex(where: { $0 <= fc }) else {
                return nil
            }
            
            let fcLim = papxFkp.rgfc[k + 1]
            
            /// 6. If fcLim ≤ fcMac, then let dfc be (fcLim – fcPcd). If Pcd.fc.fCompressed is zero, then set dfc to dfc / 2. The last character
            /// of the paragraph is at character position PlcPcd.aCp[i] + dfc – 1. Leave the algorithm.
            if fcLim <= fcMac {
                var dfc = fcLim - fcPcd
                if !pcd.fc.fCompressed {
                    dfc /= 2
                }
                
                let result = clx.pcdt.plcPcd.aCP[i] + dfc - 1
                return (pcd, papxFkp, papxFkpOffset, k, result)
            }
            
            /// 7. Set cp to PlcPcd.aCp[i+1]. Set i to i + 1. Go to step 2.
            characterPosition = clx.pcdt.plcPcd.aCP[i + 1]
            i = i + 1
        }
    }
    
    public func getParagraphEnd(containing characterPosition: CP) throws -> CP? {
        guard let clx = clx else {
            return nil
        }
        
        return try getParagraphEnd(clx: clx, characterPosition: characterPosition)?.offset
    }
    
    public func getParagraphBoundaries(containing characterPosition: CP) throws -> (start: CP, end: CP)? {
        guard let start = try getParagraphStart(containing: characterPosition),
              let end = try getParagraphEnd(containing: characterPosition) else {
            return nil
        }
        
        return (start, end)
    }
    
    public func getTableDepth(characterPosition: CP) throws -> Int? {
        /// [MS-DOC] 2.4.4 Determining Cell Boundaries
        /// This section describes an algorithm to find the boundaries of the innermost table cell containing a given character position or to determine
        /// that the given character position is not in a table cell. Every valid character position in a document belongs to a paragraph, so table depth
        /// can be computed for each paragraph. If a paragraph is found to be at depth zero, that paragraph is not in a table cell.
        /// Given character position cp, use the following algorithm to determine if cp is in a table cell.
        
        /// 1. Follow the procedure from Direct Paragraph Formatting to find the paragraph properties for the paragraph that contains cp.
        /// Apply the properties, and determine the table depth as specified in Overview of Tables. Call this itapOrig.
        guard let paragraphProperties = try getParagraphFormatting(characterPosition: characterPosition) else {
            return nil
        }
        
        fatalError("NYI: \(paragraphProperties)")
    }
    
    public func getParagraphFormatting(characterPosition: CP) throws -> [Prl]? {
        /// [MS-DOC] 2.4.6.1 Direct Paragraph Formatting
        /// This section explains how to find the properties applied directly (as opposed to through a style, for example) to a paragraph, given
        /// a character position cp within it. The properties are found as an array of Prl elements.
        /// 1. Follow the algorithm from Determining Paragraph Boundaries for finding the character position of the last character in the
        /// paragraph to completion. From step 5, remember the PapxFkp and k. From step 4, remember the offset in the WordDocument
        /// Stream at which PapxFkp was read. Let this offset be called of. From step 2 remember the Pcd. If the algorithm from Determining
        /// Paragraph Boundaries specifies that cp is invalid, leave the algorithm.
        guard let clx = clx else {
            return nil
        }

        guard let (pcd, papxFkp, of, k, _) = try getParagraphEnd(clx: clx, characterPosition: characterPosition) else {
            return nil
        }
        
        /// 2. Find a BxPap at PapxFkp.rgbx[k]. Find a PapxInFkp at offset of + 2*BxPap.bOffset
        let bxPap = papxFkp.rgbx[k]
        
        var papxInFkpDataStream = DataStream(wordDocumentStream.data)
        let papxInFkpOffset = of + 2 * UInt32(bxPap.bOffset)
        if papxInFkpOffset > papxInFkpDataStream.count {
            throw OfficeFileError.corrupted
        }
        
        papxInFkpDataStream.position = Int(papxInFkpOffset)
        let papxInFkp = try PapxInFkp(dataStream: &papxInFkpDataStream)
        
        /// 3. Find a GrpprlAndIstd in the PapxInFkp from step 2. The offset and size of the GrpprlAndIstd is instructed by the first byte of
        /// the PapxInFkp, as detailed at PapxInFkp.
        let grpPrlAndIstd = papxInFkp.grpprlInPapx
        
        /// 4. Find the grpprl within the GrpprlAndIstd. This is an array of Prl elements that specifies the direct properties of this paragraph.
        var result = grpPrlAndIstd.grpprl
        
        /// 5. Finally Pcd.Prm specifies further property modifications that apply to this paragraph. If Pcd.Prm is a Prm0 and the Sprm
        /// specified within Prm0 modifies a paragraph property, append to the array of Prl elements from the previous step a single Prl
        /// made of the Sprm and value in Prm0. if Pcd.Prm is a Prm1, append to the array of Prl elements from the previous step any Sprm
        /// structures that modify paragraph properties within the array of Prl elements specified by Prm1.
        try apply(clx: clx, pcd: pcd, to: &result)
        
        return result
    }
    
    public func getCharacterFormatting(characterPosition: CP) throws -> [Prl]? {
        /// [MS-DOC] 2.4.6.2 Direct Character Formatting
        /// This section specifies how to find the properties applied directly to a given character position cp. The result will be an array of Prl
        /// elements that specify the property modifications to be applied.
        /// Additional formatting and properties can affect that cp as well, if a style is applied. To determine the full set of properties, including
        /// those from styles, see section 2.4.6.6 Determining Formatting Properties.
        /// 1. Follow the algorithm from Retrieving Text. From step 5 or 6, determine the offset in the WordDocument Stream where text was
        /// found. Call this offset fc. Also remember from step 4, the Pcd. If the algorithm from Retrieving Text specifies cp is invalid, leave
        /// the algorithm.
        guard let clx = self.clx else {
            return nil
        }

        guard let (pcdIndex, fc) = try getTextOffset(clx: clx, characterPosition: characterPosition) else {
            return nil
        }
        
        let pcd = clx.pcdt.plcPcd.aPcd[pcdIndex]
        
        /// 2. Read a PlcBteChpx at offset FibRgFcLcb97.fcPlcfBteChpx in the Table Stream, and of size FibRgFcLcb97.lcbPlcfBteChpx.
        guard let plcBteChpx = self.plcfBteChpx else {
            return nil
        }
        
        /// 3. Find the largest i such that plcbteChpx.aFc[i] ≤ fc. If the last element of plcbteChpx.aFc is less than or equal to fc, then cp
        /// is outside the range of character positions in this document, and is not valid. Read a ChpxFkp at offset aPnBteChpx[i].pn *512
        /// in the WordDocument Stream.
        guard let i = plcBteChpx.aFC.lastIndex(where: { $0 <= fc }) else {
            return nil
        }
        
        var chpxFkpDataStream = DataStream(wordDocumentStream.data)
        let chpxFkpOffset = plcBteChpx.aPnBteChpx[i].pn * 512
        if chpxFkpOffset > chpxFkpDataStream.count {
            throw OfficeFileError.corrupted
        }
        
        chpxFkpDataStream.position = Int(chpxFkpOffset)
        let chpxFkp = try ChpxFkp(dataStream: &chpxFkpDataStream)
        
        /// 4. Find the largest j such that ChpxFkp.rgfc[j] ≤ fc. If the last element of ChpxFkp.rgfc is less than or equal to fc, then cp is
        /// outside the range of character positions in this document, and is not valid. Find a Chpx at offset ChpxFkp.rgb[i] in ChpxFkp.
        guard let j = chpxFkp.rgfc.lastIndex(where: { $0 <= fc }) else {
            return nil
        }
        
        let chpx = chpxFkp.rgb.1[j]
        
        /// 5. The grpprl within the Chpx is an array of Prls that specifies the direct properties of this character.
        var result = chpx.grpprl
        
        /// 6. Additionally, apply Pcd.Prm which specifies additional properties for this text. If Pcd.Prm is a Prm0 and the Sprm specified within
        /// Prm0 modifies a character property (a Sprm with an sgc value of 2), append a single Prl made of the Sprm and value in that Prm0
        /// to the array of Prls from the previous step. If Pcd.Prm is a Prm1, append any Sprms that modify character properties from the
        /// array of Prls specified by Prm1.
        try apply(clx: clx, pcd: pcd, to: &result)

        return result
    }
    
    private func apply(clx: Clx, pcd: Pcd, to result: inout [Prl]) throws {
        switch pcd.prm {
        case .simple(let data):
            if data.isprm != 0, let sprm = data.sprm, sprm.sgc == .character {
                let prl = Prl(sprm: sprm, operand: [data.val])
                result.append(prl)
            }
        case .complex(let data):
            if data.igrpprl >= clx.rgPrc.count {
                throw OfficeFileError.corrupted
            }

            result += clx.rgPrc[Int(data.igrpprl)].data.grpPrl.filter { $0.sprm.sgc == .character }
        }
    }
    
    public func getParagraphListFormatting(characterPosition: CP) throws {
        /// [MS-DOC] 2.4.6.3 Determining List Formatting of a Paragraph
        /// A list in an MS-DOC file consists of one or more paragraphs. Each paragraph in a list has a nonzero iLfo property (see sprmPIlfo)
        /// and an iLvl property (see sprmPIlvl), which are used to determine the information that is necessary to format the paragraph as a
        /// member in a specific list. Paragraphs that share the same iLfo property, and exist in a range of text that constitutes a Valid
        /// Selection, are considered to be part of the same list. Paragraphs in a list do not need to be consecutive, and a list can overlap
        /// with other lists. This section describes an algorithm to add list formatting to a paragraph containing a given character position.
        /// Given character position cp, use the following three-part algorithm to add list formatting to the paragraph containing cp.
        /// Part 1
        /// 1. Follow the procedure for determining formatting properties, as specified in section 2.4.6.6, to find the paragraph properties for
        /// the paragraph that cp belongs to.
        fatalError("NYI")
    }
    
    public func getParagraphLevelNumber(characterPosition: CP) throws {
        
        /// [MS-DOC] 2.4.6.4 Determining Level Number of a Paragraph
        /// The level number of a paragraph is the number in the number sequence of the level that corresponds to that paragraph, formatted
        /// according to an MSONFC (as specified in [MS-OSHARED] section 2.2.1.3). The number sequence of a level begins at a specified value
        /// and increments by 1 for each paragraph in the level. Also, the number sequence of a level can restart when certain other levels are
        /// encountered. See the specification of LVLF for more information. This section describes an algorithm to determine the level number
        /// of a paragraph containing a given character position.
        /// Given character position cp, use the following algorithm to determine the level number of the paragraph containing cp:
        fatalError("NYI")
    }
    
    public func getStyleProperties(istd: UInt16) throws -> [Prl]? {
        /// [MS-DOC] 2.4.6.5 Determining Properties of a Style
        /// This section specifies an algorithm to determine the set of properties to apply to text, a paragraph, a table, or a list when a particular
        /// style is applied to it. Given an istd, one or more arrays of Prl can be derived that express the differences from defaults for this style.
        /// Depending on its stk, a style can specify properties for any combination of tables, paragraphs, and characters.
        /// Given an istd:
        /// 1. Read the FIB from offset zero in the WordDocument Stream.
        /// 2. All versions of the FIB contain exactly one FibRgFcLcb97 though it can be nested in a larger structure. Read a STSH from offset
        /// FibRgFcLcb97.fcStshf in the Table Stream with size FibRgFcLcb97.lcbStshf.
        guard let stshf = self.stshf else {
            return nil
        }
        
        /// 3. The given istd is a zero-based index into STSH.rglpstd. Read an LPStd at STSH.rglpstd[istd].
        let lpstd = stshf.rglpstd[Int(istd)]
        
        /// 4. Read the STD structure as LPStd.std, of length LPStd.cbStd bytes.
        guard let std = lpstd.std else {
            return nil
        }
        
        /// 5. From the STD.stdf.stdfBase obtain istdBase. If istdBase is any value other than 0x0FFF, then this style is based on another style.
        /// Recursively apply this algorithm using istdBase as the starting istd to obtain one or more arrays of Prls as the properties for tables,
        /// paragraphs and characters from the base style.
        let iStdBase = std.stdf.stdfBase.istdBase
        var result: [Prl] = []
        if iStdBase != 0x0FFF, let inheritedStyles = try getStyleProperties(istd: iStdBase) {
            result += inheritedStyles
        }
        
        /// 6. From the STD.stdf.stdfBase obtain stk. For more information, see the description of the cupx member of StdfBase. Read an
        /// STD.grLPUpxSw. Based on the stk, grLPUpxSw contains one of the following structures: StkParaGRLPUPX, StkCharGRLPUPX,
        /// StkTableGRLPUPX, StkListGRLPUPX.
        /// 7. Each of the preceding structures contains one or more of the following: LPUpxPapx, LPUpxChpx, LPUpxTapx. Each of the latter
        /// structures leads to one or more arrays of Prl that specify properties.
        /// For more information, see the sections documenting these structures for how to obtain these arrays.
        /// 8. For each array obtained in step 7 that specifies properties of a table, paragraph, or characters, append to the beginning of the
        /// corresponding array from step 5, if any. The resulting arrays of Prl are the desired output. Leave the algorithm.
        switch std.grLPUpxSw {
        case .char(let data):
            if let grpprlChpx = data.lpUpxChpx?.chpx.grpprlChpx {
                result += grpprlChpx
            }
        case .para(let data):
            if let grpprlChpx = data.lpUpxChpx?.chpx.grpprlChpx {
                result += grpprlChpx
            }
            if let grpprlPapx = data.lpUpxPapx?.papx.grpprlPapx {
                result += grpprlPapx
            }
        case .table(let data):
            if let grpprlChpx = data.lpUpxChpx?.chpx.grpprlChpx {
                result += grpprlChpx
            }
            if let grpprlPapx = data.lpUpxPapx?.papx.grpprlPapx {
                result += grpprlPapx
            }
            if let grpprlTapx = data.lpUpxTapx?.tapx.grpprlTapx {
                result += grpprlTapx
            }
        case .list(let data):
            if let grpprlPapx = data.lpUpxPapx?.papx.grpprlPapx {
                result += grpprlPapx
            }
        }
        
        return result
    }
    
    public func getFormattingProperties(characterPosition: CP) throws -> Any? {
        /// [MS-DOC] 2.4.6.6 Determining Formatting Properties
        /// This section specifies an algorithm for how to combine properties from various sources that influence the properties of a character
        /// position to obtain the final formatting.
        /// Character, paragraph, and table properties of the text at any given character position are specified by lists of differences from the
        /// defaults. Property Storage explains how to determine defaults and how to apply property differences. This section further specifies
        /// which lists of property differences are applicable and the order in which they apply.
        /// In general, the differences from defaults are specified by one or more styles as well as any directly applied property modifications.
        /// Multiple styles can influence the properties at a given character position. A table style, for example, can specify paragraph
        /// properties that apply to some or all paragraphs within that table. A paragraph in such a table can itself have a paragraph style,
        /// in which case two different lists of differences modify the properties of said paragraph.
        /// Given character position cp, use the following algorithm to determine the properties of text at cp:
        /// Part 1:
        /// 1. Determine defaults for all properties the application is interested in. For further specification, see Property Storage.
        /// 2. Split the properties into three groups based on the objects they apply to: paragraph properties, character properties, and table
        /// properties as specified by Single Property Modifies. These are the set of properties which will be modified throughout the algorithm
        /// to arrive at the desired properties.
        /// 3. All versions of the FIB contain exactly one FibRgFcLcb97 though it can be nested in a larger structure. Read an STSH from
        /// offset FibRgFcLcb97.fcStshf in the Table Stream, with size FibRgFcLcb97.lcbStshf. From the STSH, obtain an LPStshi and from
        /// that obtain an STSHI
        guard let stshf = self.stshf else {
            return nil
        }
        
        let stshi = stshf.lpstshi.stshi
        
        /// 4. Apply the property modifications specified by the ftcAsci, ftcFE and ftcOther members of the STSHI.Stshif along with the ftcBi
        /// member of STSHI if specified.
        
        /// 5. Determine whether cp is in a table or not. For further specification, see Determining Cell Boundaries. If cp is not in a table, go to
        /// step 1 of part 2.
        fatalError("NYI: \(stshi)")
    }
    
    public lazy var macros: VBAFile? = try? {
        guard let storage = self.compoundFile.rootStorage.children["Macros"] else {
            return nil
        }
        
        return try VBAFile(storage: storage)
    }()
    
    public lazy var compObjStream: CompObjStream? = try? {
        guard let storage = self.compoundFile.rootStorage.children["\u{0001}CompObj"] else {
            return nil
        }
        
        var dataStream = storage.dataStream
        return try CompObjStream(dataStream: &dataStream, count: dataStream.count)
    }()
    
    public lazy var objectPool: ObjectPool? = try? {
        guard let storage = self.compoundFile.rootStorage.children["ObjectPool"] else {
            return nil
        }
        
        return try ObjectPool(storage: storage)
    }()
}
