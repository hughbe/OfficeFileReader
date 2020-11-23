//
//  bool1.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.2 bool1
/// Referenced by: BuildAtom, ChartBuildAtom, DiffRecordHeaders, DocumentAtom, ExOleEmbedAtom, NormalViewSetInfoAtom, NoZoomViewInfoAtom,
/// ParaBuildAtom, PhotoAlbumInfo10Atom,
/// PrintOptionsAtom, SlideViewInfoAtom, TimeScaleBehaviorAtom, TimeVariantBool, ZoomViewInfoAtom
/// A 1-byte unsigned integer that specifies a Boolean value. It SHOULD be 0x00 or 0x01. A value of 0x00 specifies FALSE and all other values specify
/// TRUE.
public struct bool1 {
    public let value: Bool
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt8 = try dataStream.read()
        self.value = rawValue != 0x00
    }
}
