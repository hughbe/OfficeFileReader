//
//  LFOData.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.132 LFOData
/// The LFOData structure contains the Main Document CP of the corresponding LFO, as well as an array of LVL override data.
public struct LFOData {
    public let cp: CP
    public let rgLfoLvl: [LFOLVL]
    
    public init(dataStream: inout DataStream, lfo: LFO) throws {
        /// cp (4 bytes): A CP that specifies the position of the first paragraph in the Main Document whose iLfo property (see sprmPIlfo) specifies the
        /// corresponding LFO. If this is equal to 0xFFFFFFFF, this MUST be ignored.
        self.cp = try dataStream.read(endianess: .littleEndian)
        
        /// rgLfoLvl (variable): An array of LFOLVL. The cLfolvl field of the corresponding LFO specifies the count of elements in this array.
        var rgLfoLvl: [LFOLVL] = []
        rgLfoLvl.reserveCapacity(Int(lfo.clfolvl))
        for _ in 0..<lfo.clfolvl {
            rgLfoLvl.append(try LFOLVL(dataStream: &dataStream))
        }
        
        self.rgLfoLvl = rgLfoLvl
    }
}
