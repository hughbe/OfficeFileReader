//
//  PlcPcd.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.35 PlcPcd
/// The PlcPcd structure is a PLC whose data elements are Pcds (8 bytes each). A PlcPcd MUST NOT contain duplicate CPs.
public struct PlcPcd: PLC {
    public let aCP: [CP]
    public let aPcd: [Pcd]
    
    public var aData: [Pcd] { aPcd }

    public init(dataStream: inout DataStream, fibRgLw97: FibRgLw97, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 8)
        
        /// aCP (variable): An array of CPs that specifies the starting points of text ranges. The end of each range is the beginning of the next
        /// range. All CPs MUST be greater than or equal to zero. If any of the fields ccpFtn, ccpHdd, ccpMcr, ccpAtn, ccpEdn, ccpTxbx, or
        /// ccpHdrTxbx from FibRgLw97 are nonzero, then the last CP MUST be equal to the sum of those fields plus ccpText+1.
        /// Otherwise, the last CP MUST be equal to ccpText.
        let sum = fibRgLw97.ccpFtn + fibRgLw97.ccpHdd + fibRgLw97.reserved3 + fibRgLw97.ccpAtn + fibRgLw97.ccpEdn + fibRgLw97.ccpTxbx + fibRgLw97.ccpHdrTxbx
        let lastCp: Int32
        if sum != 0 {
            lastCp = sum + fibRgLw97.ccpText + 1
        } else {
            lastCp = fibRgLw97.ccpText
        }
        
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }
        
        if aCP.last! != lastCp || aCP.count != numberOfDataElements + 1 {
            throw OfficeFileError.corrupted
        }

        self.aCP = aCP
        
        /// aPcd (variable): An array of Pcds (8 bytes each) that specify the location of text in the WordDocument stream and any additional
        /// properties of the text. If aPcd[i].fc.fCompressed is 1, then the byte offset of the last character of the text referenced by aPcd[i]
        /// is given by the following.
        /// Otherwise, the byte offset of the last character of the text referenced by aPcd[i] is given by the following.
        /// Because aCP MUST be sorted in ascending order and MUST NOT contain duplicate CPs, (aCP[i+1]-aCP[i])>0, for all valid indexes
        /// i of aPcd. Because a PLC MUST contain one more CP than a data element, i+1 is a valid index of aCP if i is a valid index of aPcd.
        var aPcd: [Pcd] = []
        aPcd.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aPcd.append(try Pcd(dataStream: &dataStream))
        }
        
        self.aPcd = aPcd
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
