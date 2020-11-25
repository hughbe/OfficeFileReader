//
//  MODULENAME.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.3.2.1 MODULENAME Record
/// Specifies a VBA identifier as the name of the containing MODULE Record (section 2.3.4.2.3.2).
public struct MODULENAME {
    public let id: UInt16
    public let sizeOfModuleName: UInt32
    public let moduleName: String
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0019.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0019 else {
            throw OfficeFileError.corrupted
        }
        
        /// SizeOfModuleName (4 bytes): An unsigned integer that specifies the size in bytes of ModuleName.
        self.sizeOfModuleName = try dataStream.read(endianess: .littleEndian)
        
        /// ModuleName (variable): An array of SizeOfModuleName bytes that specifies the VBA identifier for the containing MODULE Record.
        /// MUST contain MBCS characters encoded using the code page specified in the PROJECTCODEPAGE Record (section 2.3.4.2.1.4).
        /// MUST NOT contain null characters.
        self.moduleName = try dataStream.readString(count: Int(self.sizeOfModuleName), encoding: .ascii)!
    }
}
