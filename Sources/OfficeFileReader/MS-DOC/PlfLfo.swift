//
//  PlfLfo.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.200 PlfLfo
/// The PlfLfo structure contains the list format override data for the document.
public struct PlfLfo {
    public let lfoMac: Int32
    public let rgLfo: [LFO]
    public let rgLfoData: [LFOData]
    
    public init(dataStream: inout DataStream) throws {
        /// lfoMac (4 bytes): An unsigned integer that specifies the count of elements in both the rgLfo and rgLfoData arrays.
        self.lfoMac = try dataStream.read(endianess: .littleEndian)
        
        /// rgLfo (variable): An array of LFO structures. The number of elements in this array is specified by lfoMac.
        var rgLfo: [LFO] = []
        rgLfo.reserveCapacity(Int(self.lfoMac))
        for _ in 0..<self.lfoMac {
            rgLfo.append(try LFO(dataStream: &dataStream))
        }
        
        self.rgLfo = rgLfo
        
        /// rgLfoData (variable): An array of LFOData that is parallel to rgLfo. The number of elements that are contained in this array is specified
        /// by lfoMac.
        var rgLfoData: [LFOData] = []
        rgLfoData.reserveCapacity(Int(self.lfoMac))
        for i in 0..<self.lfoMac {
            rgLfoData.append(try LFOData(dataStream: &dataStream, lfo: rgLfo[Int(i)]))
        }
        
        self.rgLfoData = rgLfoData
    }
}
