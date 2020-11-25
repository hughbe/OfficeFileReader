//
//  DirStream.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

public struct DirStream {
    public let informationRecord: PROJECTINFORMATION
    public let referencesRecord: PROJECTREFERENCES
    public let modulesRecord: PROJECTMODULES
    public let terminator: UInt16
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// InformationRecord (variable): A PROJECTINFORMATION Record (section 2.3.4.2.1).
        self.informationRecord = try PROJECTINFORMATION(dataStream: &dataStream)
        
        /// ReferencesRecord (variable): A PROJECTREFERENCES Record (section 2.3.4.2.2).
        self.referencesRecord = try PROJECTREFERENCES(dataStream: &dataStream)
        
        /// ModulesRecord (variable): A PROJECTMODULES Record (section 2.3.4.2.3).
        self.modulesRecord = try PROJECTMODULES(dataStream: &dataStream)
        
        /// Terminator (2 bytes): An unsigned integer that specifies the end of the version-independent information in this stream. MUST be 0x0010.
        self.terminator = try dataStream.read(endianess: .littleEndian)
        guard self.terminator == 0x0010 else {
            throw OfficeFileError.corrupted
        }
        
        /// Reserved (4 bytes): MUST be 0x00000000. MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
