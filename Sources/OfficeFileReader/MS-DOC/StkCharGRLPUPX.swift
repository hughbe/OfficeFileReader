//
//  StkCharGRLPUPX.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.263 StkCharGRLPUPX
/// The StkCharGRLPUPX structure specifies the formatting properties for a character style. All members of StkCharGRLPUPX are optional,
/// but those that are present MUST appear in the order that is specified in the following table. Additionally, the number of members that are
/// present MUST match the cupx member of StdfBase for the style.
public struct StkCharGRLPUPX {
    public let lpUpxChpx: LPUpxChpx?
    public let stkCharLpUpxGrLpUpxRM: StkCharLPUpxGrLPUpxRM?
    
    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position
        if size == 0 {
            self.lpUpxChpx = nil
            self.stkCharLpUpxGrLpUpxRM = nil
            return
        }
        
        /// lpUpxChpx (variable): A LPUpxChpx that specifies the character formatting properties for the style.
        self.lpUpxChpx = try LPUpxChpx(dataStream: &dataStream)
        if dataStream.position - startPosition == size {
            self.stkCharLpUpxGrLpUpxRM = nil
            return
        }
        
        /// StkCharLpUpxGrLpUpxRM (variable): A StkCharLPUpxGrLPUpxRM that specifies the revisionmarking information and formatting
        /// for the style.
        self.stkCharLpUpxGrLpUpxRM = try StkCharLPUpxGrLPUpxRM(dataStream: &dataStream)
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
