//
//  ScalingStruct.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-PPT] 2.12.9 ScalingStruct
/// Referenced by: NoZoomViewInfoAtom, ZoomViewInfoAtom
/// A structure that specifies two-dimensional scaling.
public struct ScalingStruct {
    public let x: RatioStruct
    public let y: RatioStruct
    
    public init(dataStream: inout DataStream) throws {
        /// x (8 bytes): A RatioStruct structure (section 2.12.6) that specifies the scale to apply along the xaxis.
        self.x = try RatioStruct(dataStream: &dataStream)
        
        /// y (8 bytes): A RatioStruct structure that specifies the scale to apply along the y-axis.
        self.y = try RatioStruct(dataStream: &dataStream)
    }
}
