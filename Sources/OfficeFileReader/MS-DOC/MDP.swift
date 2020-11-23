//
//  MDP.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.155 MDP
/// The MDP structure contains information that is needed to display information about an e-mail message and its author.
public struct MDP {
    public let dttm: DTTM
    public let reserved1: UInt16
    public let ibstAuthor: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// dttm (4 bytes): A DTTM structure that specifies the date and time at which an e-mail message was created.
        self.dttm = try DTTM(dataStream: &dataStream)
        
        /// reserved1 (2 bytes): This field MUST be zero, and MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// ibstAuthor (2 bytes): A signed integer that specifies the index into the SttbfRMark structure of the author of the message.
        self.ibstAuthor = try dataStream.read(endianess: .littleEndian)
    }
}
