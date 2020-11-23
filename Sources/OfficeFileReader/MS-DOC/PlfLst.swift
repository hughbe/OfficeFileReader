//
//  PlfLst.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.201 PlfLst
/// The PlfLst structure contains the list formatting information for the document.
public struct PlfLst {
    public let cLst: Int16
    public let rgLstf: [LSTF]
    
    public init(dataStream: inout DataStream) throws {
        /// cLst (2 bytes): A signed integer that specifies the count of LSTF structures that are contained in rgLstf.
        self.cLst = try dataStream.read(endianess: .littleEndian)
        if self.cLst < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rgLstf (variable): An array of LSTF. The number of elements that are contained in this array is specified by cLst.
        var rgLstf: [LSTF] = []
        rgLstf.reserveCapacity(Int(self.cLst))
        for _ in 0..<self.cLst {
            rgLstf.append(try LSTF(dataStream: &dataStream))
        }
        
        self.rgLstf = rgLstf
    }
}
