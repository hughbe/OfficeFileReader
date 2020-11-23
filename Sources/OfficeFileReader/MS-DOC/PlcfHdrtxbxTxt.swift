//
//  PlcfHdrtxbxTxt.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.23 PlcfHdrtxbxTxt
/// The PlcfHdrtxbxTxt structure is a PLC structure in which the data elements are FTXBXS structures (22 bytes each).
public struct PlcfHdrtxbxTxt: PLC {
    public let aCP: [CP]
    public let aFTXBXS: [FTXBXS]

    public var aData: [FTXBXS] { aFTXBXS }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 22)
        
        /// aCP (variable): An array of CPs. CPs are positions in the header textboxes document.
        /// Each CP specifies the beginning of a range of text to appear in a text box indicated by the corresponding FTXBXS structure. The range of text
        /// ends immediately prior to the next CP. The last CP does not begin a new text range; it only terminates the previous one.
        /// A PlcfHdrtxbxTxt MUST NOT contain duplicate CPs. The text ranges for each FTXBXS structure are separated by 0x0D characters that MUST
        /// be the last character in each range. The last text range is an exception. The text in the last range is ignored, and the 0x0D character is not
        /// required.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aFTXBXS (variable): An array of FTXBXS (22 bytes each) structures that associate the text ranges with shape objects.
        var aFTXBXS: [FTXBXS] = []
        aFTXBXS.reserveCapacity(Int(numberOfDataElements))
        for i in 0..<numberOfDataElements {
            aFTXBXS.append(try FTXBXS(dataStream: &dataStream, last: i == numberOfDataElements - 1))
        }
        
        self.aFTXBXS = aFTXBXS
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
