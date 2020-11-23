//
//  StkTableGRLPUPX.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.270 StkTableGRLPUPX
/// The StkTableGRLPUPX structure specifies the formatting properties for a table style. This structure is variable in length. All members of
/// StkTableGRLPUPX are optional, but those members that are present MUST appear in the order that is specified in the following table.
/// Additionally, the number of members that are present MUST match the cupx member of StdfBase for the style.
public struct StkTableGRLPUPX {
    public let lpUpxTapx: LPUpxTapx?
    public let lpUpxPapx: LPUpxPapx?
    public let lpUpxChpx: LPUpxChpx?
    
    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position
        if size == 0 {
            self.lpUpxTapx = nil
            self.lpUpxPapx = nil
            self.lpUpxChpx = nil
            return
        }
        
        /// lpUpxTapx (variable): An LPUpxTapx that specifies the table formatting properties for the style.
        self.lpUpxTapx = try LPUpxTapx(dataStream: &dataStream)
        if dataStream.position - startPosition == size {
            self.lpUpxPapx = nil
            self.lpUpxChpx = nil
            return
        }
        
        /// lpUpxPapx (variable): An LPUpxPapx that specifies the paragraph formatting properties for the style.
        self.lpUpxPapx = try LPUpxPapx(dataStream: &dataStream)
        if dataStream.position - startPosition == size {
            self.lpUpxChpx = nil
            return
        }
        
        /// lpUpxChpx (variable): An LPUpxChpx that specifies the character formatting properties for the style.
        self.lpUpxChpx = try LPUpxChpx(dataStream: &dataStream)
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
