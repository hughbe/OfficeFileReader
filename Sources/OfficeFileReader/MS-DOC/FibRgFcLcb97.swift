//
//  FibRgFcLcb97.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.6 FibRgFcLcb97
/// The FibRgFcLcb97 structure is a variable-length portion of the Fib.
public struct FibRgFcLcb97 {
    public let fcStshfOrig: UInt32
    public let lcbStshfOrig: UInt32
    public let fcStshf: UInt32
    public let lcbStshf: UInt32
    public let fcPlcffndRef: UInt32
    public let lcbPlcffndRef: UInt32
    public let fcPlcffndTxt: UInt32
    public let lcbPlcffndTxt: UInt32
    public let fcPlcfandRef: UInt32
    public let lcbPlcfandRef: UInt32
    public let fcPlcfandTxt: UInt32
    public let lcbPlcfandTxt: UInt32
    public let fcPlcfSed: UInt32
    public let lcbPlcfSed: UInt32
    public let fcPlcPad: UInt32
    public let lcbPlcPad: UInt32
    public let fcPlcfPhe: UInt32
    public let lcbPlcfPhe: UInt32
    public let fcSttbfGlsy: UInt32
    public let lcbSttbfGlsy: UInt32
    public let fcPlcfGlsy: UInt32
    public let lcbPlcfGlsy: UInt32
    public let fcPlcfHdd: UInt32
    public let lcbPlcfHdd: UInt32
    public let fcPlcfBteChpx: UInt32
    public let lcbPlcfBteChpx: UInt32
    public let fcPlcfBtePapx: UInt32
    public let lcbPlcfBtePapx: UInt32
    public let fcPlcfSea: UInt32
    public let lcbPlcfSea: UInt32
    public let fcSttbfFfn: UInt32
    public let lcbSttbfFfn: UInt32
    public let fcPlcfFldMom: UInt32
    public let lcbPlcfFldMom: UInt32
    public let fcPlcfFldHdr: UInt32
    public let lcbPlcfFldHdr: UInt32
    public let fcPlcfFldFtn: UInt32
    public let lcbPlcfFldFtn: UInt32
    public let fcPlcfFldAtn: UInt32
    public let lcbPlcfFldAtn: UInt32
    public let fcPlcfFldMcr: UInt32
    public let lcbPlcfFldMcr: UInt32
    public let fcSttbfBkmk: UInt32
    public let lcbSttbfBkmk: UInt32
    public let fcPlcfBkf: UInt32
    public let lcbPlcfBkf: UInt32
    public let fcPlcfBkl: UInt32
    public let lcbPlcfBkl: UInt32
    public let fcCmds: UInt32
    public let lcbCmds: UInt32
    public let fcUnused1: UInt32
    public let lcbUnused1: UInt32
    public let fcSttbfMcr: UInt32
    public let lcbSttbfMcr: UInt32
    public let fcPrDrvr: UInt32
    public let lcbPrDrvr: UInt32
    public let fcPrEnvPort: UInt32
    public let lcbPrEnvPort: UInt32
    public let fcPrEnvLand: UInt32
    public let lcbPrEnvLand: UInt32
    public let fcWss: UInt32
    public let lcbWss: UInt32
    public let fcDop: UInt32
    public let lcbDop: UInt32
    public let fcSttbfAssoc: UInt32
    public let lcbSttbfAssoc: UInt32
    public let fcClx: UInt32
    public let lcbClx: UInt32
    public let fcPlcfPgdFtn: UInt32
    public let lcbPlcfPgdFtn: UInt32
    public let fcAutosaveSource: UInt32
    public let lcbAutosaveSource: UInt32
    public let fcGrpXstAtnOwners: UInt32
    public let lcbGrpXstAtnOwners: UInt32
    public let fcSttbfAtnBkmk: UInt32
    public let lcbSttbfAtnBkmk: UInt32
    public let fcUnused2: UInt32
    public let lcbUnused2: UInt32
    public let fcUnused3: UInt32
    public let lcbUnused3: UInt32
    public let fcPlcSpaMom: UInt32
    public let lcbPlcSpaMom: UInt32
    public let fcPlcSpaHdr: UInt32
    public let lcbPlcSpaHdr: UInt32
    public let fcPlcfAtnBkf: UInt32
    public let lcbPlcfAtnBkf: UInt32
    public let fcPlcfAtnBkl: UInt32
    public let lcbPlcfAtnBkl: UInt32
    public let fcPms: UInt32
    public let lcbPms: UInt32
    public let fcFormFldSttbs: UInt32
    public let lcbFormFldSttbs: UInt32
    public let fcPlcfendRef: UInt32
    public let lcbPlcfendRef: UInt32
    public let fcPlcfendTxt: UInt32
    public let lcbPlcfendTxt: UInt32
    public let fcPlcfFldEdn: UInt32
    public let lcbPlcfFldEdn: UInt32
    public let fcUnused4: UInt32
    public let lcbUnused4: UInt32
    public let fcDggInfo: UInt32
    public let lcbDggInfo: UInt32
    public let fcSttbfRMark: UInt32
    public let lcbSttbfRMark: UInt32
    public let fcSttbfCaption: UInt32
    public let lcbSttbfCaption: UInt32
    public let fcSttbfAutoCaption: UInt32
    public let lcbSttbfAutoCaption: UInt32
    public let fcPlcfWkb: UInt32
    public let lcbPlcfWkb: UInt32
    public let fcPlcfSpl: UInt32
    public let lcbPlcfSpl: UInt32
    public let fcPlcftxbxTxt: UInt32
    public let lcbPlcftxbxTxt: UInt32
    public let fcPlcfFldTxbx: UInt32
    public let lcbPlcfFldTxbx: UInt32
    public let fcPlcfHdrtxbxTxt: UInt32
    public let lcbPlcfHdrtxbxTxt: UInt32
    public let fcPlcffldHdrTxbx: UInt32
    public let lcbPlcffldHdrTxbx: UInt32
    public let fcStwUser: UInt32
    public let lcbStwUser: UInt32
    public let fcSttbTtmbd: UInt32
    public let lcbSttbTtmbd: UInt32
    public let fcCookieData: UInt32
    public let lcbCookieData: UInt32
    public let fcPgdMotherOldOld: UInt32
    public let lcbPgdMotherOldOld: UInt32
    public let fcBkdMotherOldOld: UInt32
    public let lcbBkdMotherOldOld: UInt32
    public let fcPgdFtnOldOld: UInt32
    public let lcbPgdFtnOldOld: UInt32
    public let fcBkdFtnOldOld: UInt32
    public let lcbBkdFtnOldOld: UInt32
    public let fcPgdEdnOldOld: UInt32
    public let lcbPgdEdnOldOld: UInt32
    public let fcBkdEdnOldOld: UInt32
    public let lcbBkdEdnOldOld: UInt32
    public let fcSttbfIntlFld: UInt32
    public let lcbSttbfIntlFld: UInt32
    public let fcRouteSlip: UInt32
    public let lcbRouteSlip: UInt32
    public let fcSttbSavedBy: UInt32
    public let lcbSttbSavedBy: UInt32
    public let fcSttbFnm: UInt32
    public let lcbSttbFnm: UInt32
    public let fcPlfLst: UInt32
    public let lcbPlfLst: UInt32
    public let fcPlfLfo: UInt32
    public let lcbPlfLfo: UInt32
    public let fcPlcfTxbxBkd: UInt32
    public let lcbPlcfTxbxBkd: UInt32
    public let fcPlcfTxbxHdrBkd: UInt32
    public let lcbPlcfTxbxHdrBkd: UInt32
    public let fcDocUndoWord9: UInt32
    public let lcbDocUndoWord9: UInt32
    public let fcRgbUse: UInt32
    public let lcbRgbUse: UInt32
    public let fcUsp: UInt32
    public let lcbUsp: UInt32
    public let fcUskf: UInt32
    public let lcbUskf: UInt32
    public let fcPlcupcRgbUse: UInt32
    public let lcbPlcupcRgbUse: UInt32
    public let fcPlcupcUsp: UInt32
    public let lcbPlcupcUsp: UInt32
    public let fcSttbGlsyStyle: UInt32
    public let lcbSttbGlsyStyle: UInt32
    public let fcPlgosl: UInt32
    public let lcbPlgosl: UInt32
    public let fcPlcocx: UInt32
    public let lcbPlcocx: UInt32
    public let fcPlcfBteLvc: UInt32
    public let lcbPlcfBteLvc: UInt32
    public let dwLowDateTime: UInt32
    public let dwHighDateTime: UInt32
    public let fcPlcfLvcPre10: UInt32
    public let lcbPlcfLvcPre10: UInt32
    public let fcPlcfAsumy: UInt32
    public let lcbPlcfAsumy: UInt32
    public let fcPlcfGram: UInt32
    public let lcbPlcfGram: UInt32
    public let fcSttbListNames: UInt32
    public let lcbSttbListNames: UInt32
    public let fcSttbfUssr: UInt32
    public let lcbSttbfUssr: UInt32
    
    public init(dataStream: inout DataStream, fibBase: FibBase, fibRgLw97: FibRgLw97) throws {
        /// fcStshfOrig (4 bytes): This value is undefined and MUST be ignored.
        self.fcStshfOrig = try dataStream.read(endianess: .littleEndian)
        
        /// lcbStshfOrig (4 bytes): This value is undefined and MUST be ignored.
        self.lcbStshfOrig = try dataStream.read(endianess: .littleEndian)
        
        /// fcStshf (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An STSH that specifies the style sheet for this
        /// document begins at this offset.
        self.fcStshf = try dataStream.read(endianess: .littleEndian)
        
        /// lcbStshf (4 bytes): An unsigned integer that specifies the size, in bytes, of the STSH that begins at offset fcStshf in the Table Stream.
        /// This MUST be a nonzero value.
        self.lcbStshf = try dataStream.read(endianess: .littleEndian)
        if self.lcbStshf == 0 {
            throw OfficeFileError.corrupted
        }
        
        /// fcPlcffndRef (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcffndRef begins at this offset and
        /// specifies the locations of footnote references in the Main Document, and whether those references use auto-numbering or custom
        /// symbols. If lcbPlcffndRef is zero, fcPlcffndRef is undefined and MUST be ignored.
        self.fcPlcffndRef = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcffndRef (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcffndRef that begins at offset fcPlcffndRef in the
        /// Table Stream.
        self.lcbPlcffndRef = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcffndTxt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcffndTxt begins at this offset and specifies
        /// the locations of each block of footnote text in the Footnote Document. If lcbPlcffndTxt is zero, fcPlcffndTxt is undefined and MUST
        /// be ignored.
        self.fcPlcffndTxt = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcffndTxt (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcffndTxt that begins at offset fcPlcffndTxt in the
        /// Table Stream. lcbPlcffndTxt MUST be zero if FibRgLw97.ccpFtn is zero, and MUST be nonzero if FibRgLw97.ccpFtn is nonzero.
        let lcbPlcffndTxt: UInt32 = try dataStream.read(endianess: .littleEndian)
        if fibRgLw97.ccpFtn == 0 && lcbPlcffndTxt != 0 {
            throw OfficeFileError.corrupted
        } else if fibRgLw97.ccpFtn != 0 && lcbPlcffndTxt == 0 {
            throw OfficeFileError.corrupted
        }
        
        self.lcbPlcffndTxt = lcbPlcffndTxt
        
        /// fcPlcfandRef (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfandRef begins at this offset and
        /// specifies the dates, user initials, and locations of comments in the Main Document. If lcbPlcfandRef is zero, fcPlcfandRef is
        /// undefined and MUST be ignored.
        self.fcPlcfandRef = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfandRef (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfandRef at offset fcPlcfandRef in the Table
        /// Stream.
        self.lcbPlcfandRef = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfandTxt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfandTxt begins at this offset and
        /// specifies the locations of comment text ranges in the Comment Document. If lcbPlcfandTxt is zero, fcPlcfandTxt is undefined,
        /// and MUST be ignored.
        self.fcPlcfandTxt = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfandTxt (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfandTxt at offset fcPlcfandTxt in the Table
        /// Stream. lcbPlcfandTxt MUST be zero if FibRgLw97.ccpAtn is zero, and MUST be nonzero if FibRgLw97.ccpAtn is nonzero.
        let lcbPlcfandTxt: UInt32 = try dataStream.read(endianess: .littleEndian)
        if fibRgLw97.ccpAtn == 0 && lcbPlcfandTxt != 0 {
            throw OfficeFileError.corrupted
        } else if fibRgLw97.ccpAtn != 0 && lcbPlcfandTxt == 0 {
            throw OfficeFileError.corrupted
        }
        
        self.lcbPlcfandTxt = lcbPlcfandTxt
        
        /// fcPlcfSed (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfSed begins at this offset and specifies
        /// the locations of property lists for each section in the Main Document. If lcbPlcfSed is zero, fcPlcfSed is undefined and MUST be ignored.
        self.fcPlcfSed = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfSed (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfSed that begins at offset fcPlcfSed in the Table
        /// Stream.
        self.lcbPlcfSed = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcPad (4 bytes): This value is undefined and MUST be ignored.
        self.fcPlcPad = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcPad (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbPlcPad = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfPhe (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Plc begins at this offset and specifies
        /// version-specific information about paragraph height. This Plc SHOULD NOT<27> be emitted and SHOULD<28> be ignored.
        self.fcPlcfPhe = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfPhe (4 bytes): An unsigned integer that specifies the size, in bytes, of the Plc at offset fcPlcfPhe in the Table Stream.
        self.lcbPlcfPhe = try dataStream.read(endianess: .littleEndian)
        
        /// fcSttbfGlsy (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A SttbfGlsy that contains information about
        /// the AutoText items that are defined in this document begins at this offset.
        self.fcSttbfGlsy = try dataStream.read(endianess: .littleEndian)
        
        /// lcbSttbfGlsy (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfGlsy at offset fcSttbfGlsy in the Table Stream.
        /// If base.fGlsy of the Fib that contains this FibRgFcLcb97 is zero, this value MUST be zero.
        let lcbSttbfGlsy: UInt32 = try dataStream.read(endianess: .littleEndian)
        if !fibBase.fGlsy && lcbSttbfGlsy != 0 {
            throw OfficeFileError.corrupted
        }
        
        self.lcbSttbfGlsy = lcbSttbfGlsy
        
        /// fcPlcfGlsy (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfGlsy that contains information about the
        /// AutoText items that are defined in this document begins at this offset.
        self.fcPlcfGlsy = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfGlsy (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfGlsy at offset fcPlcfGlsy in the Table Stream.
        /// If base.fGlsy of the Fib that contains this FibRgFcLcb97 is zero, this value MUST be zero.
        self.lcbPlcfGlsy = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfHdd (4 bytes): An unsigned integer that specifies the offset in the Table Stream where a Plcfhdd begins. The Plcfhdd specifies
        /// the locations of each block of header/footer text in the WordDocument Stream. If lcbPlcfHdd is 0, fcPlcfHdd is undefined and MUST
        /// be ignored.
        self.fcPlcfHdd = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfHdd (4 bytes): An unsigned integer that specifies the size, in bytes, of the Plcfhdd at offset fcPlcfHdd in the Table Stream.
        /// If there is no Plcfhdd, this value MUST be zero. A Plcfhdd MUST exist if FibRgLw97.ccpHdd indicates that there are characters in
        /// the Header Document (that is, if FibRgLw97.ccpHdd is greater than 0). Otherwise, the Plcfhdd MUST NOT exist.
        self.lcbPlcfHdd = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfBteChpx (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcBteChpx begins at the offset.
        /// fcPlcfBteChpx MUST be greater than zero, and MUST be a valid offset in the Table Stream.
        self.fcPlcfBteChpx = try dataStream.read(endianess: .littleEndian)
        if self.fcPlcfBteChpx == 0 {
            throw OfficeFileError.corrupted
        }
        
        /// lcbPlcfBteChpx (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcBteChpx at offset fcPlcfBteChpx in the
        /// Table Stream. lcbPlcfBteChpx MUST be greater than zero.
        self.lcbPlcfBteChpx = try dataStream.read(endianess: .littleEndian)
        if self.lcbPlcfBteChpx == 0 {
            throw OfficeFileError.corrupted
        }
        
        /// fcPlcfBtePapx (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcBtePapx begins at the offset.
        /// fcPlcfBtePapx MUST be greater than zero, and MUST be a valid offset in the Table Stream.
        self.fcPlcfBtePapx = try dataStream.read(endianess: .littleEndian)
        if self.fcPlcfBtePapx == 0 {
            throw OfficeFileError.corrupted
        }
        
        /// lcbPlcfBtePapx (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcBtePapx at offset fcPlcfBtePapx in the
        /// Table Stream. lcbPlcfBteChpx MUST be greater than zero.
        self.lcbPlcfBtePapx = try dataStream.read(endianess: .littleEndian)
        if self.lcbPlcfBtePapx == 0 {
            throw OfficeFileError.corrupted
        }
        
        /// fcPlcfSea (4 bytes): This value is undefined and MUST be ignored.
        self.fcPlcfSea = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfSea (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbPlcfSea = try dataStream.read(endianess: .littleEndian)
        
        /// fcSttbfFfn (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfFfn begins at this offset. This table
        /// specifies the fonts that are used in the document. If lcbSttbfFfn is 0, fcSttbfFfn is undefined and MUST be ignored.
        self.fcSttbfFfn = try dataStream.read(endianess: .littleEndian)
        
        /// lcbSttbfFfn (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfFfn at offset fcSttbfFfn in the Table Stream.
        self.lcbSttbfFfn = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfFldMom (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcFld begins at this offset and specifies
        /// the locations of field characters in the Main Document. All CPs in this PlcFld MUST be greater than or equal to 0 and less than or
        /// equal to FibRgLw97.ccpText. If lcbPlcfFldMom is zero, fcPlcfFldMom is undefined and MUST be ignored.
        self.fcPlcfFldMom = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfFldMom (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcFld at offset fcPlcfFldMom in the Table Stream.
        self.lcbPlcfFldMom = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfFldHdr (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcFld begins at this offset and specifies
        /// the locations of field characters in the Header Document. All CPs in this PlcFld are relative to the starting position of the Header
        /// Document. All CPs in this PlcFld MUST be greater than or equal to zero and less than or equal to FibRgLw97.ccpHdd. If lcbPlcfFldHdr
        /// is zero, fcPlcfFldHdr is undefined and MUST be ignored.
        self.fcPlcfFldHdr = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfFldHdr (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcFld at offset fcPlcfFldHdr in the Table Stream.
        self.lcbPlcfFldHdr = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfFldFtn (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcFld begins at this offset and specifies
        /// the locations of field characters in the Footnote Document. All CPs in this PlcFld are relative to the starting position of the Footnote
        /// Document. All CPs in this PlcFld MUST be greater than or equal to zero and less than or equal to FibRgLw97.ccpFtn. If
        /// lcbPlcfFldFtn is zero, fcPlcfFldFtn is undefined, and MUST be ignored.
        self.fcPlcfFldFtn = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfFldFtn (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcFld at offset fcPlcfFldFtn in the Table Stream.
        self.lcbPlcfFldFtn = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfFldAtn (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcFld begins at this offset and specifies
        /// the locations of field characters in the Comment Document. All CPs in this PlcFld are relative to the starting position of the Comment
        /// Document. All CPs in this PlcFld MUST be greater than or equal to zero and less than or equal to FibRgLw97.ccpAtn. If
        /// lcbPlcfFldAtn is zero, fcPlcfFldAtn is undefined and MUST be ignored.
        self.fcPlcfFldAtn = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfFldAtn (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcFld at offset fcPlcfFldAtn in the Table Stream.
        self.lcbPlcfFldAtn = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfFldMcr (4 bytes): This value is undefined and MUST be ignored.
        self.fcPlcfFldMcr = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfFldMcr (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbPlcfFldMcr = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfBkmk (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfBkmk that contains the names of the
        /// bookmarks in the document begins at this offset. If lcbSttbfBkmk is zero, fcSttbfBkmk is undefined and MUST be ignored.
        /// This SttbfBkmk is parallel to the PlcfBkf at offset fcPlcfBkf in the Table Stream. Each string specifies the name of the bookmark that
        /// is associated with the data element which is located at the same offset in that PlcfBkf. For this reason, the SttbfBkmk that begins at
        /// offset fcSttbfBkmk, and the PlcfBkf that begins at offset fcPlcfBkf, MUST contain the same number of elements.
        self.fcSttbfBkmk = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfBkmk (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfBkmk at offset fcSttbfBkmk.
        self.lcbSttbfBkmk = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBkf (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfBkf that contains information about
        /// the standard bookmarks in the document begins at this offset. If lcbPlcfBkf is zero, fcPlcfBkf is undefined and MUST be ignored.
        /// Each data element in the PlcfBkf is associated, in a one-to-one correlation, with a data element in the PlcfBkl at offset fcPlcfBkl.
        /// For this reason, the PlcfBkf that begins at offset fcPlcfBkf, and the PlcfBkl that begins at offset fcPlcfBkl, MUST contain the same
        /// number of data elements. This PlcfBkf is parallel to the SttbfBkmk at offset fcSttbfBkmk in the Table Stream. Each data element
        /// in the PlcfBkf specifies information about the bookmark that is associated with the element which is located at the same offset in
        /// that SttbfBkmk. For this reason, the PlcfBkf that begins at offset fcPlcfBkf, and the SttbfBkmk that begins at offset fcSttbfBkmk,
        /// MUST contain the same number of elements.
        /// The largest value that a CP marking the start or end of a standard bookmark is allowed to have is the CP representing the end of
        /// all document parts.
        self.fcPlcfBkf = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfBkf (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfBkf at offset fcPlcfBkf.
        self.lcbPlcfBkf = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBkl (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfBkl that contains information about the
        /// standard bookmarks in the document begins at this offset. If lcbPlcfBkl is zero, fcPlcfBkl is undefined and MUST be ignored.
        /// Each data element in the PlcfBkl is associated, in a one-to-one correlation, with a data element in the PlcfBkf at offset fcPlcfBkf.
        /// For this reason, the PlcfBkl that begins at offset fcPlcfBkl, and the PlcfBkf that begins at offset fcPlcfBkf, MUST contain the same
        /// number of data elements.
        /// The largest value that a CP marking the start or end of a standard bookmark is allowed to have is the value of the CP representing
        /// the end of all document parts.
        self.fcPlcfBkl = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBkl (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfBkl at offset fcPlcfBkl.
        self.lcbPlcfBkl = try dataStream.read(endianess: .littleEndian)

        /// fcCmds (4 bytes): An unsigned integer that specifies the offset in the Table Stream of a Tcg that specifies command-related
        /// customizations. If lcbCmds is zero, fcCmds is undefined and MUST be ignored.
        self.fcCmds = try dataStream.read(endianess: .littleEndian)

        /// lcbCmds (4 bytes): An unsigned integer that specifies the size, in bytes, of the Tcg at offset fcCmds.
        self.lcbCmds = try dataStream.read(endianess: .littleEndian)

        /// fcUnused1 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused1 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused1 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused1 = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfMcr (4 bytes): This value is undefined and MUST be ignored.
        self.fcSttbfMcr = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfMcr (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbSttbfMcr = try dataStream.read(endianess: .littleEndian)

        /// fcPrDrvr (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The PrDrvr, which contains printer driver
        /// information (the names of drivers, port, and so on), begins at this offset. If lcbPrDrvr is zero, fcPrDrvr is undefined and MUST
        /// be ignored.
        self.fcPrDrvr = try dataStream.read(endianess: .littleEndian)

        /// lcbPrDrvr (4 bytes): An unsigned integer that specifies the size, in bytes, of the PrDrvr at offset fcPrDrvr.
        self.lcbPrDrvr = try dataStream.read(endianess: .littleEndian)

        /// fcPrEnvPort (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The PrEnvPort that is the print environment
        /// in portrait mode begins at this offset. If lcbPrEnvPort is zero, fcPrEnvPort is undefined and MUST be ignored.
        self.fcPrEnvPort = try dataStream.read(endianess: .littleEndian)

        /// lcbPrEnvPort (4 bytes): An unsigned integer that specifies the size, in bytes, of the PrEnvPort at offset fcPrEnvPort.
        self.lcbPrEnvPort = try dataStream.read(endianess: .littleEndian)

        /// fcPrEnvLand (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The PrEnvLand that is the print environment
        /// in landscape mode begins at this offset. If lcbPrEnvLand is zero, fcPrEnvLand is undefined and MUST be ignored.
        self.fcPrEnvLand = try dataStream.read(endianess: .littleEndian)

        /// lcbPrEnvLand (4 bytes): An unsigned integer that specifies the size, in bytes, of the PrEnvLand at offset fcPrEnvLand.
        self.lcbPrEnvLand = try dataStream.read(endianess: .littleEndian)

        /// fcWss (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Selsf begins at this offset and specifies the last
        /// selection that was made in the Main Document. If lcbWss is zero, fcWss is undefined and MUST be ignored.
        self.fcWss = try dataStream.read(endianess: .littleEndian)

        /// lcbWss (4 bytes): An unsigned integer that specifies the size, in bytes, of the Selsf at offset fcWss.
        self.lcbWss = try dataStream.read(endianess: .littleEndian)

        /// fcDop (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Dop begins at this offset.
        self.fcDop = try dataStream.read(endianess: .littleEndian)

        /// lcbDop (4 bytes): An unsigned integer that specifies the size, in bytes, of the Dopat fcDop. This value MUST NOT be zero.
        self.lcbDop = try dataStream.read(endianess: .littleEndian)
        if self.lcbDop == 0 {
            throw OfficeFileError.corrupted
        }

        /// fcSttbfAssoc (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfAssoc that contains strings that
        /// are associated with the document begins at this offset.
        self.fcSttbfAssoc = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfAssoc (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfAssoc at offset fcSttbfAssoc. This value
        /// MUST NOT be zero.
        self.lcbSttbfAssoc = try dataStream.read(endianess: .littleEndian)

        /// fcClx (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Clx begins at this offset.
        self.fcClx = try dataStream.read(endianess: .littleEndian)

        /// lcbClx (4 bytes): An unsigned integer that specifies the size, in bytes, of the Clx at offset fcClx in the Table Stream. This value
        /// MUST be greater than zero.
        self.lcbClx = try dataStream.read(endianess: .littleEndian)
        if self.lcbClx == 0 {
            throw OfficeFileError.corrupted
        }

        /// fcPlcfPgdFtn (4 bytes): This value is undefined and MUST be ignored.
        self.fcPlcfPgdFtn = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfPgdFtn (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbPlcfPgdFtn = try dataStream.read(endianess: .littleEndian)

        /// fcAutosaveSource (4 bytes): This value is undefined and MUST be ignored.
        self.fcAutosaveSource = try dataStream.read(endianess: .littleEndian)

        /// lcbAutosaveSource (4 bytes): This value MUST be zero and MUST be ignored.
        self.lcbAutosaveSource = try dataStream.read(endianess: .littleEndian)

        /// fcGrpXstAtnOwners (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An array of XSTs begins at this offset.
        /// The value of cch for all XSTs in this array MUST be less than 56. The number of entries in this array is limited to 0x7FFF. This array
        /// contains the names of authors of comments in the document. The names in this array MUST be unique. If no comments are defined,
        /// lcbGrpXstAtnOwners and fcGrpXstAtnOwners MUST be zero and MUST be ignored. If any comments are in the document,
        /// fcGrpXstAtnOwners MUST point to a valid array of XSTs.
        self.fcGrpXstAtnOwners = try dataStream.read(endianess: .littleEndian)

        /// lcbGrpXstAtnOwners (4 bytes): An unsigned integer that specifies the size, in bytes, of the XST array at offset fcGrpXstAtnOwners
        /// in the Table Stream.
        self.lcbGrpXstAtnOwners = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfAtnBkmk (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfAtnBkmk that contains information
        /// about the annotation bookmarks in the document begins at this offset. If lcbSttbfAtnBkmk is zero, fcSttbfAtnBkmk is undefined and
        /// MUST be ignored.
        /// The SttbfAtnBkmk is parallel to the PlcfBkf at offset fcPlcfAtnBkf in the Table Stream. Each element in the SttbfAtnBkmk specifies
        /// information about the bookmark which is associated with the data element that is located at the same offset in that PlcfBkf, so the
        /// SttbfAtnBkmk beginning at offset fcSttbfAtnBkmk and the PlcfBkf beginning at offset fcPlcfAtnBkf MUST contain the same number
        /// of elements. An additional constraint upon the number of elements in the SttbfAtnBkmk is specified in the description of fcPlcfAtnBkf.
        self.fcSttbfAtnBkmk = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfAtnBkmk (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfAtnBkmk at offset fcSttbfAtnBkmk.
        self.lcbSttbfAtnBkmk = try dataStream.read(endianess: .littleEndian)

        /// fcUnused2 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused2 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused2 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused2 = try dataStream.read(endianess: .littleEndian)

        /// fcUnused3 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused3 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused3 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused3 = try dataStream.read(endianess: .littleEndian)

        /// fcPlcSpaMom (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfSpa begins at this offset. The PlcfSpa
        /// contains shape information for the Main Document. All CPs in this PlcfSpa are relative to the starting position of the Main Document
        /// and MUST be greater than or equal to zero and less than or equal to cppText in FibRgLw97. The final CP is undefined and MUST
        /// be ignored, though it MUST be greater than the previous entry. If there are no shapes in the Main Document, lcbPlcSpaMom and
        /// fcPlcSpaMom MUST be zero and MUST be ignored. If there are shapes in the Main Document, fcPlcSpaMom MUST point to a valid
        /// PlcfSpa structure.
        self.fcPlcSpaMom = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcSpaMom (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfSpa at offset fcPlcSpaMom.
        self.lcbPlcSpaMom = try dataStream.read(endianess: .littleEndian)

        /// fcPlcSpaHdr (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfSpa begins at this offset. The PlcfSpa
        /// contains shape information for the Header Document. All CPs in this PlcfSpa are relative to the starting position of the Header
        /// Document and MUST be greater than or equal to zero and less than or equal to ccpHdd in FibRgLw97. The final CP is undefined
        /// and MUST be ignored, though this value MUST be greater than the previous entry. If there are no shapes in the Header Document,
        /// lcbPlcSpaHdr and fcPlcSpaHdr MUST both be zero and MUST be ignored. If there are shapes in the Header Document, fcPlcSpaHd
        /// MUST point to a valid PlcfSpa structure.
        self.fcPlcSpaHdr = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcSpaHdr (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfSpa at the offset fcPlcSpaHdr.
        self.lcbPlcSpaHdr = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfAtnBkf (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfBkf that contains information about
        /// annotation bookmarks in the document begins at this offset. If lcbPlcfAtnBkf is zero, fcPlcfAtnBkf is undefined and MUST be ignored.
        /// Each data element in the PlcfBkf is associated, in a one-to-one correlation, with a data element in the PlcfBkl at offset fcPlcfAtnBkl.
        /// For this reason, the PlcfBkf that begins at offset fcPlcfAtnBkf, and the PlcfBkl that begins at offset fcPlcfAtnBkl, MUST contain the
        /// same number of data elements. The PlcfBkf is parallel to the SttbfAtnBkmk at offset fcSttbfAtnBkmk in the Table Stream. Each data
        /// element in the PlcfBkf specifies information about the bookmark which is associated with the element that is located at the same
        /// offset in that SttbfAtnBkmk. For this reason, the PlcfBkf that begins at offset fcPlcfAtnBkf, and the SttbfAtnBkmk that begins at
        /// offset fcSttbfAtnBkmk, MUST contain the same number of elements. The CP range of an annotation bookmark MUST be in the Main
        /// Document part.
        self.fcPlcfAtnBkf = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfAtnBkf (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfBkf at offset fcPlcfAtnBkf.
        self.lcbPlcfAtnBkf = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfAtnBkl (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfBkl that contains information about
        /// annotation bookmarks in the document begins at this offset. If lcbPlcfAtnBkl is zero, then fcPlcfAtnBkl is undefined and MUST be
        /// ignored.
        /// Each data element in the PlcfBkl is associated, in a one-to-one correlation, with a data element in the PlcfBkf at offset fcPlcfAtnBkf.
        /// For this reason, the PlcfBkl that begins at offset fcPlcfAtnBkl, and the PlcfBkf that begins at offset fcPlcfAtnBkf, MUST contain the
        /// same number of data elements.
        /// The CP range of an annotation bookmark MUST be in the Main Document part.
        self.fcPlcfAtnBkl = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfAtnBkl (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfBkl at offset fcPlcfAtnBkl.
        self.lcbPlcfAtnBkl = try dataStream.read(endianess: .littleEndian)

        /// fcPms (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Pms, which contains the current state of a print
        /// merge operation, begins at this offset. If lcbPms is zero, fcPms is undefined and MUST be ignored.
        self.fcPms = try dataStream.read(endianess: .littleEndian)

        /// lcbPms (4 bytes): An unsigned integer which specifies the size, in bytes, of the Pms at offset fcPms.
        self.lcbPms = try dataStream.read(endianess: .littleEndian)

        /// fcFormFldSttbs (4 bytes): This value is undefined and MUST be ignored.
        self.fcFormFldSttbs = try dataStream.read(endianess: .littleEndian)

        /// lcbFormFldSttbs (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbFormFldSttbs = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfendRef (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfendRef that begins at this offset
        /// specifies the locations of endnote references in the Main Document and whether those references use auto-numbering or custom
        /// symbols. If lcbPlcfendRef is zero, fcPlcfendRef is undefined and MUST be ignored.
        self.fcPlcfendRef = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfendRef (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfendRef that begins at offset fcPlcfendRef
        /// in the Table Stream.
        self.lcbPlcfendRef = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfendTxt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfendTxt begins at this offset and
        /// specifies the locations of each block of endnote text in the Endnote Document. If lcbPlcfendTxt is zero, fcPlcfendTxt is undefined
        /// and MUST be ignored.
        self.fcPlcfendTxt = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfendTxt (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfendTxt that begins at offset fcPlcfendTxt in
        /// the Table Stream. lcbPlcfendTxt MUST be zero if FibRgLw97.ccpEdn is zero, and MUST be nonzero if FibRgLw97.ccpEdn is nonzero.
        self.lcbPlcfendTxt = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfFldEdn (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcFld begins at this offset and specifies
        /// the locations of field characters in the Endnote Document. All CPs in this PlcFld are relative to the starting position of the Endnote
        /// Document. All CPs in this PlcFld MUST be greater than or equal to zero and less than or equal to FibRgLw97.ccpEdn. If
        /// lcbPlcfFldEdn is zero, fcPlcfFldEdn is undefined and MUST be ignored.
        self.fcPlcfFldEdn = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfFldEdn (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcFld at offset fcPlcfFldEdn in the Table Stream.
        self.lcbPlcfFldEdn = try dataStream.read(endianess: .littleEndian)

        /// fcUnused4 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused4 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused4 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused4 = try dataStream.read(endianess: .littleEndian)

        /// fcDggInfo (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An OfficeArtContent that contains information
        /// about the drawings in the document begins at this offset.
        self.fcDggInfo = try dataStream.read(endianess: .littleEndian)

        /// lcbDggInfo (4 bytes): An unsigned integer that specifies the size, in bytes, of the OfficeArtContent at the offset fcDggInfo. If lcbDggInfo
        /// is zero, there MUST NOT be any drawings in the document.
        self.lcbDggInfo = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfRMark (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfRMark that contains the names of
        /// authors who have added revision marks or comments to the document begins at this offset. If lcbSttbfRMark is zero, fcSttbfRMark
        /// is undefined and MUST be ignored.
        self.fcSttbfRMark = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfRMark (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfRMark at the offset fcSttbfRMark.
        self.lcbSttbfRMark = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfCaption (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfCaption that contains information
        /// about the captions that are defined in this document begins at this offset. If lcbSttbfCaption is zero, fcSttbfCaption is undefined and
        /// MUST be ignored. If this document is not the Normal template, this value MUST be ignored.
        self.fcSttbfCaption = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfCaption (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfCaption at offset fcSttbfCaption in the
        /// Table Stream. If base.fDot of the Fib that contains this FibRgFcLcb97 is zero, this value MUST be zero.
        let lcbSttbfCaption: UInt32 = try dataStream.read(endianess: .littleEndian)
        if !fibBase.fDot && lcbSttbfCaption != 0 {
            throw OfficeFileError.corrupted
        }
        
        self.lcbSttbfCaption = lcbSttbfCaption

        /// fcSttbfAutoCaption (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A SttbfAutoCaption that contains
        /// information about the AutoCaption strings defined in this document begins at this offset. If lcbSttbfAutoCaption is zero,
        /// fcSttbfAutoCaption is undefined and MUST be ignored. If this document is not the Normal template, this value MUST be ignored.
        self.fcSttbfAutoCaption = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfAutoCaption (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfAutoCaption at offset
        /// fcSttbfAutoCaption in the Table Stream. If base.fDot of the Fib that contains this FibRgFcLcb97 is zero, this MUST be zero.
        let lcbSttbfAutoCaption: UInt32 = try dataStream.read(endianess: .littleEndian)
        if !fibBase.fDot && lcbSttbfAutoCaption != 0 {
            throw OfficeFileError.corrupted
        }
        
        self.lcbSttbfAutoCaption = lcbSttbfAutoCaption

        /// fcPlcfWkb (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfWKB that contains information about
        /// all master documents and subdocuments begins at this offset.
        self.fcPlcfWkb = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfWkb (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfWKB at offset fcPlcfWkb in the Table Stream.
        /// If lcbPlcfWkb is zero, fcPlcfWkb is undefined and MUST be ignored.
        self.lcbPlcfWkb = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfSpl (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Plcfspl, which specifies the state of the spell
        /// checker for each text range, begins at this offset. If lcbPlcfSpl is zero, then fcPlcfSpl is undefined and MUST be ignored.
        self.fcPlcfSpl = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfSpl (4 bytes): An unsigned integer that specifies the size, in bytes, of the Plcfspl that begins at offset fcPlcfSpl in the
        /// Table Stream.
        self.lcbPlcfSpl = try dataStream.read(endianess: .littleEndian)

        /// fcPlcftxbxTxt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcftxbxTxt begins at this offset and
        /// specifies which ranges of text are contained in which textboxes. If lcbPlcftxbxTxt is zero, fcPlcftxbxTxt is undefined and MUST
        /// be ignored.
        self.fcPlcftxbxTxt = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcftxbxTxt (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcftxbxTxt that begins at offset fcPlcftxbxTxt
        /// in the Table Stream. lcbPlcftxbxTxt MUST be zero if FibRgLw97.ccpTxbx is zero, and MUST be nonzero if FibRgLw97.ccpTxbx
        /// is nonzero.
        self.lcbPlcftxbxTxt = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfFldTxbx (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcFld
        /// begins at this offset and specifies the locations of field characters in the Textbox Document. All
        /// CPs in this PlcFld are relative to the starting position of the Textbox Document. All CPs in this
        /// PlcFld MUST be greater than or equal to zero and less than or equal to FibRgLw97.ccpTxbx. If
        /// lcbPlcfFldTxbx is zero, fcPlcfFldTxbx is undefined and MUST be ignored.
        self.fcPlcfFldTxbx = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfFldTxbx (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcFld at offset fcPlcfFldTxbx in the Table Stream.
        self.lcbPlcfFldTxbx = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfHdrtxbxTxt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfHdrtxbxTxt begins at this offset
        /// and specifies which ranges of text are contained in which header textboxes.
        self.fcPlcfHdrtxbxTxt = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfHdrtxbxTxt (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfHdrtxbxTxt that begins at offset
        /// fcPlcfHdrtxbxTxt in the Table Stream. lcbPlcfHdrtxbxTxt MUST be zero if FibRgLw97.ccpHdrTxbx is zero, and MUST be nonzero if
        /// FibRgLw97.ccpHdrTxbx is nonzero.
        self.lcbPlcfHdrtxbxTxt = try dataStream.read(endianess: .littleEndian)

        /// fcPlcffldHdrTxbx (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcFld begins at this offset and
        /// specifies the locations of field characters in the Header Textbox Document. All CPs in this PlcFld are relative to the starting position
        /// of the Header Textbox Document. All CPs in this PlcFld MUST be greater than or equal to zero and less than or equal to
        /// FibRgLw97.ccpHdrTxbx. If lcbPlcffldHdrTxbx is zero, fcPlcffldHdrTxbx is undefined, and MUST be ignored.
        self.fcPlcffldHdrTxbx = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcffldHdrTxbx (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcFld at offset fcPlcffldHdrTxbx in the
        /// Table Stream.
        self.lcbPlcffldHdrTxbx = try dataStream.read(endianess: .littleEndian)

        /// fcStwUser (4 bytes): An unsigned integer that specifies an offset into the Table Stream. An StwUser that specifies the user-defined
        /// variables and VBA digital signature, as specified by [MS-OSHARED] section 2.3.2, begins at this offset. If lcbStwUser is zero,
        /// fcStwUser is undefined and MUST be ignored.
        self.fcStwUser = try dataStream.read(endianess: .littleEndian)

        /// lcbStwUser (4 bytes): An unsigned integer that specifies the size, in bytes, of the StwUser at offset fcStwUser.
        self.lcbStwUser = try dataStream.read(endianess: .littleEndian)

        /// fcSttbTtmbd (4 bytes): An unsigned integer that specifies an offset into the Table Stream. A SttbTtmbd begins at this offset and
        /// specifies information about the TrueType fonts that are embedded in the document. If lcbSttbTtmbd is zero, fcSttbTtmbd is
        /// undefined and MUST be ignored.
        self.fcSttbTtmbd = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbTtmbd (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbTtmbd at offset fcSttbTtmbd.
        self.lcbSttbTtmbd = try dataStream.read(endianess: .littleEndian)

        /// fcCookieData (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An RgCdb begins at this offset. If
        /// lcbCookieData is zero, fcCookieData is undefined and MUST be ignored. Otherwise, fcCookieData MAY<29> be ignored.
        self.fcCookieData = try dataStream.read(endianess: .littleEndian)

        /// lcbCookieData (4 bytes): An unsigned integer that specifies the size, in bytes, of the RgCdb at offset fcCookieData in the Table Stream.
        self.lcbCookieData = try dataStream.read(endianess: .littleEndian)

        /// fcPgdMotherOldOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated document page
        /// layout cache begins at this offset. Information SHOULD NOT<30> be emitted at this offset and SHOULD<31> be ignored. If
        /// lcbPgdMotherOldOld is zero, fcPgdMotherOldOld is undefined and MUST be ignored.
        self.fcPgdMotherOldOld = try dataStream.read(endianess: .littleEndian)

        /// lcbPgdMotherOldOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated document page layout cache
        /// at offset fcPgdMotherOldOld in the Table Stream.
        self.lcbPgdMotherOldOld = try dataStream.read(endianess: .littleEndian)

        /// fcBkdMotherOldOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated document text flow
        /// break cache begins at this offset. Information SHOULD NOT<32> be emitted at this offset and SHOULD<33> be ignored. If
        /// lcbBkdMotherOldOld is zero, fcBkdMotherOldOld is undefined and MUST be ignored.
        self.fcBkdMotherOldOld = try dataStream.read(endianess: .littleEndian)

        /// lcbBkdMotherOldOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated document text flow break
        /// cache at offset fcBkdMotherOldOld in the Table Stream.
        self.lcbBkdMotherOldOld = try dataStream.read(endianess: .littleEndian)

        /// fcPgdFtnOldOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated footnote layout cache
        /// begins at this offset. Information SHOULD NOT<34> be emitted at this offset and SHOULD<35> be ignored. If lcbPgdFtnOldOld
        /// is zero, fcPgdFtnOldOld is undefined and MUST be ignored.
        self.fcPgdFtnOldOld = try dataStream.read(endianess: .littleEndian)

        /// lcbPgdFtnOldOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated footnote layout cache at offset
        /// fcPgdFtnOldOld in the Table Stream.
        self.lcbPgdFtnOldOld = try dataStream.read(endianess: .littleEndian)

        /// fcBkdFtnOldOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated footnote text flow
        /// break cache begins at this offset. Information SHOULD NOT<36> be emitted at this offset and SHOULD<37> be ignored. If
        /// lcbBkdFtnOldOld is zero, fcBkdFtnOldOld is undefined and MUST be ignored.
        self.fcBkdFtnOldOld = try dataStream.read(endianess: .littleEndian)

        /// lcbBkdFtnOldOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated footnote text flow break cache
        /// at offset fcBkdFtnOldOld in the Table Stream.
        self.lcbBkdFtnOldOld = try dataStream.read(endianess: .littleEndian)

        /// fcPgdEdnOldOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated endnote layout cache
        /// begins at this offset. Information SHOULD NOT<38> be emitted at this offset and SHOULD<39> be ignored. If lcbPgdEdnOldOld
        /// is zero, fcPgdEdnOldOld is undefined and MUST be ignored.
        self.fcPgdEdnOldOld = try dataStream.read(endianess: .littleEndian)

        /// lcbPgdEdnOldOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated endnote layout cache at offset
        /// fcPgdEdnOldOld in the Table Stream.
        self.lcbPgdEdnOldOld = try dataStream.read(endianess: .littleEndian)

        /// fcBkdEdnOldOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated endnote text flow break
        /// cache begins at this offset. Information SHOULD NOT<40> be emitted at this offset and SHOULD<41> be ignored. If
        /// lcbBkdEdnOldOld is zero, fcBkdEdnOldOld is undefined and MUST be ignored.
        self.fcBkdEdnOldOld = try dataStream.read(endianess: .littleEndian)

        /// lcbBkdEdnOldOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated endnote text flow break cache
        /// at offset fcBkdEdnOldOld in the Table Stream.
        self.lcbBkdEdnOldOld = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfIntlFld (4 bytes): This value is undefined and MUST be ignored.
        self.fcSttbfIntlFld = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfIntlFld (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbSttbfIntlFld = try dataStream.read(endianess: .littleEndian)

        /// fcRouteSlip (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A RouteSlip that specifies the route slip for
        /// this document begins at this offset. This value SHOULD<42> be ignored.
        self.fcRouteSlip = try dataStream.read(endianess: .littleEndian)

        /// lcbRouteSlip (4 bytes): An unsigned integer that specifies the size, in bytes, of the RouteSlip at offset fcRouteSlip in the Table Stream.
        self.lcbRouteSlip = try dataStream.read(endianess: .littleEndian)

        /// fcSttbSavedBy (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A SttbSavedBy that specifies the save
        /// history of this document begins at this offset. This value SHOULD<43> be ignored.
        self.fcSttbSavedBy = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbSavedBy (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbSavedBy at the offset fcSttbSavedBy.
        /// This value SHOULD<44> be zero.
        self.lcbSttbSavedBy = try dataStream.read(endianess: .littleEndian)

        /// fcSttbFnm (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbFnm that contains information about
        /// the external files that are referenced by this document begins at this offset. If lcbSttbFnm is zero, fcSttbFnm is undefined and
        /// MUST be ignored.
        self.fcSttbFnm = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbFnm (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbFnm at the offset fcSttbFnm.
        self.lcbSttbFnm = try dataStream.read(endianess: .littleEndian)

        /// fcPlfLst (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlfLst that contains list formatting information
        /// begins at this offset. An array of LVLs is appended to the PlfLst. lcbPlfLst does not account for the array of LVLs. The size of the
        /// array of LVLs is specified by the LSTFs in PlfLst. For each LSTF whose fSimpleList is set to 0x1, there is one LVL in the array of
        /// LVLs that specifies the level formatting of the single level in the list which corresponds to the LSTF. And, for each LSTF whose
        /// fSimpleList is set to 0x0, there are 9 LVLs in the array of LVLs that specify the level formatting of the respective levels in the list
        /// which corresponds to the LSTF. This array of LVLs is in the same respective order as the LSTFs in PlfLst. If lcbPlfLst is 0, fcPlfLst
        /// is undefined and MUST be ignored.
        self.fcPlfLst = try dataStream.read(endianess: .littleEndian)

        /// lcbPlfLst (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlfLst at the offset fcPlfLst. This does not include
        /// the size of the array of LVLs that are appended to the PlfLst.
        self.lcbPlfLst = try dataStream.read(endianess: .littleEndian)

        /// fcPlfLfo (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlfLfo that contains list formatting override
        /// information begins at this offset. If lcbPlfLfo is zero, fcPlfLfo is undefined and MUST be ignored.
        self.fcPlfLfo = try dataStream.read(endianess: .littleEndian)

        /// lcbPlfLfo (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlfLfo at the offset fcPlfLfo.
        self.lcbPlfLfo = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfTxbxBkd (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcftxbxBkd begins at this offset and
        /// specifies which ranges of text go inside which textboxes.
        self.fcPlcfTxbxBkd = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfTxbxBkd (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcftxbxBkd that begins at offset fcPlcfTxbxBkd
        /// in the Table Stream. lcbPlcfTxbxBkd MUST be zero if FibRgLw97.ccpTxbx is zero, and MUST be nonzero if FibRgLw97.ccpTxbx is
        /// nonzero.
        let lcbPlcfTxbxBkd: UInt32 = try dataStream.read(endianess: .littleEndian)
        if fibRgLw97.ccpTxbx == 0 && lcbPlcfTxbxBkd != 0 {
            throw OfficeFileError.corrupted
        } else if fibRgLw97.ccpTxbx != 0 && lcbPlcfTxbxBkd == 0 {
            throw OfficeFileError.corrupted
        }

        self.lcbPlcfTxbxBkd = lcbPlcfTxbxBkd
        
        /// fcPlcfTxbxHdrBkd (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfTxbxHdrBkd begins at this offset
        /// and specifies which ranges of text are contained inside which header textboxes.
        self.fcPlcfTxbxHdrBkd = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfTxbxHdrBkd (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfTxbxHdrBkd that begins at offset
        /// fcPlcfTxbxHdrBkd in the Table Stream. lcbPlcfTxbxHdrBkd MUST be zero if FibRgLw97.ccpHdrTxbx is zero, and MUST be nonzero if
        /// FibRgLw97.ccpHdrTxbx is nonzero.
        let lcbPlcfTxbxHdrBkd: UInt32 = try dataStream.read(endianess: .littleEndian)
        if fibRgLw97.ccpHdrTxbx == 0 && lcbPlcfTxbxHdrBkd != 0 {
            throw OfficeFileError.corrupted
        } else if fibRgLw97.ccpHdrTxbx != 0 && lcbPlcfTxbxHdrBkd == 0 {
            throw OfficeFileError.corrupted
        }

        self.lcbPlcfTxbxHdrBkd = lcbPlcfTxbxHdrBkd

        /// fcDocUndoWord9 (4 bytes): An unsigned integer that specifies an offset in the WordDocument Stream. Version-specific undo
        /// information begins at this offset. This information SHOULD NOT<45> be emitted and SHOULD<46> be ignored.
        self.fcDocUndoWord9 = try dataStream.read(endianess: .littleEndian)

        /// lcbDocUndoWord9 (4 bytes): An unsigned integer. If this is nonzero, version-specific undo information exists at offset
        /// fcDocUndoWord9 in the WordDocument Stream.
        self.lcbDocUndoWord9 = try dataStream.read(endianess: .littleEndian)

        /// fcRgbUse (4 bytes): An unsigned integer that specifies an offset in the WordDocument Stream. Version-specific undo information
        /// begins at this offset. This information SHOULD NOT<47> be emitted and SHOULD<48> be ignored.
        self.fcRgbUse = try dataStream.read(endianess: .littleEndian)

        /// lcbRgbUse (4 bytes): An unsigned integer that specifies the size, in bytes, of the version-specific undo information at offset
        /// fcRgbUse in the WordDocument Stream.
        self.lcbRgbUse = try dataStream.read(endianess: .littleEndian)

        /// fcUsp (4 bytes): An unsigned integer that specifies an offset in the WordDocument Stream. Version-specific undo information begins
        /// at this offset. This information SHOULD NOT<49> be emitted and SHOULD<50> be ignored.
        self.fcUsp = try dataStream.read(endianess: .littleEndian)

        /// lcbUsp (4 bytes): An unsigned integer that specifies the size, in bytes, of the version-specific undo information at offset fcUsp in
        /// the WordDocument Stream.
        self.lcbUsp = try dataStream.read(endianess: .littleEndian)

        /// fcUskf (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Version-specific undo information begins at this
        /// offset. This information SHOULD NOT<51> be emitted and SHOULD<52> be ignored.
        self.fcUskf = try dataStream.read(endianess: .littleEndian)

        /// lcbUskf (4 bytes): An unsigned integer that specifies the size, in bytes, of the version-specific undo information at offset fcUskf
        /// in the Table Stream.
        self.lcbUskf = try dataStream.read(endianess: .littleEndian)

        /// fcPlcupcRgbUse (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Plc begins at this offset and contains
        /// version-specific undo information. This information SHOULD NOT<53> be emitted and SHOULD<54> be ignored.
        self.fcPlcupcRgbUse = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcupcRgbUse (4 bytes): An unsigned integer that specifies the size, in bytes, of the Plc at offset fcPlcupcRgbUse in the Table
        /// Stream.
        self.lcbPlcupcRgbUse = try dataStream.read(endianess: .littleEndian)

        /// fcPlcupcUsp (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Plc begins at this offset and contains
        /// version-specific undo information. This information SHOULD NOT<55> be emitted and SHOULD<56> be ignored.
        self.fcPlcupcUsp = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcupcUsp (4 bytes): An unsigned integer that specifies the size, in bytes, of the Plc at offset fcPlcupcUsp in the Table Stream.
        self.lcbPlcupcUsp = try dataStream.read(endianess: .littleEndian)

        /// fcSttbGlsyStyle (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A SttbGlsyStyle, which contains information
        /// about the styles that are used by the AutoText items which are defined in this document, begins at this offset.
        self.fcSttbGlsyStyle = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbGlsyStyle (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbGlsyStyle at offset fcSttbGlsyStyle in the
        /// Table Stream. If base.fGlsy of the Fib that contains this FibRgFcLcb97 is zero, this value MUST be zero.
        let lcbSttbGlsyStyle: UInt32 = try dataStream.read(endianess: .littleEndian)
        if !fibBase.fGlsy && lcbSttbGlsyStyle != 0 {
            throw OfficeFileError.corrupted
        }
        
        self.lcbSttbGlsyStyle = lcbSttbGlsyStyle

        /// fcPlgosl (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlfGosl begins at the offset. If lcbPlgosl is zero,
        /// fcPlgosl is undefined and MUST be ignored.
        self.fcPlgosl = try dataStream.read(endianess: .littleEndian)

        /// lcbPlgosl (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlfGosl at offset fcPlgosl in the Table Stream.
        self.lcbPlgosl = try dataStream.read(endianess: .littleEndian)

        /// fcPlcocx (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A RgxOcxInfo that specifies information about
        /// the OLE controls in the document begins at this offset. When there are no OLE controls in the document, fcPlcocx and lcbPlcocx
        /// MUST be zero and MUST be ignored. If there are any OLE controls in the document, fcPlcocx MUST point to a valid RgxOcxInfo.
        self.fcPlcocx = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcocx (4 bytes): An unsigned integer that specifies the size, in bytes, of the RgxOcxInfo at the offset fcPlcocx.
        self.lcbPlcocx = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBteLvc (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A deprecated numbering field cache begins
        /// at this offset. This information SHOULD NOT<57> be emitted and SHOULD<58> ignored. If lcbPlcBteLvc is zero, fcPlcfBteLvc is
        /// undefined and MUST be ignored.
        self.fcPlcfBteLvc = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBteLvc (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated numbering field cache at offset
        /// fcPlcfBteLvc in the Table Stream. This value SHOULD<59> be zero.
        self.lcbPlcfBteLvc = try dataStream.read(endianess: .littleEndian)

        /// dwLowDateTime (4 bytes): The low-order part of a FILETIME structure, as specified by [MSDTYP], that specifies when the
        /// document was last saved.
        self.dwLowDateTime = try dataStream.read(endianess: .littleEndian)

        /// dwHighDateTime (4 bytes): The high-order part of a FILETIME structure, as specified by [MSDTYP], that specifies when the
        /// document was last saved.
        self.dwHighDateTime = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfLvcPre10 (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated list level cache begins
        /// at this offset. Information SHOULD NOT<60> be emitted at this offset and SHOULD<61> be ignored. If lcbPlcfLvcPre10 is zero,
        /// fcPlcfLvcPre10 is undefined and MUST be ignored.
        self.fcPlcfLvcPre10 = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfLvcPre10 (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated list level cache at offset
        /// fcPlcfLvcPre10 in the Table Stream. This value SHOULD<62> be zero.
        self.lcbPlcfLvcPre10 = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfAsumy (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfAsumy begins at the offset. If
        /// lcbPlcfAsumy is zero, fcPlcfAsumy is undefined and MUST be ignored.
        self.fcPlcfAsumy = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfAsumy (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfAsumy at offset fcPlcfAsumy in the
        /// Table Stream.
        self.lcbPlcfAsumy = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfGram (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Plcfgram, which specifies the state of the
        /// grammar checker for each text range, begins at this offset. If lcbPlcfGram is zero, then fcPlcfGram is undefined and MUST be ignored.
        self.fcPlcfGram = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfGram (4 bytes): An unsigned integer that specifies the size, in bytes, of the Plcfgram that begins at offset fcPlcfGram in the
        /// Table Stream.
        self.lcbPlcfGram = try dataStream.read(endianess: .littleEndian)

        /// fcSttbListNames (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A SttbListNames, which specifies the
        /// LISTNUM field names of the lists in the document, begins at this offset. If lcbSttbListNames is zero, fcSttbListNames is undefined
        /// and MUST be ignored.
        self.fcSttbListNames = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbListNames (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbListNames at the offset fcSttbListNames.
        self.lcbSttbListNames = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfUssr (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated, version-specific undo
        /// information begins at this offset. This information SHOULD NOT<63> be emitted and SHOULD<64> be ignored.
        self.fcSttbfUssr = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfUssr (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated, version-specific undo information at
        /// offset fcSttbfUssr in the Table Stream.
        self.lcbSttbfUssr = try dataStream.read(endianess: .littleEndian)
    }
}
