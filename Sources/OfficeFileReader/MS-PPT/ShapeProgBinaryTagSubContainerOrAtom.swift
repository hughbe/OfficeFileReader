//
//  ShapeProgBinaryTagSubContainerOrAtom.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.17 ShapeProgBinaryTagSubContainerOrAtom
/// Referenced by: ShapeProgBinaryTagContainer
/// A variable type record whose type and meaning are dictated by the value of tagNameAtom.tagName for UnknownBinaryTag or by the value of tagName for
/// PP9ShapeBinaryTagExtension, PP10ShapeBinaryTagExtension, PP11ShapeBinaryTagExtension, as specified in the following table.
public enum ShapeProgBinaryTagSubContainerOrAtom {
    /// "___PPT9" A PP9ShapeBinaryTagExtension record pair that specifies additional shape data. It MAY<100> be ignored and MUST be preserved.
    case ppt9(data: PP9ShapeBinaryTagExtension)
    
    /// "___PPT10" A PP10ShapeBinaryTagExtension record pair that specifies additional shape data. It MAY<101> be ignored and MUST be preserved.
    case ppt10(data: PP10ShapeBinaryTagExtension)
    
    /// "___PPT11" A PP11ShapeBinaryTagExtension record pair that specifies additional shape data. It MAY<102> be ignored and MUST be preserved.
    case ppt11(data: PP11ShapeBinaryTagExtension)
    
    /// Any other value An UnknownBinaryTag record pair that specifies additional shape data. It MUST be ignored and MUST be preserved.
    case unknown(data: UnknownBinaryTag)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let tagName = try TagNameAtom(dataStream: &dataStream)
        dataStream.position = position
        
        switch tagName.tagName {
        case "___PPT9":
            self = .ppt9(data: try PP9ShapeBinaryTagExtension(dataStream: &dataStream))
        case "___PPT10":
            self = .ppt10(data: try PP10ShapeBinaryTagExtension(dataStream: &dataStream))
        case "___PPT11":
            self = .ppt11(data: try PP11ShapeBinaryTagExtension(dataStream: &dataStream))
        default:
            self = .unknown(data: try UnknownBinaryTag(dataStream: &dataStream))
        }
    }
}
