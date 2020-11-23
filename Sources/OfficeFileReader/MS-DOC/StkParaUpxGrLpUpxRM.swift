//
//  StkParaUpxGrLPUpxRM.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.269 StkParaUpxGrLPUpxRM
/// The StkParaUpxGrLPUpxRM structure specifies style revision-marking and formatting for paragraph styles.
public struct StkParaUpxGrLPUpxRM {
    public let lpUpxRm: LPUpxRm
    public let lpUpxPapxRM: LPUpxPapxRM
    public let lpUpxChpxRM: LPUpxChpxRM
    
    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position
        
        /// lpUpxRm (8 bytes): An LPUpxRm structure that specifies the revision-marking information for the style.
        self.lpUpxRm = try LPUpxRm(dataStream: &dataStream)
        
        /// lpUpxPapxRM (variable): An LPUpxPapxRM structure that specifies the paragraph formatting properties for the revision-marked
        /// style formatting.
        self.lpUpxPapxRM = try LPUpxPapxRM(dataStream: &dataStream)
        
        /// lpUpxChpxRM (variable): An LPUpxChpxRM structure that specifies the character formatting properties for the revision-marked
        /// style formatting.
        self.lpUpxChpxRM = try LPUpxChpxRM(dataStream: &dataStream)
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
