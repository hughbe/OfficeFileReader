//
//  Plcbkld.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.4 Plcbkld
/// A PLCBKLD is a PLC whose data elements are BKLD structures (8 bytes each). Each CP in the PLCBKLD, with the exception of the last CP, represents the
/// character position of the first character following the end of a bookmark in a Document Part. Additional constraints on the CPs inside a PLCBKLD can be
/// found in the description of PLCBKFD.
public struct Plcbkld: PLC {
    public let aCP: [CP]
    public let aBKLD: [BKLD]

    public var aData: [BKLD] { aBKLD }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 8)
        
        /// aCP (variable): An array of CPs. Each CP in the array indicates the first character following the end of a bookmark in the document.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aBKLD (variable): An array of BKLDs (8 bytes each), each of which specifies additional information about the bookmark ending at the
        /// corresponding CP in aCP.
        var aBKLD: [BKLD] = []
        aBKLD.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aBKLD.append(try BKLD(dataStream: &dataStream))
        }
        
        self.aBKLD = aBKLD
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
