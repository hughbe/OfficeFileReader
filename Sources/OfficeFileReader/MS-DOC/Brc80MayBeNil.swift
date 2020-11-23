//
//  Brc80MayBeNil.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.18 Brc80MayBeNil
/// The Brc80MayBeNil structure is a Brc80 structure. When all bits are set (0xFFFFFFFF when interpreted as a 4-byte unsigned integer), this structure
/// specifies that the region in question has no border.
public enum Brc80MayBeNil {
    case none
    case some(brc80: Brc80)
    
    public init(dataStream: inout DataStream) throws {
        let bits: UInt32 = try dataStream.peek(endianess: .littleEndian)
        if bits == 0xFFFFFFFF {
            self = .none
            dataStream.position += 4
        } else {
            self = .some(brc80: try Brc80(dataStream: &dataStream))
        }
    }
}
