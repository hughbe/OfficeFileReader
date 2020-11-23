//
//  COSL.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.44 COSL
/// The COSL structure specifies the option set to use for a grammar checker implementing the NLCheck interface, as well as information to identify the
/// corresponding grammar checker.
public struct COSL {
    public let cos: UInt16
    public let lid: LID
    public let dwVersion: UInt32
    public let ceid: UInt16

    public init(dataStream: inout DataStream) throws {
        /// cos (2 bytes): An unsigned integer that specifies a NLCheck option set, which is implementationspecific to the grammar checker that is
        /// identified by lid, dwVersion, and ceid.
        /// The cos values for English, Spanish, French, German and Japanese MUST be one of the following values.
        /// Language Value Meaning
        /// English 0x0000 Grammar & Style
        /// English 0x0001 Grammar
        /// Spanish 0x0000 Grammar & Style
        /// Spanish 0x0001 Grammar
        /// French 0x0000 Grammar & Style
        /// French 0x0001 Grammar
        /// German 0x0000 User-defined
        /// German 0x0001 Grammar
        /// Japanese 0x0000 Casual Style
        /// Japanese 0x0001 Normal Style
        /// Japanese 0x0002 Normal Style (editorial)
        /// Japanese 0x0003 Official Style (editorial)
        /// Japanese 0x0004 User-defined 1
        /// Japanese 0x0005 User-defined 2
        /// Japanese 0x0006 User-defined 3
        /// By default, the value is 0x0001.
        self.cos = try dataStream.read(endianess: .littleEndian)
        
        /// lid (2 bytes): A LID that specifies the language of the associated grammar checker.
        self.lid = try dataStream.read(endianess: .littleEndian)
        
        /// dwVersion (4 bytes): An unsigned integer value that is the version number of the associated grammar checker, as specified through NLCheck.
        self.dwVersion = try dataStream.read(endianess: .littleEndian)
        
        /// ceid (2 bytes): An unsigned integer value that is the company identifier of the associated grammar checker, as specified through NLCheck.
        self.ceid = try dataStream.read(endianess: .littleEndian)
    }
}
