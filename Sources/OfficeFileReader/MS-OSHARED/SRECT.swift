//
//  SRECT.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.5 SRECT
/// Referenced by: TBVisualData
/// Specifies a rectangle structure.
public struct SRECT {
    public let left: Int16
    public let top: Int16
    public let right: Int16
    public let bottom: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// left (2 bytes): Signed integer that specifies the position in pixels of the left side of the rectangle.
        self.left = try dataStream.read(endianess: .littleEndian)
    
        /// top (2 bytes): Signed integer that specifies the position in pixels of the top side of the rectangle.
        self.top = try dataStream.read(endianess: .littleEndian)
    
        /// right (2 bytes): Signed integer that specifies the position in pixels of the right side of the rectangle.
        self.right = try dataStream.read(endianess: .littleEndian)
        
        /// bottom (2 bytes): Signed integer that specifies the position in pixels of the bottom side of the rectangle.
        self.bottom = try dataStream.read(endianess: .littleEndian)
    }
}
