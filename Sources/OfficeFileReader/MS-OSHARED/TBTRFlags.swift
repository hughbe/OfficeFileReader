//
//  TBTRFlags.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.7 TBTRFlags
/// Referenced by: TB
/// Toolbar type and restrictions flags. The bit description begins from the least significant bit. This structure MUST specify the toolbar type which
/// means that the 8 most significant bits MUST have one of the values in the following table.
/// 8 most significant bits of the TBTRFlags structure (section 2.3.1.7) Meaning
/// 00000000 Specifies that the toolbar is a basic toolbar.
/// 00000010 Specifies that the toolbar is a menu toolbar.
/// The rest of the bits in this structure specify toolbar restrictions. A toolbar restriction limits the end user’s ability to change and manipulate the toolbar.
public struct TBTRFlags {
    public let noAddDelCtl: Bool
    public let noResize: Bool
    public let noMove: Bool
    public let noChangeVisible: Bool
    public let noChangeDock: Bool
    public let noVerticalDock: Bool
    public let noHorizontalDock: Bool
    public let noBorder: Bool
    public let noTbContextMenu: Bool
    public let reserved1: Bool
    public let reserved2: Bool
    public let notTopLevel: Bool
    public let reserved3: Bool
    public let reserved4: Bool
    public let reserved5: Bool
    public let reserved6: Bool
    public let reserved7: Bool
    public let reserved8: Bool
    public let reserved9: Bool
    public let reserved10: Bool
    public let reserved11: Bool
    public let reserved12: Bool
    public let reserved13: Bool
    public let reserved14: Bool
    public let reserved15: Bool
    public let tbtPopupMenu: Bool
    public let reserved16: Bool
    public let reserved17: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - NoAddDelCtl (1 bit): A bit that specifies whether toolbar controls can be added to or removed from this toolbar. A value of 1 specifies
        /// that no toolbar controls can be added or removed from this toolbar.
        self.noAddDelCtl = flags.readBit()
        
        /// B - NoResize (1 bit): A bit that specifies whether this toolbar can be resized when not docked. A value of 1 specifies that this toolbar
        /// cannot be resized when not docked.
        self.noResize = flags.readBit()
        
        /// C - NoMove (1 bit): A bit that specifies whether this toolbar can or cannot be moved. A value of 1 specifies that this toolbar cannot be
        /// moved.
        self.noMove = flags.readBit()
        
        /// D - NoChangeVisible (1 bit): A bit that specifies whether the visibility of this toolbar can be changed. A value of 1 specifies that the visibility
        /// of this toolbar cannot be changed.
        self.noChangeVisible = flags.readBit()
        
        /// E - NoChangeDock (1 bit): A bit that specifies whether the docked location of this toolbar can or cannot be changed. A value of 1 specifies
        /// that the end user cannot change the docked location of this toolbar.
        self.noChangeDock = flags.readBit()
        
        /// F - NoVerticalDock (1 bit): A bit that specifies whether this toolbar can be vertically docked. A value of 1 specifies that the toolbar cannot
        /// be vertically docked.
        self.noVerticalDock = flags.readBit()
        
        /// G - NoHorizontalDock (1 bit): A bit that specifies whether this toolbar can be horizontally docked. A value of 1 specifies that the toolbar
        /// cannot be horizontally docked.
        self.noHorizontalDock = flags.readBit()
        
        /// H - NoBorder (1 bit): A bit that specifies whether the toolbar has a title bar and a border when not docked. A value of 1 specifies that
        /// the toolbar does not have a title bar and a border when not docked. MUST be 1 when the TBTPopupMenu field equals 1; MUST be 0
        /// when the TBTPopupMenu equals 0.
        self.noBorder = flags.readBit()
        
        /// I - NoTbContextMenu (1 bit): A bit that specifies whether the toolbar shows a context menu when right-clicked. A value of 1 specifies
        /// that the toolbar will not show a context menu when rightclicked. MUST be 1 when TBTPopupMenu equals 1; MUST be 0 when
        /// TBTPopupMenu equals 0.
        self.noTbContextMenu = flags.readBit()
        
        /// J - reserved1 (1 bit): Reserved bit. MUST be 0.
        self.reserved1 = flags.readBit()
        
        /// K - reserved2 (1 bit): Reserved bit. MUST be 0.
        self.reserved2 = flags.readBit()
        
        /// L - NotTopLevel (1 bit): A bit that specifies whether the toolbar can be a top-level toolbar. A value of 1 specifies that this toolbar is a child
        /// of another toolbar, and can never be a top-level toolbar. A value of 0 specifies that this toolbar can be a top-level toolbar. MUST be 1
        /// when the TBTPopupMenu field equals 1; MUST be 0 when the TBTPopupMenu field equals 0.
        self.notTopLevel = flags.readBit()
        
        /// M - reserved3 (1 bit): Reserved bit. MUST be 0.
        self.reserved3 = flags.readBit()
        
        /// N - reserved4 (1 bit): Reserved bit. MUST be 0.
        self.reserved4 = flags.readBit()
        
        /// O - reserved5 (1 bit): Reserved bit. MUST be 0.
        self.reserved5 = flags.readBit()
        
        /// P - reserved6 (1 bit): Reserved bit. MUST be 0.
        self.reserved6 = flags.readBit()
        
        /// Q - reserved7 (1 bit): Reserved bit. MUST be 0.
        self.reserved7 = flags.readBit()
        
        /// R - reserved8 (1 bit): Reserved bit. MUST be 0.
        self.reserved8 = flags.readBit()
        
        /// S - reserved9 (1 bit): Reserved bit. MUST be 0.
        self.reserved9 = flags.readBit()
        
        /// T - reserved10 (1 bit): Reserved bit. MUST be 0.
        self.reserved10 = flags.readBit()
        
        /// U - reserved11 (1 bit): Reserved bit. MUST be 0.
        self.reserved11 = flags.readBit()
        
        /// V - reserved12 (1 bit): Reserved bit. MUST be 0.
        self.reserved12 = flags.readBit()
        
        /// W - reserved13 (1 bit): Reserved bit. MUST be 0.
        self.reserved13 = flags.readBit()
        
        /// X - reserved14 (1 bit): Reserved bit. MUST be 0.
        self.reserved14 = flags.readBit()
        
        /// Y - reserved15 (1 bit): Reserved bit. MUST be 0.
        self.reserved15 = flags.readBit()
        
        /// Z - TBTPopupMenu (1 bit): A bit that specifies whether this toolbar is of type menu toolbar. A value of 1 specifies that this is a menu
        /// toolbar. If the value equals 1, the fields NoResize, NoMove, NoChangeDock, NoBorder, NoTbContextMenu, and NotTopLevel MUST
        /// equal 1.
        self.tbtPopupMenu = flags.readBit()
        
        /// a - reserved16 (1 bit): Reserved bit. MUST be 0.
        self.reserved16 = flags.readBit()
        
        /// reserved17 (5 bits): Reserved bits. MUST be 0.
        self.reserved17 = UInt8(flags.readRemainingBits())
    }
}
