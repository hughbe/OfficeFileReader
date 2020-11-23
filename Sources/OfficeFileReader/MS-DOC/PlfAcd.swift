//
//  PlfAcd.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.195 PlfAcd
/// The PlfAcd structure specifies the allocated commands in a sequence of command-related customizations. For more information, see Tcg255.
public struct PlfAcd {
    public let ch: UInt8
    public let iMac: Int32
    public let rgacd: [Acd]
    
    public init(dataStream: inout DataStream) throws {
        /// ch (1 byte): An unsigned integer value that identifies this structure as PlfAcd. This value MUST be 2.
        self.ch = try dataStream.read()
        if self.ch != 2 {
            throw OfficeFileError.corrupted
        }
        
        /// iMac (4 bytes): A signed integer value that specifies the number of allocated command descriptor structures, as specified in Acd, in rgacd.
        /// This value MUST be greater than or equal to 0.
        self.iMac = try dataStream.read(endianess: .littleEndian)
        if self.iMac < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rgacd (variable): An array of Acd structures. The number of structures that are contained in this array is specified by iMac.
        var rgacd: [Acd] = []
        rgacd.reserveCapacity(Int(self.iMac))
        for _ in 0..<self.iMac {
            rgacd.append(try Acd(dataStream: &dataStream))
        }
        
        self.rgacd = rgacd
    }
}
