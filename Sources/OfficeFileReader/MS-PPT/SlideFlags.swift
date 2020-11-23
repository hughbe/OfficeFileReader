//
//  SlideFlags.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.11 SlideFlags
/// Referenced by: NotesAtom, SlideAtom
/// A structure that specifies information about a presentation slide and its relationship with its main master slide or title master slide; or about a notes
/// slide and its relationship with its notes master slide.
/// Let the corresponding slide be specified by the SlideContainer record (section 2.5.1), MainMasterContainer record (section 2.5.3), or NotesContainer
/// record (section 2.5.6) that contains this SlideFlags structure.
public struct SlideFlags {
    public let fMasterObjects: Bool
    public let fMasterScheme: Bool
    public let fMasterBackground: Bool
    public let reserved: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fMasterObjects (1 bit): A bit that specifies whether the corresponding slide inherits objects from its main master slide, title master slide,
        /// or notes master slide.
        self.fMasterObjects = flags.readBit()
        
        /// B - fMasterScheme (1 bit): A bit that specifies whether the corresponding slide inherits the color scheme from its main master slide, title
        /// master slide, or notes master slide.
        self.fMasterScheme = flags.readBit()
        
        /// C - fMasterBackground (1 bit): A bit that specifies whether the corresponding slide inherits the background from its main master slide,
        /// title master slide, or notes master slide.
        self.fMasterBackground = flags.readBit()
        
        /// reserved (13 bits): MUST be zero, and MUST be ignored.
        self.reserved = flags.readRemainingBits()
    }
}
