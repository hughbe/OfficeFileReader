//
//  OutlineTextProps11Entry.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.66 OutlineTextProps11Entry
/// Referenced by: OutlineTextProps11Container
/// A structure that specifies additional text properties for a single placeholder shape position on a slide.
public struct OutlineTextProps11Entry {
    public let outlineTextHeaderAtom: OutlineTextPropsHeaderExAtom
    public let styleTextProp11Atom: StyleTextProp11Atom
    
    public init(dataStream: inout DataStream) throws {
        /// outlineTextHeaderAtom (16 bytes): An OutlineTextPropsHeaderExAtom record that specifies to which placeholder shape position and slide
        /// the styleTextProp11Atom field applies
        self.outlineTextHeaderAtom = try OutlineTextPropsHeaderExAtom(dataStream: &dataStream)
        
        /// styleTextProp11Atom (variable): A StyleTextProp11Atom record that specifies additional text properties.
        self.styleTextProp11Atom = try StyleTextProp11Atom(dataStream: &dataStream)
    }
}
