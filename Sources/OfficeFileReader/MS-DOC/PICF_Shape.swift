//
//  PICF_Shape.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.9.191 PICF_Shape
/// The PICF_Shape structure specifies additional header information for pictures of type MM_SHAPE or MM_SHAPEFILE.
public struct PICF_Shape {
    public let grf: UInt32
    public let padding1: UInt32
    public let mmPM: UInt32
    public let padding2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// grf (4 bytes): This field MUST be ignored.
        self.grf = try dataStream.read(endianess: .littleEndian)
        
        /// padding1 (4 bytes): This value MUST be zero and MUST be ignored.
        self.padding1 = try dataStream.read(endianess: .littleEndian)
        
        /// mmPM (2 bytes): This field MUST be ignored.
        self.mmPM = try dataStream.read(endianess: .littleEndian)
        
        /// padding2 (4 bytes): This field MUST be zero and MUST be ignored.
        self.padding2 = try dataStream.read(endianess: .littleEndian)
    }
}
