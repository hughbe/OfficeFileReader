//
//  PlfMcd.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.202 PlfMcd
/// The PlfMcd structure specifies macro commands. This structure is used in the sequence of structures that specify command-related customizations.
/// For more information, see Tcg255.
public struct PlfMcd {
    public let ch: UInt8
    public let iMac: Int32
    public let rgmcd: [Mcd]
    
    public init(dataStream: inout DataStream) throws {
        /// ch (1 byte): An unsigned integer that identifies this structure as PlfMcd. This value MUST be 1.
        self.ch = try dataStream.read()
        if self.ch != 1 {
            throw OfficeFileError.corrupted
        }
        
        /// iMac (4 bytes): A signed integer that specifies the number of macro command descriptor structures, as specified by the Mcd structure,
        /// to follow this structure. This value MUST be greater than or equal to 0.
        self.iMac = try dataStream.read(endianess: .littleEndian)
        if self.iMac < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rgmcd (variable): An array of Mcd structures. The number of structures that are contained in the array is specified by iMac.
        var rgmcd: [Mcd] = []
        rgmcd.reserveCapacity(Int(self.iMac))
        for _ in 0..<self.iMac {
            rgmcd.append(try Mcd(dataStream: &dataStream))
        }
        
        self.rgmcd = rgmcd
    }
}
