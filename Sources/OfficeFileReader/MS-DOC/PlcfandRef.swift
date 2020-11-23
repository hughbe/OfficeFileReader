//
//  PlcfandRef.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.7 PlcfandRef
/// The PlcfandRef structure is a PLC whose data elements are ATRDPre10 structures (30 bytes each).
public struct PlcfandRef: PLC {
    public let aCP: [CP]
    public let aATRDPre10: [ATRDPre10]

    public var aData: [ATRDPre10] { aATRDPre10 }
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfElements = Self.numberOfDataElements(cbPlc: size, cbData: 30)
        
        /// aCP (variable): An array of CPs, all but the last of which specify the location of comment references in the main document. All but the last CP
        /// MUST be greater than or equal to zero and less than FibRgLw97.ccpText. Each position in the main document specified by one of these CPs
        /// MUST be character 0x05 and have sprmCFSpec applied with a value of 1. The last CP MUST be ignored. A PlcfandRef MUST NOT contain
        /// duplicate CPs.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfElements + 1))
        for _ in 0..<numberOfElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.aCP = aCP
        
        /// aATRDPre10 (variable): An array of ATRDPre10 structures (30 bytes each) that associate data with a comment located at the corresponding CP.
        /// Each ATRDPre10 structure contains the initials of the user who made the comment, an index into a string table of authors, and a bookmark index.
        /// See ATRDPre10 and ATRDPost10 for more information about data associated with comments.
        var aATRDPre10: [ATRDPre10] = []
        aATRDPre10.reserveCapacity(Int(numberOfElements))
        for _ in 0..<numberOfElements {
            aATRDPre10.append(try ATRDPre10(dataStream: &dataStream))
        }
        
        self.aATRDPre10 = aATRDPre10
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
