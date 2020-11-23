//
//  BKLD.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.12 BKLD
/// The BKLD structure is a BKL with additional information used for structured document tag bookmarks.
public struct BKLD {
    public let bkl: BKL
    public let depth: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// bkl (4 bytes): A BKL specifying further information about the bookmark.
        self.bkl = try BKL(dataStream: &dataStream)
        
        /// Depth (4 bytes): An integer specifying the number of bookmarks in the document of the same type as the bookmark associated with this BKLD,
        /// the ranges of which overlap the limit of this bookmark range. To increment the count, a bookmark MUST meet the following constraints:
        /// 1. The bookmark BKLD occupies the PlcBkld containing this BKLD
        /// 2. The bookmark limit CP (cpL) and start CP (cpS), as defined in the specification of that PlcBkld and the PlcBkfd it is paired with, satisfy the
        /// following in relation to the CP (cpCur) marking the limit of the bookmark of this BKLD
        /// cpS =/= cpL
        /// cpS <= cpCur < cpL
        /// Because BKLD is only associated with structured document tag bookmarks, cDepth can be rephrased more simply as the zero-based count of
        /// other structured document tag bookmarks in the file that contain the bookmark associated with this BKLD.
        self.depth = try dataStream.read(endianess: .littleEndian)
    }
}
