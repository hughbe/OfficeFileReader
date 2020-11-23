//
//  RoundTripHFPlaceholder12Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.16 RoundTripHFPlaceholder12Atom
/// Referenced by: ShapeClientRoundtripDataSubContainerOrAtom
/// An atom record that specifies that a shape is a header or footer placeholder shape.
public struct RoundTripHFPlaceholder12Atom {
    public let rh: RecordHeader
    public let placeholderId: PlaceholderEnum
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripHFPlaceholder12Atom.
        /// rh.recLen MUST be 0x00000001.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripHFPlaceholder12Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000001 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// placeholderId (1 byte): A PlaceholderEnum enumeration that specifies the placeholder shape identifier. It MUST be PT_MasterDate,
        /// PT_MasterSlideNumber, PT_MasterFooter, or PT_MasterHeader.
        let placeholderIdRaw: UInt8 = try dataStream.read()
        guard let placeholderId = PlaceholderEnum(rawValue: placeholderIdRaw) else {
            throw OfficeFileError.corrupted
        }
        guard placeholderId == .masterDate || placeholderId == .masterSlideNumber || placeholderId == .masterFooter || placeholderId == .masterHeader else {
            throw OfficeFileError.corrupted
        }
        
        self.placeholderId = placeholderId
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
