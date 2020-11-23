//
//  BKL.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.11 BKL
/// The BKL structure links the end of a bookmark to the beginning of the same bookmark
public struct BKL {
    public let ibkf: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// ibkf (4 bytes): An unsigned integer that specifies a zero-based index into the PlcBkfd that is paired with the PlcBkld containing this BKL.
        /// The entry found at this index specifies the location of the beginning of the bookmark associated with this BKL. Ibkf MUST be unique for all
        /// BKLs in a given PlcBkld.
        self.ibkf = try dataStream.read(endianess: .littleEndian)
    }
}
