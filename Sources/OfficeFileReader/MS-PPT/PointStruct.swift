//
//  PointStruct.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.12.5 PointStruct
/// Referenced by: Comment10Atom, DocumentAtom, NoZoomViewInfoAtom, ZoomViewInfoAtom
/// A structure that specifies a point in the x-y coordinate system.
public struct PointStruct {
    public let x: Int32
    public let y: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// x (4 bytes): A signed integer that specifies the x-coordinate. Positive x increases to the right.
        self.x = try dataStream.read(endianess: .littleEndian)
        
        /// y (4 bytes): A signed integer that specifies the y-coordinate. Positive y increases to the bottom.
        self.y = try dataStream.read(endianess: .littleEndian)
    }
}
