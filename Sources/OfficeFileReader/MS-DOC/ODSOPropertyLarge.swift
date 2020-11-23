//
//  ODSOPropertyLarge.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.163 ODSOPropertyLarge
/// The ODSOPropertyLarge structure contains an ODSO property that is at least 0xFFFF bytes in size. See specifications of the ODSO property
/// types under ODSOPropertyBase.id.
public struct ODSOPropertyLarge {
    public let dwb: UInt32
    public let odsoPropLrg: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// dwb (4 bytes): An unsigned integer that specifies the size, in bytes, of the OdsoPropLrg element.
        self.dwb = try dataStream.read(endianess: .littleEndian)
        
        /// OdsoPropLrg (variable): Contains the data for this property.
        self.odsoPropLrg = try dataStream.readBytes(count: Int(self.dwb))
    }
}
