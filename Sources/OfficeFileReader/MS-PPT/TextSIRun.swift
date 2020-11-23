//
//  TextSIRun.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.55 TextSIRun
/// Referenced by: TextSpecialInfoAtom
/// A structure that specifies language and spelling information for a run of text.
/// Let the corresponding text be as specified in the TextSpecialInfoAtom record that contains this TextSIRun structure.
public struct TextSIRun {
    public let count: UInt32
    public let si: TextSIException
    
    public init(dataStream: inout DataStream) throws {
        /// count (4 bytes): An unsigned integer that specifies the number of characters of the corresponding text to which these additional text properties
        /// apply. It MUST be greater than or equal to 0x00000001.
        self.count = try dataStream.read(endianess: .littleEndian)
        if self.count < 0x00000001 {
            throw OfficeFileError.corrupted
        }
        
        /// si (variable): A TextSIException structure that specifies language and spelling information.
        self.si = try TextSIException(dataStream: &dataStream)
    }
}
