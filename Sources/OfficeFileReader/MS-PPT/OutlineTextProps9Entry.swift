//
//  OutlineTextProps9Entry.swift
//
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.61 OutlineTextProps9Entry
/// Referenced by: OutlineTextProps9Container
/// A structure that specifies additional text properties for a single placeholder shape position on a slide.
public struct OutlineTextProps9Entry {
    public let outlineTextHeaderAtom: OutlineTextPropsHeaderExAtom
    public let styleTextProp9Atom: StyleTextProp9Atom
    
    public init(dataStream: inout DataStream) throws {
        /// outlineTextHeaderAtom (16 bytes): An OutlineTextPropsHeaderExAtom record that specifies to which placeholder shape position and
        /// slide the styleTextProp9Atom field applies.
        self.outlineTextHeaderAtom = try OutlineTextPropsHeaderExAtom(dataStream: &dataStream)
        
        /// styleTextProp9Atom (variable): A StyleTextProp9Atom record that specifies additional text properties.
        self.styleTextProp9Atom = try StyleTextProp9Atom(dataStream: &dataStream)
    }
}
