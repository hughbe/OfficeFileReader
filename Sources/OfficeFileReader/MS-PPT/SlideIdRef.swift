//
//  SlideIdRef.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.2.25 SlideIdRef
/// Referenced by: ExControlAtom, ExOleLinkAtom, LinkedSlide10Atom, NamedShowSlidesAtom, NotesAtom, OutlineTextPropsHeaderExAtom,
/// SlideListEntry10Atom, UserEditAtom
/// A 4-byte unsigned integer that specifies a reference to a presentation slide. It MUST be 0x00000000 or equal to the value of the slideId field of
/// a SlidePersistAtom record (section 2.4.14.5). The value 0x00000000 specifies a null reference.
public typealias SlideIdRef = UInt32
