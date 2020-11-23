//
//  Rca.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.222 Rca
/// The Rca structure is used to define the coordinates of a rectangular area in the document. Unless otherwise specified by the other structures that
/// use this structure, the origin is at the top left of the page and the units are in twips.
public struct Rca {
    public let left: Int32
    public let top: Int32
    public let right: Int32
    public let bottom: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// left (4 bytes): An integer that specifies the X coordinate of the top left corner of the rectangle.
        self.left = try dataStream.read(endianess: .littleEndian)
        
        /// top (4 bytes): An integer that specifies the Y coordinate of the top left corner of the rectangle.
        self.top = try dataStream.read(endianess: .littleEndian)
        
        /// right (4 bytes): An integer that specifies the X coordinate of the bottom right corner of the rectangle.
        self.right = try dataStream.read(endianess: .littleEndian)
        
        /// bottom (4 bytes): An integer that specifies the X coordinate of the bottom right corner of the rectangle.
        self.bottom = try dataStream.read(endianess: .littleEndian)
    }
}
