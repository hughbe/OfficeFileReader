//
//  BKFD.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.10 BKFD
/// The BKFD structure is a BKF with additional information used for structured document tag bookmarks.
public struct BKFD {
    public let bkf: BKF
    public let cDepth: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// bkf (6 bytes): A BKF specifying further information about the bookmark.
        self.bkf = try BKF(dataStream: &dataStream)
        
        /// cDepth (4 bytes): An integer specifying the number of bookmarks in the document of the same type as the bookmark associated with this BKFD,
        /// the ranges of which overlap the beginning of the range of this bookmark. To increment the count, a bookmark MUST meet the following constraints:
        /// 1. The BKFD of the bookmark occupies the PlcBkfd containing this BKFD
        /// 2. The start CP (cpS) and limit CP (cpL) of the bookmark, as defined in the prose for that PlcBkfd and the PlcBkld it is paired with, satisfy the
        /// following in relation to the CP (cpCur) marking the beginning of the bookmark of this BKFD: cpS == cpCur == cpL || cpS <= cpCur < cpL
        /// Because BKFD is associated only with structured document tag bookmarks, cDepth can be
        /// rephrased more simply as the one-based count of other structured document tag bookmarks in
        /// the file that contain the bookmark associated with this BKFD.
        self.cDepth = try dataStream.read(endianess: .littleEndian)
    }
}
