//
//  StkCharUpxGrLPUpxRM.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.265 StkCharUpxGrLPUpxRM
/// The StkCharUpxGrLPUpxRM structure specifies revision-marking information and formatting for character styles.
public struct StkCharUpxGrLPUpxRM {
    public let lpUpxRm: LPUpxRm
    public let lpUpxChpxRM: LPUpxChpxRM
    
    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position

        /// lpUpxRm (8 bytes): An LPUpxRm structure that specifies the revision-marking information for the style.
        self.lpUpxRm = try LPUpxRm(dataStream: &dataStream)
        
        /// lpUpxChpxRM (variable): An LPUpxChpxRM that specifies the character formatting properties for the revision-marked style formatting.
        self.lpUpxChpxRM = try LPUpxChpxRM(dataStream: &dataStream)
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
