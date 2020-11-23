//
//  ParaBuildEnum.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

/// [MS-PPT] 2.13.18 ParaBuildEnum
/// Referenced by: ParaBuildAtom
/// An enumeration that specifies the animation paragraph build type that is to be applied to the paragraphs of the shape.
public enum ParaBuildEnum: UInt32 {
    /// TLPB_AllAtOnce 0x00000000 All paragraphs in the shape animate at the same time.
    case allAtOnce = 0x00000000
    
    /// TLPB_BuildByNthLevel 0x00000001 Paragraph levels 1 to n – 1 in the shape animate separately. All paragraph levels n or greater animate at
    /// the same time.
    case buildByNthLevel = 0x00000001
    
    /// TLPB_CustomBuild 0x00000002 Applies a custom animation paragraph build type to the paragraphs of the shape.
    case customBuild = 0x00000002
    
    /// TLPB_AsAWhole 0x00000003 The shape and all paragraphs within the shape animate as one graphical object.
    case asAWhole = 0x00000003
}
