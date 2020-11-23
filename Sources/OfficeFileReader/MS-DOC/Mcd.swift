//
//  Mcd.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.154 Mcd
/// The Mcd structure specifies a macro.
public struct Mcd {
    public let reserved1: Int8
    public let reserved2: UInt8
    public let ibst: UInt16
    public let ibstName: UInt16
    public let reserved3: UInt16
    public let reserved4: UInt32
    public let reserved5: UInt32
    public let reserved6: UInt32
    public let reserved7: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// reserved1 (1 byte): A signed integer that MUST be 0x56.
        self.reserved1 = try dataStream.read()
        if self.reserved1 != 0x56 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved2 (1 byte): This value MUST be 0.
        self.reserved2 = try dataStream.read()
        if self.reserved2 != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// ibst (2 bytes): An unsigned integer that specifies the name of the macro. The macro name is specified by MacroName.xstz of the MacroName
        /// entry in the MacroNames, such that MacroName.ibst equals ibst. MacroNames MUST contain such an entry.
        self.ibst = try dataStream.read(endianess: .littleEndian)
        
        /// ibstName (2 bytes): An unsigned integer that specifies the index into the Command String Table (TcgSttbf.sttbf) where the name and arguments
        /// of the macro are specified.
        self.ibstName = try dataStream.read(endianess: .littleEndian)
        
        /// reserved3 (2 bytes): An unsigned integer that MUST be 0xFFFF.
        self.reserved3 = try dataStream.read(endianess: .littleEndian)
        if self.reserved3 != 0xFFFF {
            throw OfficeFileError.corrupted
        }
        
        /// reserved4 (4 bytes): This field MUST be ignored.
        self.reserved4 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved5 (4 bytes): This field MUST be 0.
        self.reserved5 = try dataStream.read(endianess: .littleEndian)
        if self.reserved5 != 0 {
            throw OfficeFileError.corrupted
        }
       
        /// reserved6 (4 bytes): This field MUST be ignored.
        self.reserved6 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved7 (4 bytes): This field MUST be ignored.
        self.reserved7 = try dataStream.read(endianess: .littleEndian)
    }
}
