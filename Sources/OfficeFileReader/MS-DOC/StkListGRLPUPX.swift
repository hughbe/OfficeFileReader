//
//  StkListGRLPUPX.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.266 StkListGRLPUPX
/// The StkListGRLPUPX structure specifies formatting properties for a numbering style.
/// Each set of formatting properties is a length-prefixed variable-length structure. All members of StkListGRLPUPX are optional, but those that are
/// present MUST appear in the order that is specified in the following table. Additionally, the number of members that are present MUST match
/// the cupx member of StdfBase for the style.
public struct StkListGRLPUPX {
    public let lpUpxPapx: LPUpxPapx?
    
    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position
        if size == 0 {
            self.lpUpxPapx = nil
            return
        }
        
        /// lpUpxPapx (variable): An LPUpxPapx that specifies the paragraph formatting properties for the style.
        self.lpUpxPapx = try LPUpxPapx(dataStream: &dataStream)
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
