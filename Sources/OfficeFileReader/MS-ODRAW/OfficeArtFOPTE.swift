//
//  OfficeArtFOPTE.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.7 OfficeArtFOPTE
/// The OfficeArtFOPTE record specifies an entry in a property table. An entry consists of an identifier and a value. Some property values, such as
/// Unicode strings, do not fit in 32 bits. For these properties, the fComplex bit is set, and the size of the data is saved in the op field. The data of the
/// complex properties follows the array of property table entries in the property table.
public struct OfficeArtFOPTE {
    public let opid: OfficeArtFOPTEOPID
    public let op: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// opid (2 bytes): An OfficeArtFOPTEOPID record, as defined in section 2.2.8, that specifies the header information for this property.
        self.opid = try OfficeArtFOPTEOPID(dataStream: &dataStream)
        
        /// op (4 bytes): A signed integer that specifies the value for this property.
        self.op = try dataStream.read(endianess: .littleEndian)
    }
}
