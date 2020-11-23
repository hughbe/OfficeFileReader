//
//  Plcfbkld.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.13 Plcfbkld
/// The Plcfbkld structure is a PLC whose data elements are FBKLD structures (4 bytes each). Each CP in the PLCFBKLD that is not the last CP represents the
/// character position of the first character following the end of a bookmark in a document part. Further constraints on the CPs inside a PLCFBKLD can be
/// found in the description of PLCFBKFD.
public struct Plcfbkld: PLC {
    public let aCP: [CP]
    public let aFBKLD: [FBKLD]

    public var aData: [FBKLD] { aFBKLD }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 4)
        
        /// aCP (variable): An array of CPs. Each CP in the array indicates the first character following the end of a bookmark in the document.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aFBKLD (variable): An array of FBKLDs (4 bytes each), each of which specifies additional information about the bookmark ending at the
        /// corresponding CP in aCP.
        var aFBKLD: [FBKLD] = []
        aFBKLD.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aFBKLD.append(try FBKLD(dataStream: &dataStream))
        }
        
        self.aFBKLD = aFBKLD
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
