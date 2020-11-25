//
//  PROJECTHELPFILEPATH.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1.7 PROJECTHELPFILEPATH Record
/// Specifies the path to the Help file for the VBA project. <ProjectHelpFile> MUST be defined in PROJECT Stream (section 2.3.1) if SizeOfHelpFile1
/// is greater than zero.
public struct PROJECTHELPFILEPATH {
    public let id: UInt16
    public let sizeOfHelpFile1: UInt32
    public let helpFile1: String
    public let reserved: UInt16
    public let sizeOfHelpFile2: UInt32
    public let helpFile2: String
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0006.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0006 else {
            throw OfficeFileError.corrupted
        }
        
        /// SizeOfHelpFile1 (4 bytes): An unsigned integer that specifies the size in bytes of HelpFile1. MUST be less than or equal to 260.
        self.sizeOfHelpFile1 = try dataStream.read(endianess: .littleEndian)
        guard self.sizeOfHelpFile1 <= 260 else {
            throw OfficeFileError.corrupted
        }
        
        /// HelpFile1 (variable): An array of SizeOfHelpFile1 bytes that specifies the path to the Help file for the VBA project. MUST contain MBCS
        /// characters encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4). MUST NOT contain null characters.
        self.helpFile1 = try dataStream.readString(count: Int(self.sizeOfHelpFile1), encoding: .ascii)!
        
        /// Reserved (2 bytes): MUST be 0x003D. MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        /// SizeOfHelpFile2 (4 bytes): An unsigned integer that specifies the size in bytes of HelpFile2. MUST be equal to SizeOfHelpFile1.
        self.sizeOfHelpFile2 = try dataStream.read(endianess: .littleEndian)
        guard self.sizeOfHelpFile2 == self.sizeOfHelpFile1 else {
            throw OfficeFileError.corrupted
        }
        
        /// HelpFile2 (variable): An array of SizeOfHelpFile2 bytes that specifies the path to the Help file for the VBA project. MUST contain MBCS
        /// characters encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4). MUST NOT contain null characters.
        /// MUST contain the same bytes as HelpFile1.
        self.helpFile2 = try dataStream.readString(count: Int(self.sizeOfHelpFile2), encoding: .ascii)!
    }
}
