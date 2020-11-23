//
//  SmallRectStruct.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.12.8 SmallRectStruct
/// Referenced by: OfficeArtClientAnchorData
/// A structure that specifies a small rectangle.
public struct SmallRectStruct {
    public let top: Int16
    public let left: Int16
    public let right: Int16
    public let bottom: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// top (2 bytes): A signed integer that specifies the minimum y-value of the rectangle.
        self.top = try dataStream.read(endianess: .littleEndian)
        
        /// left (2 bytes): A signed integer that specifies the minimum x-value of the rectangle.
        self.left = try dataStream.read(endianess: .littleEndian)
        
        /// right (2 bytes): A signed integer that specifies the maximum x-value of the rectangle.
        self.right = try dataStream.read(endianess: .littleEndian)
        
        /// bottom (2 bytes): A signed integer that specifies the maximum y-value of the rectangle.
        self.bottom = try dataStream.read(endianess: .littleEndian)
    }
}
