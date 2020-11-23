//
//  DocProgBinaryTagSubContainerOrAtom.swift
//
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.23.4 DocProgBinaryTagSubContainerOrAtom
/// Referenced by: DocProgBinaryTagContainer
/// A variable type record whose type and meaning are dictated by the value of tagNameAtom.tagName for UnknownBinaryTag or by the value of
/// tagName for PP9DocBinaryTagExtension, PP10DocBinaryTagExtension, PP11DocBinaryTagExtension, PP12DocBinaryTagExtension, as specified
/// in the following table.
public enum DocProgBinaryTagSubContainerOrAtom {
    /// "___PPT9" A PP9DocBinaryTagExtension record pair that specifies additional document data. It MAY<16> be ignored and MUST be preserved.
    case ppt9(data: PP9DocBinaryTagExtension)
    
    /// "___PPT10" A PP10DocBinaryTagExtension record pair that specifies additional document data. It MAY<17> be ignored and MUST be preserved.
    case ppt10(data: PP10DocBinaryTagExtension)
    
    /// "___PPT11" A PP11DocBinaryTagExtension record pair that specifies additional document data. It MAY<18> be ignored and MUST be preserved.
    case ppt11(data: PP11DocBinaryTagExtension)
    
    /// "___PPT12" A PP12DocBinaryTagExtension record pair that specifies additional document data. It MAY<19> be ignored and MUST be preserved.
    case ppt12(data: PP12DocBinaryTagExtension)
    
    /// Any other value An UnknownBinaryTag record pair that specifies additional document data. It MUST be ignored and MUST be preserved.
    case unknown(data: UnknownBinaryTag)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let tagName = try TagNameAtom(dataStream: &dataStream)
        dataStream.position = position
        
        switch tagName.tagName {
        case "___PPT9":
            self = .ppt9(data: try PP9DocBinaryTagExtension(dataStream: &dataStream))
        case "___PPT10":
            self = .ppt10(data: try PP10DocBinaryTagExtension(dataStream: &dataStream))
        case "___PPT11":
            self = .ppt11(data: try PP11DocBinaryTagExtension(dataStream: &dataStream))
        case "___PPT12":
            self = .ppt12(data: try PP12DocBinaryTagExtension(dataStream: &dataStream))
        default:
            self = .unknown(data: try UnknownBinaryTag(dataStream: &dataStream))
        }
    }
}
