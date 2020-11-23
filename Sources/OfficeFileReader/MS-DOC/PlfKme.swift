//
//  PlfKme.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.199 PlfKme
/// The PlfKme structure specifies keyboard mappings. This structure is used in the sequence of structures that specify command-related customizations.
/// For more information, see the Tcg255 structure.
public struct PlfKme {
    public let ch: UInt8
    public let iMac: Int32
    public let rgkme: [Kme]
    
    public init(dataStream: inout DataStream) throws {
        /// ch (1 byte): An unsigned integer that identifies this structure as PlfKme. This value MUST be either 3 or 4. A value of 3 indicates
        /// regular keyboard key map entries. A value of 4 indicates invalid keyboard key map entries. For more information, see the
        /// Tcg255.rgtcgData field.
        let ch: UInt8 = try dataStream.read()
        if ch != 3 && ch != 4 {
            throw OfficeFileError.corrupted
        }
        
        self.ch = ch
        
        /// iMac (4 bytes): A signed integer that specifies the number of keyboard key map entries, as specified in Kme, in rgkme.
        /// This value MUST be greater than or equal to 0.
        self.iMac = try dataStream.read(endianess: .littleEndian)
        if self.iMac < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rgkme (variable): An array of Kme structures. The number of structures is specified by iMac.
        var rgkme: [Kme] = []
        rgkme.reserveCapacity(Int(self.iMac))
        for _ in 0..<self.iMac {
            rgkme.append(try Kme(dataStream: &dataStream))
        }
        
        self.rgkme = rgkme
    }
}
