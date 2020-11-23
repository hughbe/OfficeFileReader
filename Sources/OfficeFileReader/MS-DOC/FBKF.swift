//
//  FBKF.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.70 FBKF
/// The FBKF structure contains information about a bookmark.
public struct FBKF {
    public let ibkl: UInt16
    public let bkc: BKC
    
    public init(dataStream: inout DataStream) throws {
        /// ibkl (2 bytes): An unsigned integer that specifies a zero-based index into the PlcfBkl or PlcfBkld that is paired with the PlcfBkf or
        /// PlcfBkfd containing this FBKF. The entry that is found at such an index specifies the location of the end of the bookmark associated
        /// with this FBKF. Ibkl MUST be unique for all FBKFs inside a given PlcfBkf or PlcfBkfd.
        self.ibkl = try dataStream.read(endianess: .littleEndian)
        
        /// bkc (2 bytes): A BKC that specifies further information about the bookmark associated with this FBKF.
        self.bkc = try BKC(dataStream: &dataStream)
    }
}
