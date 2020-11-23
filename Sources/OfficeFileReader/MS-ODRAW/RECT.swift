//
//  RECT.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.56 RECT
/// Referenced by: OfficeArtMetafileHeader
/// The RECT record specifies a 2-D rectangle.
public struct RECT {
    public let left: Int32
    public let top: Int32
    public let right: Int32
    public let bottom: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// left (4 bytes): A signed integer that specifies the x-coordinate of the top-left point of this rectangle. The coordinate system that is used for this
        /// value is dependent on the scenario in which it is used.
        self.left = try dataStream.read(endianess: .littleEndian)
        
        /// top (4 bytes): A signed integer that specifies the y-coordinate of the top-left point of this rectangle. The coordinate system that is used for this
        /// value is dependent on the scenario in which it is used.
        self.top = try dataStream.read(endianess: .littleEndian)
        
        /// right (4 bytes): A signed integer that specifies the x-coordinate of the bottom-right point of this rectangle. The coordinate system that is used for
        /// this value is dependent on the scenario in which it is used.
        self.right = try dataStream.read(endianess: .littleEndian)
        
        /// bottom (4 bytes): A signed integer that specifies the y-coordinate of the bottom-right point of this rectangle. The coordinate system that is used
        /// for this value is dependent on the scenario in which it is used.
        self.bottom = try dataStream.read(endianess: .littleEndian)
    }
}
