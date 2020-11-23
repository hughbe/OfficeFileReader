//
//  BxPap.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.23 BxPap
/// The BxPap structure specifies the offset of a PapxInFkp in PapxFkp.
public struct BxPap {
    public let bOffset: UInt8
    public let reserved: (UInt32, UInt32, UInt32)
    
    public init(dataStream: inout DataStream) throws {
        /// bOffset (1 byte): An unsigned integer that specifies the offset of a PapxInFkp in a PapxFkp. The offset of the PapxInFkp is bOffset*2.
        /// If bOffset is 0 then there is no PapxInFkp for this paragraph and this paragraph has the default properties as specified in section 2.6.2.
        self.bOffset = try dataStream.read()
        
        /// reserved (12 bytes): Specifies version-specific paragraph height information. This value SHOULD<204> be 0 and SHOULD<205>
        /// be ignored.
        self.reserved = (
            try dataStream.read(endianess: .littleEndian),
            try dataStream.read(endianess: .littleEndian),
            try dataStream.read(endianess: .littleEndian)
        )
    }
}
