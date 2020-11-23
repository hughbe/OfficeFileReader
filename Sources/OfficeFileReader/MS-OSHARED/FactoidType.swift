//
//  FactoidType.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.4.2 FactoidType
/// Referenced by: PropertyBagStore
/// This structure specifies the type of smart tag.
public struct FactoidType {
    public let bFactoid: UInt32
    public let id: UInt32
    public let rgbUri: PBString
    public let rgbTag: PBString
    public let rgbDownLoadURL: PBString
    
    public init(dataStream: inout DataStream) throws {
        /// bFactoid (4 bytes): Unsigned integer specifying the count of total bytes, excluding itself, in the FactoidType structure.
        self.bFactoid = try dataStream.read(endianess: .littleEndian)
        
        /// id (4 bytes): Unsigned integer specifying the identifier of this smart tag type. There is a many-to-one mapping from the PropertyBag
        /// (section 2.3.4.3) to FactoidType using their respective id fields. MUST be less than or equal to 0xFFFF.
        self.id = try dataStream.read(endianess: .littleEndian)
        if self.id > 0xFFFF {
            throw OfficeFileError.corrupted
        }
        
        /// rgbUri (variable): A PBString structure (section 2.3.4.5) specifying the XML namespace Uniform Resource Identifier (URI) for the smart
        /// tag type.
        self.rgbUri = try PBString(dataStream: &dataStream)
        
        /// rgbTag (variable): A PBString structure (section 2.3.4.5) specifying the tag name for the smart tag type.
        self.rgbTag = try PBString(dataStream: &dataStream)
        
        /// rgbDownLoadURL (variable): A PBString structure (section 2.3.4.5) specifying the URL to download the particular smart tag type.
        self.rgbDownLoadURL = try PBString(dataStream: &dataStream)
    }
}
