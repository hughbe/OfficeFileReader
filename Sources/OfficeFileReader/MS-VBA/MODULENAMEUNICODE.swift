//
//  MODULENAMEUNICODE.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.3.2.2 MODULENAMEUNICODE Record
/// Specifies a VBA identifier as the name of the containing MODULE Record (section 2.3.4.2.3.2). MUST contain the UTF-16 encoding of
/// MODULENAME Record (section 2.3.4.2.3.2.1).
public struct MODULENAMEUNICODE {
    public let id: UInt16
    public let sizeOfModuleNameUnicode: UInt32
    public let moduleNameUnicode: String
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0047.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0047 else {
            throw OfficeFileError.corrupted
        }
        
        /// SizeOfModuleNameUnicode (4 bytes): An unsigned integer that specifies the size in bytes of ModuleNameUnicode. MUST be even.
        self.sizeOfModuleNameUnicode = try dataStream.read(endianess: .littleEndian)
        guard (self.sizeOfModuleNameUnicode % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        /// ModuleNameUnicode (variable): An array of SizeOfModuleNameUnicode bytes that specifies the VBA identifier for the containing
        /// MODULE Record (section 2.3.4.2.3.2). MUST contain UTF-16 characters. MUST NOT contain null characters. MUST contain the
        /// UTF-16 encoding of MODULENAME Record (section 2.3.4.2.3.2.1) ModuleName.
        self.moduleNameUnicode = try dataStream.readString(count: Int(self.sizeOfModuleNameUnicode), encoding: .utf16LittleEndian)!
    }
}
