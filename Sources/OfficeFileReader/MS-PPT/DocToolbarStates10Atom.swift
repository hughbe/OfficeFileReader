//
//  DocToolbarStates10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.1 DocToolbarStates10Atom
/// Referenced by: PP10DocBinaryTagExtension
/// An atom record that specifies the display options for a reviewing toolbar that has controls that manage presentation comments and the information
/// contained by the DiffTree10Container records and a reviewing gallery that displays the information contained by the DiffTree10Container records.
public struct DocToolbarStates10Atom {
    public let rh: RecordHeader
    public let fShowReviewingToolbar: Bool
    public let fShowReviewingGallery: Bool
    public let reserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_DocToolbarStates10Atom.
        /// rh.recLen MUST be 0x00000001.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .docToolbarStates10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000001 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fShowReviewingToolbar (1 bit): A bit that specifies whether to display the reviewing toolbar.
        self.fShowReviewingToolbar = flags.readBit()
        
        /// B - fShowReviewingGallery (1 bit): A bit that specifies whether to display the reviewing gallery.
        self.fShowReviewingGallery = flags.readBit()
        
        /// reserved (6 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
