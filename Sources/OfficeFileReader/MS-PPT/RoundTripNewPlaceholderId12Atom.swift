//
//  RoundTripNewPlaceholderId12Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.17 RoundTripNewPlaceholderId12Atom
/// Referenced by: ShapeClientRoundtripDataSubContainerOrAtom
/// An atom record that specifies a placeholder identifier.
public struct RoundTripNewPlaceholderId12Atom {
    public let rh: RecordHeader
    public let newPlaceholderId: PlaceholderEnum
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripNewPlaceholderId12Atom.
        /// rh.recLen MUST be 0x00000001.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripNewPlaceholderId12Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000001 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// newPlaceholderId (1 byte): A PlaceholderEnum enumeration that specifies the placeholder shape identifier. It MUST be PT_VerticalObject or
        /// PT_Picture.
        let newPlaceholderIdRaw: UInt8 = try dataStream.read()
        guard let newPlaceholderId = PlaceholderEnum(rawValue: newPlaceholderIdRaw) else {
            throw OfficeFileError.corrupted
        }
        guard newPlaceholderId == .verticalObject || newPlaceholderId == .picture else {
            throw OfficeFileError.corrupted
        }
        
        self.newPlaceholderId = newPlaceholderId
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
