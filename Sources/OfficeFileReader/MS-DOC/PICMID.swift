//
//  PICMID.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.193 PICMID
/// The PICMID structure specifies the size and border information for a picture.
public struct PICMID {
    public let dxaGoal: Int16
    public let dyaGoal: Int16
    public let mx: UInt16
    public let my: UInt16
    public let dxaReserved1: UInt16
    public let dyaReserved1: UInt16
    public let dxaReserved2: UInt16
    public let dyaReserved2: UInt16
    public let fReserved: UInt8
    public let bpp: UInt8
    public let brcTop80: Brc80
    public let brcLeft80: Brc80
    public let brcBottom80: Brc80
    public let brcRight80: Brc80
    public let dxaReserved3: UInt16
    public let dyaReserved3: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// dxaGoal (2 bytes): A signed integer that specifies the initial width of the picture, in twips, before cropping or scaling occurs. This value
        /// MUST be greater than zero.
        self.dxaGoal = try dataStream.read(endianess: .littleEndian)
        if self.dxaGoal < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// dyaGoal (2 bytes): A signed integer that specifies the initial height of the picture, in twips, before cropping or scaling occurs. This value
        /// MUST be greater than zero.
        self.dyaGoal = try dataStream.read(endianess: .littleEndian)
        if self.dyaGoal < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// mx (2 bytes): An unsigned integer that specifies the ratio, measured in tenths of a percent, between the final display width and the initial
        /// picture width that is specified by dxaGoal. If the picture is not cropped, mx values that are greater than 1000 cause the picture to stretch
        /// in width, while values that are less than 1000 cause the picture to shrink in width.
        /// If the picture is horizontally cropped and the mx value is not adjusted accordingly, the picture is scaled. To counteract the new dimensions
        /// of a cropped image and avoid scaling, set mx to the value of ((dxaGoal – (left-crop + right-crop)) / dxaGoal.
        /// The final display width MUST be at least 15 twips and MUST NOT exceed 31680 twips (22 inches) after cropping and scaling.
        self.mx = try dataStream.read(endianess: .littleEndian)
        
        /// my (2 bytes): An unsigned integer that specifies the ratio, measured in tenths of a percent, between the final display height and the initial
        /// picture height that was specified by dyaGoal. If the picture is not cropped, my values that are greater than 1000 cause the picture to
        /// stretch in height, while values of less than 1000 cause the picture to shrink.
        /// If the picture is vertically cropped and the my value is not adjusted accordingly, the picture is scaled. To counteract the new dimensions
        /// of a cropped image and avoid scaling, set the my value to the value of ((dyaGoal – (top-crop + bottom-crop)) / dyaGoal.
        /// The final display height MUST be at least 15 twips and MUST NOT exceed 31680 twips (22 inches) after cropping and scaling.
        self.my = try dataStream.read(endianess: .littleEndian)
        
        /// dxaReserved1 (2 bytes): This value MUST be zero and MUST be ignored.
        self.dxaReserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// dyaReserved1 (2 bytes): This value MUST be zero and MUST be ignored.
        self.dyaReserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// dxaReserved2 (2 bytes): This value MUST be zero and MUST be ignored.
        self.dxaReserved2 = try dataStream.read(endianess: .littleEndian)
        
        /// dyaReserved2 (2 bytes): This value MUST be zero and MUST be ignored.
        self.dyaReserved2 = try dataStream.read(endianess: .littleEndian)
        
        /// fReserved (8 bits): This value MUST be zero and MUST be ignored.
        self.fReserved = try dataStream.read()
        
        /// bpp (8 bits): This field is unused and MUST be ignored.
        self.bpp = try dataStream.read()
        
        /// brcTop80 (4 bytes): A Brc80 structure that specifies what border to render above the picture.
        self.brcTop80 = try Brc80(dataStream: &dataStream)
        
        /// brcLeft80 (4 bytes): A Brc80 structure that specifies what border to render to the left of the picture.
        self.brcLeft80 = try Brc80(dataStream: &dataStream)
        
        /// brcBottom80 (4 bytes): A Brc80 structure that specifies what border to render below the picture.
        self.brcBottom80 = try Brc80(dataStream: &dataStream)

        /// brcRight80 (4 bytes): A Brc80 structure that specifies what border to render to the right of the picture.
        self.brcRight80 = try Brc80(dataStream: &dataStream)
        
        /// dxaReserved3 (2 bytes): This value MUST be zero and MUST be ignored.
        self.dxaReserved3 = try dataStream.read(endianess: .littleEndian)
        
        /// dyaReserved3 (2 bytes): This value MUST be zero and MUST be ignored.
        self.dyaReserved3 = try dataStream.read(endianess: .littleEndian)
    }
}
