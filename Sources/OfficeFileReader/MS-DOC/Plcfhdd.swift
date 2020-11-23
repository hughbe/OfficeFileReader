//
//  Plcfhdd.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.22 Plcfhdd
/// The Plcfhdd structure is a PLC that contains only CPs and no additional data. It specifies where header document stories begin and end.
public struct Plcfhdd: PLC {
    public let aCP: [CP]
    public var aData: [Any] = []

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 0)
        
        /// aCP (variable): An array of CPs. Each CP except the last two specifies the beginning of a story in the header document. Each story ends
        /// immediately prior to the next CP. If the next CP in Plcfhdd has the same value as a CP specifying the beginning of a story, then the story
        /// is considered empty.
        /// Except for the last CP, each CP of Plcfhdd MUST be greater than or equal to 0 and less than FibRgLw97.ccpHdd. The second-to-last
        /// CP only ends the last story and MUST be equal to FibRgLw97.ccpHdd minus 1. The last CP is undefined and MUST be ignored.
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
