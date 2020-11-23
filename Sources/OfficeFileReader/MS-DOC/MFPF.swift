//
//  MFPF.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.156 MFPF
/// The MFPF structure specifies the type of picture data that is stored.
public struct MFPF {
    public let mm: PictureDataFormat
    public let xExt: UInt16
    public let yExt: UInt16
    public let swHMF: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// mm (2 bytes): A signed integer that specifies the format of the picture data. This MUST be one of the following values.
        let mmRaw: Int16 = try dataStream.read(endianess: .littleEndian)
        guard let mm = PictureDataFormat(rawValue: mmRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.mm = mm
        
        /// xExt (2 bytes): This field is unused and MUST be ignored.
        self.xExt = try dataStream.read(endianess: .littleEndian)
        
        /// yExt (2 bytes): This field is unused and MUST be ignored.
        self.yExt = try dataStream.read(endianess: .littleEndian)
        
        /// swHMF (2 bytes): This field MUST be zero and MUST be ignored.
        self.swHMF = try dataStream.read(endianess: .littleEndian)
    }
    
    /// mm (2 bytes): A signed integer that specifies the format of the picture data. This MUST be one of the following values.
    public enum PictureDataFormat: Int16 {
        /// MM_SHAPE 0x0064 Shape object
        case shape = 0x0064
        
        /// MM_SHAPEFILE 0x0066 Shape file
        case shapeFile = 0x0066
    }
}
