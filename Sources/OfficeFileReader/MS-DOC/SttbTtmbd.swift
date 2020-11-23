//
//  SttbTtmbd.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.296 SttbTtmbd
/// The SttbTtmbd structure contains the list of TrueType fonts that are embedded in the document.
public struct SttbTtmbd {
    public let sttb: SttbW6
    public let rgTTMBD: [Ttmbd]
    
    public init(dataStream: inout DataStream) throws {
        /// sttb (10 bytes): An SttbW6 structure that specifies the number of TrueType fonts that are embedded in the document.
        self.sttb = try SttbW6(dataStream: &dataStream)
        
        /// rgTTMBD (variable): An array of Ttmbd elements. The number of elements is equal to sttb.ibstMac and MUST NOT exceed 64.
        var rgTTMBD: [Ttmbd] = []
        rgTTMBD.reserveCapacity(Int(self.sttb.ibstMac))
        for _ in 0..<self.sttb.ibstMac {
            rgTTMBD.append(try Ttmbd(dataStream: &dataStream))
        }
        
        self.rgTTMBD = rgTTMBD
    }
}
