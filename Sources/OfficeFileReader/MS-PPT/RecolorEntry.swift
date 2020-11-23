//
//  RecolorEntry.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.10 RecolorEntry
/// Referenced by: RecolorInfoAtom
/// A structure that specifies a color mapping for metafile records. A color mapping has a source color description and a destination color description.
/// Applying a color mapping to a metafile means to be the same as the source color description with the corresponding fields of the listed metafile
/// records that follow and replace them with metafile records which represent the mapped destination color.
/// The following metafile ([MS-WMF]) records are the targets for possible color replacement.
/// Metafile record Specified in
/// META_SETTEXTCOLOR [MS-WMF] section 2.3.5.26
/// META_SETBKCOLOR [MS-WMF] section 2.3.5.14
/// META_CREATEPENINDIRECT [MS-WMF] section 2.3.4.5
/// META_CREATEBRUSHINDIRECT [MS-WMF] section 2.3.4.1
/// META_CREATEPATTERNBRUSH [MS-WMF] section 2.3.4.4
/// META_DIBCREATEPATTERNBRUSH [MS-WMF] section 2.3.4.8
/// META_DIBSTRETCHBLT [MS-WMF] section 2.3.1.3
/// META_STRETCHDIB [MS-WMF] section 2.3.1.6
/// Let the corresponding color scheme be as specified by the MainMasterContainer record (section 2.5.3), HandoutContainer record (section 2.5.8),
/// SlideContainer record (section 2.5.1), or NotesContainer record (section 2.5.6) that contains this RecolorEntry structure.
public struct RecolorEntry {
    public let fDoRecolor: Bool
    public let reserved1: UInt16
    public let toColor: WideColorStruct
    public let toIndex: UInt8
    public let unused: UInt8
    public let colorOrBrush: RecolorEntryVariant
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fDoRecolor (1 bit): A bit that specifies whether the color mapping is performed.
        self.fDoRecolor = flags.readBit()
        
        /// reserved1 (15 bits): MUST be zero and MUST be ignored.
        self.reserved1 = flags.readRemainingBits()
        
        /// toColor (6 bytes): A WideColorStruct structure that specifies the destination color of the mapping when toIndex is greater than or equal to 8.
        /// It MUST be ignored if toIndex is less than 8.
        self.toColor = try WideColorStruct(dataStream: &dataStream)
        
        /// toIndex (1 byte): An unsigned integer that specifies the destination color of the mapping. If the value is less than 8, it is a 0-based index into the
        /// corresponding color scheme. If the value is greater than or equal to 8, toColor is used for the destination color.
        self.toIndex = try dataStream.read()
        
        /// unused (1 byte): Undefined and MUST be ignored.
        self.unused = try dataStream.read()
        
        /// colorOrBrush (34 bytes): A RecolorEntryVariant structure that specifies the source color of the color mapping.
        self.colorOrBrush = try RecolorEntryVariant(dataStream: &dataStream)
    }
}
