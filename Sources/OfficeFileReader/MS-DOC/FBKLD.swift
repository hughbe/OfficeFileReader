//
//  FBKLD.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.72 FBKLD
/// The FBKLD structure contains information about a bookmark.
public struct FBKLD {
    public let ibkf: UInt16
    public let cDepth: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// ibkf (2 bytes): An unsigned integer that specifies a zero-based index into the PlcfBkfd that is paired with the PlcfBkld containing this
        /// FBKLD. The entry that is found at the index specifies the location of the start of the bookmark. Ibkf MUST be unique for all FBKLDs
        /// in a given PlcfBkld.
        self.ibkf = try dataStream.read(endianess: .littleEndian)
        
        /// cDepth (2 bytes): An integer that specifies the number of bookmarks in the document of the same type as the bookmark associated
        /// with this FBKLD, the ranges of which overlap the limit of the range of this bookmark. To increment the count, a bookmark MUST
        /// meet the following constraints:
        ///  The FBKLD of the bookmark occupies the PlcfBkld containing this FBKLD.
        ///  The limit CP (cpL) and the start CP (cpS) of the bookmark, as specified in the PlcfBkld and the PlcfBkfd it is paired with, satisfy
        /// the following in relation to the CP (cpCur) that marks the limit of the bookmark of this FBKLD.
        /// cps =/= cpL
        /// cpS <= cpCur < cpL
        self.cDepth = try dataStream.read(endianess: .littleEndian)
    }
}
