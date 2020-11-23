//
//  UnknownBinaryTag.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.33 UnknownBinaryTag
/// Referenced by: DocProgBinaryTagSubContainerOrAtom, ShapeProgBinaryTagSubContainerOrAtom, SlideProgBinaryTagSubContainerOrAtom
/// A pair of atom records that specifies a programmable tag that has binary data as its value.
public struct UnknownBinaryTag {
    public let tagNameAtom: TagNameAtom
    public let tagData: BinaryTagDataBlob
    
    public init(dataStream: inout DataStream) throws {
        /// tagNameAtom (variable): A TagNameAtom record that specifies the name of the programmable tag.
        self.tagNameAtom = try TagNameAtom(dataStream: &dataStream)
        
        /// tagData (variable): A BinaryTagDataBlob record that specifies the value of the programmable tag.
        self.tagData = try BinaryTagDataBlob(dataStream: &dataStream)
    }
}
