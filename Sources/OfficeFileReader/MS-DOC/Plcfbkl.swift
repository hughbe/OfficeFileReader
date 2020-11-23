//
//  Plcfbkl.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.12 Plcfbkl
/// The Plcfbkl structure is a PLC that contains only CPs and no additional data. Thus, a Plcfbkl is equivalent to a PlcBkl. Each CP in the PLCFBKL, with the
/// exception of the last CP, represents the character position marking the first character following the end of a bookmark in a document part.
/// Further constraints on the CPs inside a PLCFBKL can be found in the description of PLCFBKF.
public struct Plcfbkl: PLC {
    public let aCP: [CP]
    public var aData: [Any] = []

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 0)
        
        /// aCP (variable): An array of CPs. Each CP in the array indicates the first character following the end of a bookmark in the document.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
