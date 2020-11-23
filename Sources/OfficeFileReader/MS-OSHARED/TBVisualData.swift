//
//  TBVisualData.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.9 TBVisualData
/// Contains visual information about a toolbar. The values of some of the fields in this structure are restricted by the toolbar type and restrictions of
/// this toolbar (the value of the ltbtr field of the TB structure (section 2.3.1.6) that contains the structure that contains this structure). The restrictions
/// are shown in the following table.
/// Value of toolbar types and restrictions flags (value of the ltbtr field of the TB structure that contains the structure that contains this structure) TBVisualData restrictions
/// If the NotTopLevel bit of the ltbtr field of the TB structure (section 2.3.1.6) that contains toolbar information for this toolbar equals 1. tbv MUST equal
/// 0x00 or tbds MUST equal 0x04.
/// If the TBTPopupMenu bit of the ltbtr field of the TB structure (section 2.3.1.6) that contains toolbar information for this toolbar equals 1. tbv MUST
/// equal 0x00 or tbds MUST equal 0x04.
/// If the NoVerticalDock bit of the ltbtr field of the TB structure (section 2.3.1.6) that contains toolbar information for this toolbar equals 1. tbds MUST
/// NOT equal 0x00 or 0x02.
/// If the NoHorizontalDock bit of the ltbtr field of the TB structure (section 2.3.1.6) that contains toolbar information for this toolbar equals 1. tbds MUST
/// NOT equal 0x01 or 0x03.
public struct TBVisualData {
    public let tbds: ToolbarDockedState
    public let tbv: ToolbarVisibility
    public let tbdsDock: Int8
    public let iRow: Int8
    public let rcDock: SRECT
    public let rcFloat: SRECT
    
    public init(dataStream: inout DataStream) throws {
        /// tbds (1 byte): Signed integer that specifies the current toolbar docked state. The value MUST be in the following table.
        let tbdsRaw: Int8 = try dataStream.read()
        guard let tbds = ToolbarDockedState(rawValue: tbdsRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.tbds = tbds
        
        /// tbv (1 byte): Signed integer that specifies the toolbar visibility. The value MUST be in the following table.
        let tbvRaw: Int8 = try dataStream.read()
        guard let tbv = ToolbarVisibility(rawValue: tbvRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.tbv = tbv
        
        /// tbdsDock (1 byte): Signed integer that SHOULD specify the toolbar docked state. The value MUST be in the following table.
        /// If the value of the tbds field is less than or equal to 0x03, this value MUST be equal to the value of the tbds field. When tbds is greater
        /// than 0x03, this field specifies the most recent toolbar dock state.
        self.tbdsDock = try dataStream.read()
        
        /// iRow (1 byte): Signed integer that specifies, when the toolbar is docked, the index of the docked location of the toolbar in the docking
        /// area in relation to other toolbars in the docking area. MUST be in the range 0-127 or in the following table.
        /// Value Meaning
        /// 0xFE (-2) Row append. Toolbar is placed on the last row of the docking area.
        /// 0xFD (-3) Row prepend. Toolbar is placed on the first row of the docking area.
        self.iRow = try dataStream.read()
        
        /// rcDock (8 bytes): Structure of type SRECT (section 2.3.1.5) that specifies the preferred docked location of the toolbar. Refer to the
        /// following table for the meaning of the values of each field of this structure.
        /// Field of rcDock structure Meaning
        /// rcDock.left Signed integer that specifies the distance in pixels from the left border of the docking area to the left border of the toolbar.
        /// rcDock.top Signed integer that specifies the distance in pixels from the top border of the docking area to the top border of the toolbar.
        /// rcDock.right Signed integer that specifies the distance in pixels from the left border of the docking area to the right border of the toolbar.
        /// rcDock.bottom Signed integer that specifies the distance in pixels from the top border of the docking area to the bottom border of the toolbar.
        self.rcDock = try SRECT(dataStream: &dataStream)
        
        /// rcFloat (8 bytes): Structure of type SRECT (section 2.3.1.5) that specifies the preferred toolbar location when the toolbar is not docked.
        /// Refer to the following table for the meaning of the values of each field of this structure.
        /// Field of rcFloat structure Meaning
        /// rcFloat.left Signed integer that specifies the distance in pixels from the left border of the screen to the left border of the toolbar.
        /// rcFloat.top Signed integer that specifies the distance in pixels from the top border of the screen to the top border of the toolbar.
        /// rcFloat.right Signed integer that specifies the distance in pixels from the left border of the screen to the right border of the toolbar.
        /// rcFloat.bottom Signed integer that specifies the distance in pixels from the top border of the screen to the bottom border of the toolbar.
        self.rcFloat = try SRECT(dataStream: &dataStream)
    }
    
    /// tbds (1 byte): Signed integer that specifies the current toolbar docked state. The value MUST be in the following table.
    /// tbdsDock (1 byte): Signed integer that SHOULD specify the toolbar docked state. The value MUST be in the following table.
    public enum ToolbarDockedState: Int8 {
        /// 0x00 Toolbar is docked on application frame at the left.
        case left = 0x00
        
        /// 0x01 Toolbar is docked on application frame at the top.
        case top = 0x01
        
        /// 0x02 Toolbar is docked on application frame at the right.
        case right = 0x02
        
        /// 0x03 Toolbar is docked on application frame at the bottom.
        case bottom = 0x03
        
        /// 0x04 Toolbar is not docked.
        case notDocked = 0x04
    }
    
    /// tbv (1 byte): Signed integer that specifies the toolbar visibility. The value MUST be in the following table.
    public enum ToolbarVisibility: Int8 {
        /// 0x00 Toolbar is not visible.
        case notVisible = 0x00
        
        /// 0x01 Toolbar is visible.
        case visible1 = 0x01
        
        /// 0x02 Toolbar is visible.
        case visible2 = 0x02
    }
}
