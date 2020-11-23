//
//  PlcfTxbxBkd.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.30 PlcfTxbxBkd
/// The PlcfTxbxBkd structure is a PLC structure where the data elements are Tbkd structures (6 bytes each).
public struct PlcfTxbxBkd: PLC {
    public let aCP: [CP]
    public let aTbkd: [Tbkd]

    public var aData: [Tbkd] { aTbkd }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 6)
        
        /// aCP (variable): An array of CPs. CPs are positions in the textboxes document.
        /// Each CP specifies the beginning of a range of text to appear in a textbox specified in the corresponding Tbkd structure. The range of
        /// text ends immediately prior to the next CP. The last CP does not begin a new text range; it only terminates the previous one.
        /// A PlcfTxbxBkd MUST NOT contain duplicate CPs.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aTbkd (variable): An array of 6-byte Tbkd structures that associate the text ranges with FTXBXS objects from PlcftxbxTxt.
        var aTbkd: [Tbkd] = []
        aTbkd.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aTbkd.append(try Tbkd(dataStream: &dataStream))
        }
        
        self.aTbkd = aTbkd
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
