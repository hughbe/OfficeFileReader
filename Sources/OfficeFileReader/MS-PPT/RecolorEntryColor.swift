//
//  RecolorEntryColor.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.12 RecolorEntryColor
/// Referenced by: RecolorEntryVariant
/// A structure that specifies a source color for a RecolorEntry structure.
public struct RecolorEntryColor {
    public let type: UInt16
    public let fromColor: WideColorStruct
    public let unused: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// type (2 bytes): An unsigned integer that specifies the variant of the containing RecolorEntryVariant structure. It MUST be 0x0000.
        self.type = try dataStream.read(endianess: .littleEndian)
        if self.type != 0x0000 {
            throw OfficeFileError.corrupted
        }
        
        /// fromColor (6 bytes): A WideColorStruct structure that specifies a source color.
        self.fromColor = try WideColorStruct(dataStream: &dataStream)
        
        /// unused (26 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.readBytes(count: 26)
    }
}
