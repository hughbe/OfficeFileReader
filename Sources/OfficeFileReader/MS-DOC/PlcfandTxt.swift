//
//  PlcfandTxt.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.8 PlcfandTxt
/// The PlcfandTxt structure is a PLC that contains only CPs and no additional data. This means that the size of the data is 0 bytes.
public struct PlcfandTxt: PLC {
    public let aCP: [CP]
    public var aData: [Any] = []

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 0)
        
        /// aCP (variable): An array of CPs that specifies positions in the comment document. Each CP except the last two specifies the beginning
        /// of a range of text to appear in a comment indicated by the corresponding PlcfandRef CPs. The range of text MUST begin with character
        /// 0x0005 with sprmCFSpec applied with a value of 1, and MUST end with a paragraph mark (Unicode 0x000D) at table depth zero
        /// immediately before the next CP. Each range MUST be a valid selection. Except for the last CPs, each CP MUST be greater than or
        /// equal to zero and less than FibRgLw97.ccpAtn. The second-to-last CP only ends the last text range and MUST be equal to
        /// FibRgLw97.ccpAtn decremented by 1. The last CP is undefined and MUST be ignored. A PlcfandTxt MUST NOT contain duplicate CPs.
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
