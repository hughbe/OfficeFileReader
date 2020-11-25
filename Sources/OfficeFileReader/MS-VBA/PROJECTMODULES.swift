//
//  PROJECTMODULES.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.3 PROJECTMODULES Record
/// Specifies data for the modules in the project.
public struct PROJECTMODULES {
    public let id: UInt16
    public let size: UInt32
    public let count: UInt16
    public let projectCookieRecord: PROJECTCOOKIE
    public let modules: [MODULE]
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x000F.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x000F else {
            throw OfficeFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the size of Count. MUST be 0x00000002.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.size == 0x00000002 else {
            throw OfficeFileError.corrupted
        }
        
        /// Count (2 bytes): An unsigned integer that specifies the number of elements in Modules.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// ProjectCookieRecord (8 bytes): A PROJECTCOOKIE Record (section 2.3.4.2.3.1).
        self.projectCookieRecord = try PROJECTCOOKIE(dataStream: &dataStream)
        
        /// Modules (variable): An array of MODULE Records (section 2.3.4.2.3.2).
        var modules: [MODULE] = []
        modules.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            modules.append(try MODULE(dataStream: &dataStream))
        }
        
        self.modules = modules
    }
}
