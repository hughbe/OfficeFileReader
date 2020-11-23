//
//  NormalViewSetInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.3 NormalViewSetInfoAtom
/// Referenced by: NormalViewSetInfoContainer
/// An atom record that specifies the appearance of different regions in a user interface view that consists of three content panes: a side content pane, a
/// slide pane, and a notes text pane.
/// The side content pane can contain either thumbnail images of presentation slides in the presentation or a text outline of the presentation. It occupies
/// the full height of the view and is separated from the slide pane and notes text pane by a vertical bar. It occupies the left edge of the view if the
/// fRightToLeft field of the DocumentAtom record (section 2.4.2) is FALSE and the right edge of the view if the fRightToLeft field of the DocumentAtom
/// record is TRUE.
/// The remainder of the view not occupied by the side content region is divided vertically by a horizontal bar. The slide pane displays a single presentation
/// slide and is located above the horizontal bar. The notes text pane displays the text of the notes slide associated with the presentation slide and is
/// located beneath the horizontal bar.
public struct NormalViewSetInfoAtom {
    public let rh: RecordHeader
    public let leftPortion: RatioStruct
    public let topPortion: RatioStruct
    public let vertBarState: NormalViewSetBarStates
    public let horizBarState: NormalViewSetBarStates
    public let fPreferSingleSet: bool1
    public let fHideThumbnails: Bool
    public let fBarSnapped: Bool
    public let reserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_NormalViewSetInfo9Atom.
        /// rh.recLen MUST be 0x00000014
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .normalViewSetInfo9Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000014 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// leftPortion (8 bytes): A RatioStruct structure (section 2.12.6) that specifies the width of the side content pane as a percentage of the
        /// view’s width. The value of leftPortion.numer / leftPortion.denom MUST be greater than or equal to 0 and less than or equal to 1.
        let leftPortion = try RatioStruct(dataStream: &dataStream)
        /*
        guard leftPortion.ratio >= 0 && leftPortion.ratio <= 1 else {
            throw OfficeFileError.corrupted
        }
        */
        
        self.leftPortion = leftPortion
        
        /// topPortion (8 bytes): A RatioStruct structure that specifies the height of the slide pane as a percentage of the view’s height. The value of
        /// topPortion.numer / topPortion.denom MUST be greater than or equal to 0 and less than or equal to 1.
        let topPortion = try RatioStruct(dataStream: &dataStream)
        /*
        guard topPortion.ratio >= 0 && topPortion.ratio <= 1 else {
            throw DocFileError.corrupted
        }
        */
        
        self.topPortion = topPortion
        
        /// vertBarState (1 byte): A NormalViewSetBarStates enumeration that specifies the state of the vertical bar that separates the side content
        /// pane from the slide pane and notes text pane. If the value is BS_Minimized or BS_Maximized, the value of leftPortion MUST be ignored.
        guard let vertBarState = NormalViewSetBarStates(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.vertBarState = vertBarState
        
        /// horizBarState (1 byte): A NormalViewSetBarStates enumeration that specifies the state of the horizontal bar that separates the slide pane
        /// from the notes text pane. If the value is BS_Minimized or BS_Maximized, the value of topPortion MUST be ignored.
        guard let horizBarState = NormalViewSetBarStates(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.horizBarState = horizBarState
        
        /// fPreferSingleSet (1 byte): A bool1 (section 2.2.2) that specifies whether the view consists of only the slide pane or all three panes. It MUST
        /// be a value from the following table:
        /// Value Meaning
        /// 0x01 The slide pane occupies the entire view.
        /// 0x00 All three panes exist in the view.
        self.fPreferSingleSet = try bool1(dataStream: &dataStream)
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fHideThumbnails (1 bit): A bit that specifies the content of the side content pane. It MUST be a value from the following table.
        /// Value Meaning
        /// 0x1 The side content pane contains a text outline of the presentation.
        /// 0x0 The side content pane contains thumbnail images of the presentation slides.
        self.fHideThumbnails = flags.readBit()
        
        /// B - fBarSnapped (1 bit): A bit that specifies whether the vertical bar is snapped to specific positions when resized.
        self.fBarSnapped = flags.readBit()
        
        /// reserved (6 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
