//
//  POINT.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.55 POINT
/// Referenced by: OfficeArtMetafileHeader
/// The POINT record specifies a two-dimensional (2-D) point.
public struct POINT {
    public let x: Int32
    public let y: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// x (4 bytes): A signed integer that specifies the x-coordinate of this point. The coordinate system that is used for this value is dependent on the
        /// scenario in which it is used.
        self.x = try dataStream.read(endianess: .littleEndian)
        
        /// y (4 bytes): A signed integer that specifies the y-coordinate of this point. The coordinate system that is used for this value is dependent on the
        /// scenario in which it is used.
        self.y = try dataStream.read(endianess: .littleEndian)
    }
}
