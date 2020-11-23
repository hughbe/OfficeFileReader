//
//  PlcfWKB.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.34 PlcfWKB
/// The PlcfWKB is a PLC whose data elements are WKB structures (12 bytes each). Each subdocument is assigned one WKB structure.
public struct PlcfWKB: PLC {
    public let aCP: [CP]
    public let aWKB: [WKB]

    public var aData: [WKB] { aWKB }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 12)
        
        /// aCP (variable): An array of CPs. CPs are relative to the start of the main document. Each CP in the PlcfWKB, except the last, specifies
        /// the location in the main document where a subdocument begins. The CPs, except for the last, MUST be unique, greater than or equal
        /// to zero, and less than FibBase.ccpText. The last CP MUST be FibBase.ccpText incremented by 2.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aWKB (variable): An array of WKBs. Each WKB contains information about a subdocument.
        var aWKB: [WKB] = []
        aWKB.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aWKB.append(try WKB(dataStream: &dataStream))
        }
        
        self.aWKB = aWKB
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
