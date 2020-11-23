//
//  SlideProgBinaryTagSubContainerOrAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.22 SlideProgBinaryTagSubContainerOrAtom
/// Referenced by: SlideProgBinaryTagContainer
/// A variable type record whose type and meaning are dictated by the value of tagNameAtom.tagName for UnknownBinaryTag or by the value of
/// tagName for PP9SlideBinaryTagExtension, PP10SlideBinaryTagExtension, PP12SlideBinaryTagExtension, as specified in the following table.
public enum SlideProgBinaryTagSubContainerOrAtom {
    /// "___PPT9" A PP9SlideBinaryTagExtension record pair that specifies additional slide data. It MAY<81> be ignored and MUST be preserved.
    case ppt9(data: PP9SlideBinaryTagExtension)
    
    /// "___PPT10" A PP10SlideBinaryTagExtension record pair that specifies additional slide data. It MAY<82> be ignored and MUST be preserved.
    case ppt10(data: PP10SlideBinaryTagExtension)
    
    /// "___PPT12" A PP12SlideBinaryTagExtension record pair that specifies additional slide data. It MAY<83> be ignored and MUST be preserved.
    case ppt12(data: PP12SlideBinaryTagExtension)
    
    /// Any other value An UnknownBinaryTag record pair that specifies additional slide data. It MUST be ignored and MUST be preserved.
    case unknown(data: UnknownBinaryTag)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let tagName = try TagNameAtom(dataStream: &dataStream)
        dataStream.position = position
        
        switch tagName.tagName {
        case "___PPT9":
            self = .ppt9(data: try PP9SlideBinaryTagExtension(dataStream: &dataStream))
        case "___PPT10":
            self = .ppt10(data: try PP10SlideBinaryTagExtension(dataStream: &dataStream))
        case "___PPT12":
            self = .ppt12(data: try PP12SlideBinaryTagExtension(dataStream: &dataStream))
        default:
            self = .unknown(data: try UnknownBinaryTag(dataStream: &dataStream))
        }
    }
}
