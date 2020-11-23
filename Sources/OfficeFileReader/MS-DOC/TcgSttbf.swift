//
//  TcgSttbf.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.318 TcgSttbf
/// The TcgSttbf structure specifies the command string table that is used to store the names of macros and the arguments to the allocated commands.
/// This structure is used in the sequence of structures that specify command-related customizations in Tcg255.
public struct TcgSttbf {
    public let ch: UInt8
    public let sttbf: TcgSttbfCore
    
    public init(dataStream: inout DataStream) throws {
        /// ch (1 byte): This value MUST be 16.
        self.ch = try dataStream.read()
        if self.ch != 16 {
            throw OfficeFileError.corrupted
        }
        
        /// sttbf (variable): A TcgSttbfCore structure, as described following.
        self.sttbf = try TcgSttbfCore(dataStream: &dataStream)
    }
}
