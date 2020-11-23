//
//  MacroNames.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.152 MacroNames
/// The MacroNames structure specifies the macro name table. This structure is used in a sequence of structures that specify command-related customizations.
/// For more information, see the Tcg255 structure.
public struct MacroNames {
    public let ch: UInt8
    public let iMac: UInt16
    public let rgNames: [MacroName]
    
    public init(dataStream: inout DataStream) throws {
        /// ch (1 byte): An unsigned integer that identifies this structure as a MacroNames structure. This value MUST be 17.
        self.ch = try dataStream.read()
        if self.ch != 17 {
            throw OfficeFileError.corrupted
        }
        
        /// iMac (2 bytes): An unsigned integer that specifies the number of MacroName structures in rgNames.
        self.iMac = try dataStream.read(endianess: .littleEndian)
        
        /// rgNames (variable): An array of MacroName structures. The number of structures is specified by iMac.
        var rgNames: [MacroName] = []
        rgNames.reserveCapacity(Int(self.iMac))
        for _ in 0..<self.iMac {
            rgNames.append(try MacroName(dataStream: &dataStream))
        }
        
        self.rgNames = rgNames
    }
}
