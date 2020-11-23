//
//  OfficeArtFDGG.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.47 OfficeArtFDGG
/// Referenced by: OfficeArtFDGGBlock
/// The OfficeArtFDGG record specifies document-wide information about all of the drawings that have been saved in the file.
public struct OfficeArtFDGG {
    public let spidMax: MSOSPID
    public let cidcl: UInt32
    public let cspSaved: UInt32
    public let cdgSaved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// spidMax (4 bytes): An MSOSPID structure, as defined in section 2.1.2, specifying the current maximum shape identifier that is used in any drawing.
        /// This value MUST be less than 0x03FFD7FF.
        self.spidMax = try dataStream.read(endianess: .littleEndian)
        if spidMax >= 0x03FFD7FF {
            throw OfficeFileError.corrupted
        }
        
        /// cidcl (4 bytes): An unsigned integer that specifies the number of OfficeArtIDCL records, as defined in section 2.2.46, + 1. This value MUST be less
        /// than 0x0FFFFFFF.
        self.cidcl = try dataStream.read(endianess: .littleEndian)
        if self.cidcl == 0x0FFFFFFF {
            throw OfficeFileError.corrupted
        }
        
        /// cspSaved (4 bytes): An unsigned integer specifying the total number of shapes that have been saved in all of the drawings.
        self.cspSaved = try dataStream.read(endianess: .littleEndian)
        
        /// cdgSaved (4 bytes): An unsigned integer specifying the total number of drawings that have been saved in the file.
        self.cdgSaved = try dataStream.read(endianess: .littleEndian)
    }
}
