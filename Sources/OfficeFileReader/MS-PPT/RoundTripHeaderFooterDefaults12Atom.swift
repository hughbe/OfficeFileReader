//
//  RoundTripHeaderFooterDefaults12Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.15 RoundTripHeaderFooterDefaults12Atom
/// Referenced by: PP12SlideBinaryTagExtension
/// An atom record that specifies default header and footer flags.
public struct RoundTripHeaderFooterDefaults12Atom {
    public let rh: RecordHeader
    public let fIncludeDate: Bool
    public let fIncludeFooter: Bool
    public let fIncludeHeader: Bool
    public let fIncludeSlideNumber: Bool
    public let reserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripHeaderFooterDefaults12Atom.
        /// rh.recLen MUST be 0x00000001.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripHeaderFooterDefaults12Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000001 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fIncludeDate (1 bit): A bit that specifies whether the date is included in the footer of new slides.
        self.fIncludeDate = flags.readBit()
        
        /// B - fIncludeFooter (1 bit): A bit that specifies whether the footer is included in new slides.
        self.fIncludeFooter = flags.readBit()
        
        /// C - fIncludeHeader (1 bit): A bit that specifies whether the header is included in new slides.
        self.fIncludeHeader = flags.readBit()
        
        /// D - fIncludeSlideNumber (1 bit): A bit that specifies whether the slide number or page number is included in the footer of new slides.
        self.fIncludeSlideNumber = flags.readBit()
        
        /// E - reserved (4 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
