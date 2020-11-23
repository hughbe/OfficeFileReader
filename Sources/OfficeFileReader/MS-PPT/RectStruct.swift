//
//  RectStruct.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.12.7 RectStruct
/// Referenced by: OfficeArtClientAnchorData
/// A structure that specifies a rectangle.
public struct RectStruct {
    public let top: Int32
    public let left: Int32
    public let right: Int32
    public let bottom: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// top (4 bytes): A signed integer that specifies the minimum y-value of the rectangle.
        self.top = try dataStream.read(endianess: .littleEndian)
        
        /// left (4 bytes): A signed integer that specifies the minimum x-value of the rectangle.
        self.left = try dataStream.read(endianess: .littleEndian)
        
        /// right (4 bytes): A signed integer that specifies the maximum x-value of the rectangle.
        self.right = try dataStream.read(endianess: .littleEndian)
        
        /// bottom (4 bytes): A signed integer that specifies the maximum y-value of the rectangle.
        self.bottom = try dataStream.read(endianess: .littleEndian)
    }
}
