//
//  Fld.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.88 Fld
/// The Fld structure specifies a field character.
public struct Fld {
    public let fldch: fldch
    public let grffld: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// fldch (1 byte): An fldch whose ch member controls the interpretation of grffld. This value MUST be 0x13, 0x14, or 0x15.
        self.fldch = try OfficeFileReader.fldch(dataStream: &dataStream)
        
        /// grffld (1 byte): The meaning of this field is dependent on the value of fldch, as defined following.
        /// fldch.ch Meaning
        /// 0x13 grffld is an unsigned integer that indicates the kind of field this was the last time that an application parsed it. The values are specified in flt.
        /// 0x14 grffld is unused and MUST be ignored.
        /// 0x15 grffld is a grffldEnd.
        self.grffld = try dataStream.read()
    }
}
