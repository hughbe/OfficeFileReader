//
//  OutlineTextProps10Entry.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.64 OutlineTextProps10Entry
/// Referenced by: OutlineTextProps10Container
/// A structure that specifies additional text properties for a single placeholder shape position on a slide.
public struct OutlineTextProps10Entry {
    public let outlineTextHeaderAtom: OutlineTextPropsHeaderExAtom
    public let styleTextProp10Atom: StyleTextProp10Atom
    
    public init(dataStream: inout DataStream) throws {
        /// outlineTextHeaderAtom (16 bytes): An OutlineTextPropsHeaderExAtom record that specifies to which placeholder shape position and slide
        /// the styleTextProp10Atom field applies.
        self.outlineTextHeaderAtom = try OutlineTextPropsHeaderExAtom(dataStream: &dataStream)
        
        /// styleTextProp10Atom (variable): A StyleTextProp10Atom record that specifies additional text properties.
        self.styleTextProp10Atom = try StyleTextProp10Atom(dataStream: &dataStream)
    }
}
