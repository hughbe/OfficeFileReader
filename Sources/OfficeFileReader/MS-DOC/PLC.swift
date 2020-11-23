//
//  PLC.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.2.2 PLC
/// The PLC structure is an array of character positions followed by an array of data elements. The data elements for any PLC MUST be the same
/// size of zero or more bytes. The number of CPs MUST be one more than the number of data elements. The CPs MUST appear in ascending
/// order. There are different types of PLC structures, as specified in section 2.8. Each type specifies whether duplicate CPs are allowed for that type.
/// If the total size of a PLC (cbPlc) and the size of a single data element (cbData) are known, the number of data elements in that PLC (n) is given
/// by the following expression:
/// n = (cbPlc - 4) / (4 + cbData)
/// The preceding expression MUST yield a whole number for n.
public protocol PLC {
    associatedtype Data
    var aCP: [CP] { get }
    var aData: [Data] { get }
}

public extension PLC {
    static func numberOfDataElements(cbPlc: UInt32, cbData: UInt32) -> UInt32 {
        return (cbPlc - 4) / (4 + cbData)
    }
}
