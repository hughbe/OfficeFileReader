//
//  Clx.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.38 Clx
/// The Clx structure is an array of zero, 1, or more Prcs followed by a Pcdt.
public struct Clx {
    public let rgPrc: [Prc]
    public let pcdt: Pcdt
    
    public init(dataStream: inout DataStream, fibRgLw97: FibRgLw97) throws {
        /// RgPrc (variable): An array of Prc. If this array is empty, the first byte of the Clx MUST be 0x02. 0x02 is invalid as the first byte of a Prc,
        /// but required for the Pcdt.
        var rgPrc: [Prc] = []
        while try dataStream.peek() as UInt8 != 0x02 {
            let prc = try Prc(dataStream: &dataStream)
            rgPrc.append(prc)
        }
        
        self.rgPrc = rgPrc
        
        /// Pcdt (variable): A Pcdt.
        self.pcdt = try Pcdt(dataStream: &dataStream, fibRgLw97: fibRgLw97)
    }
}
