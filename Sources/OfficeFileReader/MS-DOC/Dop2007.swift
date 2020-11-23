//
//  Dop2007.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.8 Dop2007
/// The Dop2007 structure contains document and compatibility settings. These settings influence the appearance and behavior of the current document and
/// store document-level state.
public struct Dop2007 {
    public let dop2003: Dop2003
    public let reserved1: UInt32
    public let fRMTrackFormatting: Bool
    public let fRMTrackMoves: Bool
    public let reserved2: Bool
    public let empty1: Bool
    public let empty2: Bool
    public let ssm: StylesSortingMethod
    public let fReadingModeInkLockDownActualPage: Bool
    public let fAutoCompressPictures: Bool
    public let reserved3: UInt32
    public let empty3: UInt32
    public let empty4: UInt32
    public let empty5: UInt32
    public let empty6: UInt32
    public let dopMth: DopMth
    
    public init(dataStream: inout DataStream) throws {
        /// dop2003 (616 bytes): A Dop2003 that specifies document and compatibility settings.
        self.dop2003 = try Dop2003(dataStream: &dataStream)
        
        /// reserved1 (4 bytes): This value is undefined, and MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fRMTrackFormatting (1 bit): Specifies whether to track format changes when tracking for revisions (DopBase.fRevMarking).
        /// By default, this value is 1.
        self.fRMTrackFormatting = flags.readBit()
        
        /// B - fRMTrackMoves (1 bit): Specifies whether to track moved text when tracking for revisions (DopBase.fRevMarking) instead of tracking for
        /// the deletions and insertions that are made. By default, this value is 1.
        self.fRMTrackMoves = flags.readBit()
        
        /// C - reserved2 (1 bit): This value MUST be 0, and MUST be ignored.
        self.reserved2 = flags.readBit()
        
        /// D - empty1 (1 bit): This value MUST be 0, and MUST be ignored.
        self.empty1 = flags.readBit()
        
        /// E - empty2 (1 bit): This value MUST be 0, and MUST be ignored.
        self.empty2 = flags.readBit()
        
        /// ssm (4 bits): An unsigned integer that specifies the sorting method to use when displaying document styles. This value MUST be one of the
        /// following.
        let ssmRaw = UInt8(flags.readBits(count: 4))
        guard let ssm = StylesSortingMethod(rawValue: ssmRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.ssm = ssm
        
        /// F - fReadingModeInkLockDownActualPage (1 bit): Specifies whether to render the document with actual pages or virtual pages as specified in
        /// [ECMA-376] Part 4, Section 2.15.1.66 readModeInkLockDown. By default, this value is 0.
        self.fReadingModeInkLockDownActualPage = flags.readBit()
        
        /// G - fAutoCompressPictures (1 bit): Specifies whether pictures in the document are automatically compressed when the document is saved as
        /// specified in [ECMA-376] Part 4, Section 2.15.1.32 doNotAutoCompressPictures, where the meaning is the opposite of fAutoCompressPictures.
        /// By default, this value is 1.
        self.fAutoCompressPictures = flags.readBit()
        
        /// reserved3 (21 bits): This value MUST be 0, and MUST be ignored.
        self.reserved3 = flags.readRemainingBits()
        
        /// empty3 (4 bytes): This value MUST be 0, and MUST be ignored.
        self.empty3 = try dataStream.read(endianess: .littleEndian)
        
        /// empty4 (4 bytes): This value MUST be 0, and MUST be ignored.
        self.empty4 = try dataStream.read(endianess: .littleEndian)
        
        /// empty5 (4 bytes): This value MUST be 0, and MUST be ignored.
        self.empty5 = try dataStream.read(endianess: .littleEndian)
        
        /// empty6 (4 bytes): This value MUST be 0, and MUST be ignored.
        self.empty6 = try dataStream.read(endianess: .littleEndian)
        
        /// dopMth (34 bytes): A DopMth that specifies various math properties.
        self.dopMth = try DopMth(dataStream: &dataStream)
    }
    
    /// ssm (4 bits): An unsigned integer that specifies the sorting method to use when displaying document styles. This value MUST be one of the
    /// following.
    public enum StylesSortingMethod: UInt8 {
        /// 0 Styles are sorted by name.
        case sortedByName = 0
        
        /// 1 (default) Styles are sorted by the default sorting method of the application.
        case stylesSortedByDefaultSortingMethodOfApplication = 1
        
        /// 2 Styles are sorted based on the font that they apply.
        case sortedByFont = 2
        
        /// 3 Styles are sorted by the style on which they are based.
        case sortedByStyle = 3
        
        /// 4 Styles are sorted by their style types (character, linked, paragraph, and so on).
        case sortedByStyleTypes = 4
    }
}
