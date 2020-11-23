//
//  BKF.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.9 BKF
/// The BKF structure contains information about a bookmark.
public struct BKF {
    public let ibkl: UInt32
    public let bkc: BKC
    
    public init(dataStream: inout DataStream) throws {
        /// ibkl (4 bytes): An unsigned integer that specifies a zero-based index into the PlcBkl or PlcBkld that is paired with the PlcBkf or PlcBkfd containing
        /// this BKF. The entry found at that index specifies the location of the end of the bookmark that is associated with this BKF. Ibkl MUST be unique
        /// for all BKFs in a given PlcBkf or PlcBkfd.
        self.ibkl = try dataStream.read(endianess: .littleEndian)
        
        /// bkc (2 bytes): A BKC that specifies further information about the bookmark.
        self.bkc = try BKC(dataStream: &dataStream)
    }
}
