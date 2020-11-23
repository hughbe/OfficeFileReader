//
//  Plcbkf.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.1 Plcbkf
/// The Plcbkf structure is a PLC whose data elements are BKF structures (6 bytes each). Each CP in the PLCBKF, with the exception of the last
/// CP, represents the character position of the start of a bookmark in a Document Part. For every PLCBKF, there is a corresponding PLCBKL.
/// Each data element in the PLCBKF is associated in a one-to-one correlation with a data element in that PLCBKL, whose corresponding CP
/// represents the character position of the end of the same bookmark. Constraints on the CPs inside a PLCBKF as they relate to the CPs in its
/// corresponding PLCBKL can be found in the description of PLCFBKF, which shares the same constraints in relation to its corresponding PLCFBKL.
/// The only type of bookmark found in a PLCBKF is a range-level protection bookmark. The largest valid value for a CP marking the start or end of
/// a range-level protection bookmark is the CP representing the end of all document parts.
public struct Plcbkf: PLC {
    public let aCP: [CP]
    public let aBKF: [BKF]

    public var aData: [BKF] { aBKF }
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfElements = Self.numberOfDataElements(cbPlc: size, cbData: 6)
        
        /// aCP (variable): An array of CPs. Each CP in the array specifies the start of a bookmark in the document.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfElements + 1))
        for _ in 0..<numberOfElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.aCP = aCP
        
        /// aBKF (variable): An array of BKFs (6 bytes each), each of which specifies additional information about the bookmark starting at
        /// the corresponding CP in aCP.
        var aBKF: [BKF] = []
        aBKF.reserveCapacity(Int(numberOfElements))
        for _ in 0..<numberOfElements {
            aBKF.append(try BKF(dataStream: &dataStream))
        }
        
        self.aBKF = aBKF
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
