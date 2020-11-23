//
//  PlcffndTxt.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.20 PlcffndTxt
/// The PlcffndTxt structure is a PLC that contains only CPs and no additional data. The data thus has a size of 0 bytes.
public struct PlcffndTxt: PLC {
    public let aCP: [CP]
    public var aData: [Any] = []

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 0)
        
        /// aCP (variable): An array of CPs that specifies offsets into the footnote document. Each CP except the last two specifies the beginning of a
        /// range of text to appear in a footnote. The range of text MUST end in character 0x0D immediately before the next CP. Except for the last CP,
        /// each CP MUST be greater than or equal to zero and less than FibRgLw97.ccpFtn. The second-to-last CP only ends the last text range and
        /// MUST be equal to FibRgLw97.ccpFtn – 1. The last CP is undefined and MUST be ignored. A PlcffndTxt MUST NOT contain duplicate CPs.
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
