//
//  PROJECTNAME.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1.5 PROJECTNAME Record
/// Specifies a unique VBA identifier as the name of the VBA project.
public struct PROJECTNAME {
    public let id: UInt16
    public let sizeOfProjectName: UInt32
    public let projectName: String
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0004.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0004 else {
            throw OfficeFileError.corrupted
        }
        
        /// SizeOfProjectName (4 bytes): An unsigned integer that specifies the size in bytes of ProjectName. MUST be greater than or equal to 1.
        /// MUST be less than or equal to 128.
        let sizeOfProjectName: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard sizeOfProjectName >= 1 && sizeOfProjectName <= 128 else {
            throw OfficeFileError.corrupted
        }
        
        self.sizeOfProjectName = sizeOfProjectName
        
        /// ProjectName (variable): An array of SizeOfProjectName bytes that specifies the VBA identifier name for the VBA project. MUST contain
        /// MBCS characters encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4). MUST NOT contain null characters.
        self.projectName = try dataStream.readString(count: Int(self.sizeOfProjectName), encoding: .ascii)!
    }
}
