//
//  PlcfAsumy.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.9 PlcfAsumy
/// The PlcfAsumy structure is a PLC whose data elements are ASUMY (4 bytes each)
public struct PlcfAsumy: PLC {
    public let aCP: [CP]
    public let aASUMY: [ASUMY]

    public var aData: [ASUMY] { aASUMY }
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfElements = Self.numberOfDataElements(cbPlc: size, cbData: 6)
        
        /// aCP (variable): An array of CPs. CPs are positions in the set of all document parts. CPs are relative to the start of the main document,
        /// but can extend into any of the document parts.
        /// Each CP specifies the beginning of a range of text to which the corresponding ASUMY structure applies. The range of text ends
        /// immediately prior to the next CP. A PlcfAsumy MUST NOT contain duplicate CPs.
        /// The last CP does not begin a new text range; it only terminates the previous one.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfElements + 1))
        for _ in 0..<numberOfElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.aCP = aCP
        
        /// aASUMY (variable): An array of FBKFs (4 bytes each), each of which specifies additional information about the bookmark starting at the
        /// corresponding CP in aCP.
        var aASUMY: [ASUMY] = []
        aASUMY.reserveCapacity(Int(numberOfElements))
        for _ in 0..<numberOfElements {
            aASUMY.append(try ASUMY(dataStream: &dataStream))
        }
        
        self.aASUMY = aASUMY
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
