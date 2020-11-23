//
//  Plcbkl.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.3 Plcbkl
/// A PLCBKL is a PLC that contains only CPs and no additional data. It is thus equivalent to a PlcfBkl. Each CP in the PLCBKL that is not the last CP
/// represents the character position marking the first character beyond the end of a bookmark in a Document Part. Additional constraints upon the CPs
/// inside a PLCBKL can be found in the specification of PLCBKF.
public struct Plcbkl: PLC {
    public let aCP: [CP]
    public var aData: [Any] = []

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 0)
        
        /// aCP (variable): An array of CPs, each indicating the first character beyond the end of a bookmark in the document.
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
