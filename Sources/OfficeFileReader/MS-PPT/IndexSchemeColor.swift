//
//  IndexSchemeColor.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.60 IndexSchemeColor
/// Referenced by: TimeAnimateColor, TimeAnimateColorBy
/// A structure that specifies a color from a color scheme.
public struct IndexSchemeColor {
    public let model: UInt32
    public let index: UInt32
    public let reserved1: Int32
    public let reserved2: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// model (4 bytes): An unsigned integer that specifies this color is from a color scheme. It MUST be 0x0000002.
        self.model = try dataStream.read(endianess: .littleEndian)
        guard self.model == 0x0000002 else {
            throw OfficeFileError.corrupted
        }
        
        /// index (4 bytes): An unsigned integer that specifies the index to the color scheme. It MUST be less than or equal to 7.
        self.index = try dataStream.read(endianess: .littleEndian)
        guard self.index <= 7 else {
            throw OfficeFileError.corrupted
        }
        
        /// reserved1 (4 bytes): MUST be zero, and MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved2 (4 bytes): MUST be zero, and MUST be ignored.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
    }
}

