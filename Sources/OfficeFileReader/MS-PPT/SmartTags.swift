//
//  SmartTags.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.34 SmartTags
/// Referenced by: TextSIException
/// A structure that specifies the smart tags attached to a run of text.
public struct SmartTags {
    public let count: UInt32
    public let rgSmartTagIndex: [SmartTagIndex]
    
    public init(dataStream: inout DataStream) throws {
        /// count (4 bytes): An unsigned integer specifies the count of items in rgSmartTagIndex.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// rgSmartTagIndex (variable): An array of SmartTagIndex that specifies the indices. The count of items in the array is specified by count.
        var rgSmartTagIndex: [SmartTagIndex] = []
        rgSmartTagIndex.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            rgSmartTagIndex.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.rgSmartTagIndex = rgSmartTagIndex
    }
}
