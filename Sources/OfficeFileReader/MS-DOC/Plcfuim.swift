//
//  Plcfuim.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.33 Plcfuim
/// A Plcfuim structure is a PLC whose data elements are UIMs (20 bytes each), with the exception that the elements are not sorted according to their CPs.
public struct Plcfuim: PLC {
    public let aCP: [CP]
    public let aUIM: [UIM]

    public var aData: [UIM] { aUIM }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 20)
        
        /// aCP (variable): An array of CPs. CPs are positions in the set of all document parts. CPs are relative to the start of the main document
        /// but can extend into any of the document parts. Each CP in the Plcfuim, except the last one, represents the starting position of a range
        /// of text specified in the corresponding UIM. The last CP is undefined and MUST be ignored. Duplicate CPs are valid in a Plcfuim.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aUIM (variable): An array of UIMs.
        var aUIM: [UIM] = []
        aUIM.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aUIM.append(try UIM(dataStream: &dataStream))
        }
        
        self.aUIM = aUIM
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
