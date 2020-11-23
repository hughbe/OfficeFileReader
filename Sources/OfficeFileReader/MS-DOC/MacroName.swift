//
//  MacroName.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.151 MacroName
/// The MacroName structure specifies a single entry in the macro name table, as defined in MacroNames.
public struct MacroName {
    public let ibst: UInt16
    public let xstz: Xstz
    
    public init(dataStream: inout DataStream) throws {
        /// ibst (2 bytes): An unsigned integer that specifies the index of the current entry in the macro name table. This MUST NOT be the same as the
        /// index of any other entry.
        self.ibst = try dataStream.read(endianess: .littleEndian)
        
        /// xstz (variable): An Xstz structure that specifies the name of the macro. The length of the string, excluding the terminating null character, MUST
        /// NOT exceed 255 characters.
        self.xstz = try Xstz(dataStream: &dataStream)
        if self.xstz.xst.rgtchar.count > 255 {
            throw OfficeFileError.corrupted
        }
    }
}
