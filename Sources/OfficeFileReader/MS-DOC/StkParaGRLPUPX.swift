//
//  StkParaGRLPUPX.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.267 StkParaGRLPUPX
/// The StkParaGRLPUPX structure that specifies the formatting properties for a paragraph style. All members of StkParaGRLPUPX are optional,
/// but those that are present MUST appear in the order that is specified in the following table. Additionally, the number of members that are
/// present MUST match the cupx member of StdfBase for the style.
public struct StkParaGRLPUPX {
    public let lpUpxPapx: LPUpxPapx?
    public let lpUpxChpx: LPUpxChpx?
    public let stkParaLPUpxGrLPUpxRM: StkParaLPUpxGrLPUpxRM?
    
    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position
        if size == 0 {
            self.lpUpxPapx = nil
            self.lpUpxChpx = nil
            self.stkParaLPUpxGrLPUpxRM = nil
            return
        }

        /// lpUpxPapx (variable): A LPUpxPapx that specifies the paragraph formatting properties for the style.
        self.lpUpxPapx = try LPUpxPapx(dataStream: &dataStream)
        if dataStream.position - startPosition == size {
            self.lpUpxChpx = nil
            self.stkParaLPUpxGrLPUpxRM = nil
            return
        }
        
        /// lpUpxChpx (variable): A LPUpxChpx that specifies the character formatting properties for the style.
        self.lpUpxChpx = try LPUpxChpx(dataStream: &dataStream)
        if dataStream.position - startPosition == size {
            self.stkParaLPUpxGrLPUpxRM = nil
            return
        }
        
        /// StkParaLpUpxGrLpUpxRM (variable): A StkParaLPUpxGrLPUpxRM that specifies the revisionmarking information and formatting
        /// for the style.
        self.stkParaLPUpxGrLPUpxRM = try StkParaLPUpxGrLPUpxRM(dataStream: &dataStream)
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
