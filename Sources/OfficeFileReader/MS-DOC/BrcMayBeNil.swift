//
//  BrcMayBeNil.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.20 BrcMayBeNil
/// The BrcMayBeNil structure is either a NilBrc or Brc structure, depending on the value of the last four bytes of the structure.
/// If the last four bytes are 0xFFFFFFFF, the BrcMayBeNil is a NilBrc that specifies that the table cells in question have no border. Otherwise, it is a Brc
/// structure that specifies the border type of table cells.
public enum BrcMayBeNil {
    case none(brcNil: NilBrc)
    case some(brc: Brc)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let _: UInt32 = try dataStream.read(endianess: .littleEndian)
        let nilBrc: UInt32 = try dataStream.read(endianess: .littleEndian)
        dataStream.position = position

        if nilBrc == 0xFFFFFFFF {
            self = .none(brcNil: try NilBrc(dataStream: &dataStream))
        } else {
            self = .some(brc: try Brc(dataStream: &dataStream))
        }
    }
}

