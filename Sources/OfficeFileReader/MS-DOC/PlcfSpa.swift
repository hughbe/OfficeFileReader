//
//  PlcfSpa.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.26 PlcfSpa
/// The PlcfSpa structure is a PLC structure where the data elements are Sed structures (12 bytes each).
public struct PlcfSpa: PLC {
    public let aCP: [CP]
    public let aSpa: [Spa]

    public var aData: [Spa] { aSpa }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 26)
        
        /// aCP (variable): An array of CPs. Each CP specifies the position in the document part of the anchor for a shape. This array MUST NOT
        /// contain duplicate CPs. The characters at all but the last CP MUST be 0x08 and MUST have sprmCFSpec applied with a value of 1.
        /// See sprmCFSpec for more information.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aSpa (variable): An array of SPAs (26 bytes each) that specify properties for the shape at the corresponding CP.
        var aSpa: [Spa] = []
        aSpa.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aSpa.append(try Spa(dataStream: &dataStream))
        }
        
        self.aSpa = aSpa
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
