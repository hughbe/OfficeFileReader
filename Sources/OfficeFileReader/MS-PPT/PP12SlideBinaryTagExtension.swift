//
//  PP12SlideBinaryTagExtension.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.34 PP12SlideBinaryTagExtension
/// Referenced by: SlideProgBinaryTagSubContainerOrAtom
/// A pair of atom records that specifies a programmable tag with additional slide data
public struct PP12SlideBinaryTagExtension {
    public let rh: RecordHeader
    public let tagName: PrintableUnicodeString
    public let rhData: RecordHeader
    public let roundTripHeaderFooterDefaultsAtom: RoundTripHeaderFooterDefaults12Atom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_CString (section 2.13.24).
        /// rh.recLen MUST be 0x00000010.
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
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition1 = dataStream.position

        /// tagName (16 bytes): A PrintableUnicodeString (section 2.2.23) that specifies the programmable tag name. It MUST be "___PPT12".
        self.tagName = try PrintableUnicodeString(dataStream: &dataStream, byteCount: 16)
        if self.tagName != "___PPT12" {
            throw OfficeFileError.corrupted
        }
        
        if dataStream.position - startPosition1 != self.rh.recLen {
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
            self.roundTripHeaderFooterDefaultsAtom = nil
            return
        }
        
        /// roundTripHeaderFooterDefaultsAtom (9 bytes): An optional RoundTripHeaderFooterDefaults12Atom record that specifies headers and
        /// footers data for a main master slide, title master slide, handout master slide, or notes master slide.
        if try dataStream.peekRecordHeader().recType == .roundTripHeaderFooterDefaults12Atom {
            self.roundTripHeaderFooterDefaultsAtom = try RoundTripHeaderFooterDefaults12Atom(dataStream: &dataStream)
        } else {
            self.roundTripHeaderFooterDefaultsAtom = nil
        }
        
        guard dataStream.position - startPosition2 == self.rhData.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
