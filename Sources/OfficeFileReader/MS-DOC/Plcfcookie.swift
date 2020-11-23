//
//  PlcfcookieOld.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.14 Plcfcookie
/// The Plcfcookie structure is a PLC whose data elements are FCKS structures (10 bytes).
public struct Plcfcookie: PLC {
    public let aCP: [CP]
    public let aFCKS: [FCKS]

    public var aData: [FCKS] { aFCKS }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 10)
        
        /// aCP (variable): An array of CPs specifying the starting points of text ranges associated with grammar checker cookie data. The last
        /// CP in the array MUST be ignored. CPs are positions in the set of all document parts. CPs are relative to the start of the main document,
        /// but can extend into any of the document parts. A Plcfcookie MAY contain duplicate CP values if the corresponding grammar checker
        /// chose to store more than one grammar checker cookie at the same CP.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aFCKS (variable): An array of FCKS structures (10 bytes each). Each FCKS specifies information about a grammar checker cookie
        /// which applies to text starting at the corresponding CP value.
        var aFCKS: [FCKS] = []
        aFCKS.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aFCKS.append(try FCKS(dataStream: &dataStream))
        }
        
        self.aFCKS = aFCKS
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
