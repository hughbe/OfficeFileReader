//
//  TabStops.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.23 TabStops
/// Referenced by: TextPFException, TextRuler
/// A structure that specifies tab stops.
public struct TabStops {
    public let count: UInt16
    public let rgTabStop: [TabStop]
    
    public init(dataStream: inout DataStream) throws {
        /// count (2 bytes): An unsigned integer that specifies the count of tab stops in rgTabStop.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// rgTabStop (variable): An array of TabStop that specifies the tab stops. The length, in bytes, of the array is specified by the following formula:
        /// count * 4
        var rgTabStop: [TabStop] = []
        rgTabStop.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            rgTabStop.append(try TabStop(dataStream: &dataStream))
        }
        
        self.rgTabStop = rgTabStop
    }
}
