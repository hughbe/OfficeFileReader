//
//  MODULETYPE.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.3.2.8 MODULETYPE Record
/// Specifies whether the containing MODULE Record (section 2.3.4.2.3.2) is a procedural module, document module, class module, or designer module.
public struct MODULETYPE {
    public let id: UInt16
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0021 when the containing MODULE Record
        /// (section 2.3.4.2.3.2) is a procedural module. MUST be 0x0022 when the containing MODULE Record (section 2.3.4.2.3.2) is a
        /// document module, class module, or designer module.
        self.id = try dataStream.read(endianess: .littleEndian)
        
        /// Reserved (4 bytes): MUST be 0x00000000. MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
