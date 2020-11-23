//
//  PlcfendRef.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.16 PlcfendRef
/// The PlcfendRef is a PLC whose data elements are integers of 2 bytes each.
public struct PlcfendRef: PLC {
    public let aCP: [CP]
    public let aEndIdx: [UInt16]

    public var aData: [UInt16] { aEndIdx }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 2)
        
        /// aCP (variable): An array of CPs, all but the last of which specify the location of endnote references in the main document. All but the last CP
        /// MUST be greater than or equal to zero and less than FibRgLw97.ccpText. The last CP MUST be ignored. A PlcfendRef MUST NOT contain
        /// duplicate CPs.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aEndIdx (variable): An array of 2-byte integers that specifies whether each endnote is automatically numbered or uses a custom symbol. If equal
        /// to zero, the endnote reference uses a custom symbol; otherwise, it is automatically numbered. If the endnote reference is automatically numbered,
        /// the character in the main document at the position specified by the corresponding CP MUST equal 0x02 and have sprmCFSpec applied with a
        /// value of 1. See sprmCSymbol for more information about custom symbols and sprmSRncEdn, sprmSNEdn, and sprmSNfcEdnRef for more
        /// information about automatically numbered endnotes.
        var aEndIdx: [UInt16] = []
        aEndIdx.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aEndIdx.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.aEndIdx = aEndIdx
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
