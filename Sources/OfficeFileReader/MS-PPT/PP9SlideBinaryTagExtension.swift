//
//  PP9SlideBinaryTagExtension.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.23 PP9SlideBinaryTagExtension
/// Referenced by: SlideProgBinaryTagSubContainerOrAtom
/// A pair of atom records that specifies a programmable tag with additional slide data.
public struct PP9SlideBinaryTagExtension {
    public let rh: RecordHeader
    public let tagName: PrintableUnicodeString
    public let rhData: RecordHeader
    public let rgTextMasterStyleAtom: [TextMasterStyle9Atom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_CString (section 2.13.24).
        /// rh.recLen MUST be 0x0000000E.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000000E else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition1 = dataStream.position

        /// tagName (14 bytes): A PrintableUnicodeString (section 2.2.23) that specifies the programmable tag name. It MUST be "___PPT9".
        self.tagName = try PrintableUnicodeString(dataStream: &dataStream, byteCount: 14)
        if self.tagName != "___PPT9" {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition1 == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
        
        /// rhData (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for the second record. Sub-fields are further specified in
        /// the following table:
        /// Field Meaning
        /// rhData.recVer MUST be 0x0.
        /// rhData.recInstance MUST be 0x000.
        /// rhData.recType MUST be RT_BinaryTagDataBlob.
        self.rhData = try RecordHeader(dataStream: &dataStream)
        guard self.rhData.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rhData.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rhData.recType == .binaryTagDataBlob else {
            throw OfficeFileError.corrupted
        }

        let startPosition2 = dataStream.position
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.rgTextMasterStyleAtom = []
            return
        }
        
        /// rgTextMasterStyleAtom (variable): An array of TextMasterStyle9Atom records that specifies additional character-level and paragraph-level
        /// formatting of master slides. The size, in bytes, of the array is specified by rhData.recLen.
        var rgTextMasterStyleAtom: [TextMasterStyle9Atom] = []
        while dataStream.position - startPosition2 < self.rhData.recLen {
            guard try dataStream.peekRecordHeader().recType == .textMasterStyle9Atom else {
                break
            }
            
            rgTextMasterStyleAtom.append(try TextMasterStyle9Atom(dataStream: &dataStream))
        }
        
        self.rgTextMasterStyleAtom = rgTextMasterStyleAtom
        
        guard dataStream.position - startPosition2 == self.rhData.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
