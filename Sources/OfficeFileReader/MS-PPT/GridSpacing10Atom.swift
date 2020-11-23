//
//  GridSpacing10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.1 GridSpacing10Atom
/// Referenced by: PP10DocBinaryTagExtension
/// An atom record that specifies spacing for a grid that can be used to align objects on a slide and to display positioning cues. Only square grids are
/// allowed.
public struct GridSpacing10Atom {
    public let rh: RecordHeader
    public let x: Int32
    public let y: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_GridSpacing10Atom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .gridSpacing10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// x (4 bytes): A signed integer that specifies horizontal grid spacing in grid units. It MUST be greater than or equal to 0x00005AB8 or 1 mm
        /// and less than or equal to 0x00120000 or 2 inches. It MUST be equal to y.
        let x: Int32 = try dataStream.read(endianess: .littleEndian)
        guard x >= 0x00005AB8 && x <= 0x00120000 else {
            throw OfficeFileError.corrupted
        }
        
        self.x = x
        
        /// y (4 bytes): A signed integer that specifies vertical grid spacing in grid units. It MUST be greater than or equal to 0x00005AB8 or 1 mm and
        /// less than or equal to 0x00120000 or 2 inches. It MUST be equal to x.
        let y: Int32 = try dataStream.read(endianess: .littleEndian)
        guard y >= 0x00005AB8 && y <= 0x00120000 && y == x else {
            throw OfficeFileError.corrupted
        }
        
        self.y = y
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
