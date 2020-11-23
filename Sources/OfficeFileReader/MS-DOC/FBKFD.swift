//
//  FBKFD.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.71 FBKFD
/// The FBKFD structure contains information about a bookmark.
public struct FBKFD {
    public let fbkf: FBKF
    public let cDepth: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// fbkf (4 bytes): An FBKF specifying further information about the bookmark.
        self.fbkf = try FBKF(dataStream: &dataStream)
        
        /// cDepth (2 bytes): An integer value that specifies the number of bookmarks in the document of the same type as the bookmark
        /// associated with this FBKFD, the ranges of which overlap the beginning of the range of this bookmark. To increment the count, a
        /// bookmark MUST meet the following constraints:
        ///  The FBKFD of the bookmark occupies the PlcfBkfd containing this FBKLD.
        ///  The starting CP (cpS) and limit CP (cpL) of the bookmark, as defined in the specification of that PlcfBkfd and the PlcfBkld it is
        /// paired with, satisfy the following in relation to the CP (cpCur) that marks the beginning of the bookmark of this FBKFD.
        /// cpS == cpCur == cpL || cpS <= cpCur <cpL
        self.cDepth = try dataStream.read(endianess: .littleEndian)
    }
}
