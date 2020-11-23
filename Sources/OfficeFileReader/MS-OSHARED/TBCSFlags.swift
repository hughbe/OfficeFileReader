//
//  TBCSFlags.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.12 TBCSFlags
/// Referenced by: TBCHeader
/// Toolbar control flags that manage specific properties of a toolbar control. The bit description begins from the least significant bit.
public struct TBCSFlags {
    public let textIcon: UInt8
    public let fOwnerDraw: Bool
    public let fAllowResize: Bool
    public let fOneState: Bool
    public let fNoSetCursor: Bool
    public let fNoAccel: Bool
    public let fChgAccel: Bool
    public let unused1: UInt8
    public let fAlwaysEnabled: Bool
    public let fAlwaysVisible: Bool
    public let fNoChangeLabel: Bool
    public let fKeepLabel: Bool
    public let fNoQueryTooltip: Bool
    public let fSaveUIStrings: Bool
    public let fExclusivePopup: Bool
    public let fDefaultBehavior: Bool
    public let unused2: Bool
    public let fWrapText: Bool
    public let fTextBelow: Bool
    public let unused3: UInt8
    public let reserved1: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - textIcon (2 bits): Unsigned integer that specifies the visibility of the label and icon of this toolbar control. The value MUST be in the
        /// following table:
        /// Value (value of bits in parenthesis) Meaning - When toolbar control is on a basic toolbar Meaning - When toolbar control is on a menu toolbar
        /// 0x00 (00) Text is not visible and icon is visible Text is visible and icon is visible.
        /// 0x01 (01) Text is not visible and icon is visible Text is visible and icon is not visible
        /// 0x02 (10) Text is visible and icon is not visible. Text is visible and icon is not visible.
        /// 0x03 (11) Text is visible and icon is visible. Text is visible and icon is visible.
        self.textIcon = UInt8(flags.readBits(count: 2))
        
        /// B - fOwnerDraw (1 bit): A bit that specifies whether this toolbar control uses an internal rendering option. A value of 1 specifies that this
        /// toolbar control uses an internal rendering option. MUST be 0 if the tcid value of the TBCHeader structure (section 2.3.1.10) that contains
        /// this structure equals 0x0001. If the tcid value of the TBCHeader structure that contains this structure does not equal 0x0001, this value
        /// MUST be equal to the value associated with the tcid listed in [MS-CTDOC] section 2.2 or in [MS-CTXLS] section 2.2.
        self.fOwnerDraw = flags.readBit()
        
        /// C - fAllowResize (1 bit): A bit that specifies whether sizing is allowed for this toolbar control. A value of 1 specifies that toolbar control
        /// sizing is allowed. This flag is used when a toolbar control is being initialized and allows for the toolbar control to be smaller or bigger
        /// than normal. MUST be 0 if the tcid value of the TBCHeader structure that contains this structure equals 0x0001. If the tcid value of the
        /// TBCHeader structure that contains this structure does not equal 0x0001, this value MUST be equal to the value associated with the
        /// tcid listed in [MS-CTDOC] section 2.2 or in [MS-CTXLS] section 2.2.
        self.fAllowResize = flags.readBit()
        
        /// D - fOneState (1 bit): A bit that specifies whether this is a one-state toolbar control. This bit is only used by toolbar controls of type
        /// Button or ExpandingGrid. A value of 1 specifies that the toolbar control can have only one state (ButtonUp, the value of the state field
        /// of the TBCBSFlags structure (section 2.3.1.18) contained in the TBCBSpecific structure (section 2.3.1.17) contained in the TBCData
        /// structure (section 2.3.1.13) that contains toolbar control information for this toolbar control equals 0). MUST be 0 if the tcid value of
        /// the TBCHeader structure that contains this structure equals 0x0001. If the tcid value of the TBCHeader structure that contains this
        /// structure does not equal 0x0001, this value MUST be equal to the value associated with the tcid listed in [MS-CTDOC] section 2.2
        /// or in [MS-CTXLS] section 2.2.
        self.fOneState = flags.readBit()
        
        /// E - fNoSetCursor (1 bit): A bit that specifies whether the toolbar control can change the mouse cursor when it is over the toolbar
        /// control area. A value of 1 specifies that the toolbar control can change the mouse cursor when this is over the toolbar control area.
        /// MUST be 0 if the tcid value of the TBCHeader structure that contains this structure equals 0x0001. SHOULD<4> be 0 if the tcid
        /// value of the TBCHeader structure that contains this structure does not equal 0x0001.
        self.fNoSetCursor = flags.readBit()
        
        /// F - fNoAccel (1 bit): A bit that specifies whether this toolbar control has accelerator keys. A value of 1 specifies that the toolbar control
        /// does not have accelerator keys. MUST be 0 if the tcid value of the TBCHeader structure that contains this structure equals 0x0001.
        /// SHOULD<5> be 0 if the tcid value of the TBCHeader structure that contains this structure does not equal 0x0001.
        self.fNoAccel = flags.readBit()
        
        /// G - fChgAccel (1 bit): A bit that specifies whether the accelerator keys for the toolbar control can change. A value of 1 specifies that the
        /// accelerator keys can be changed by the application. MUST be 0 if the tcid value of the TBCHeader structure that contains this structure
        /// equals 0x0001. If the tcid value of the TBCHeader structure that contains this structure does not equal 0x0001, this value MUST be equal
        /// to the value associated with the tcid listed in [MS-CTDOC] section 2.2 or in [MS-CTXLS] section 2.2.
        self.fChgAccel = flags.readBit()
        
        /// unused1 (8 bits): Undefined and MUST be ignored.
        self.unused1 = UInt8(flags.readBits(count: 8))
        
        /// H - fAlwaysEnabled (1 bit): A bit that specifies whether this toolbar control is enabled by default. A value of 1 specifies that the toolbar
        /// control is enabled by default. MUST be 0 if the tcid value of the TBCHeader structure that contains this structure equals 0x0001.
        /// SHOULD<6> be 0 if the tcid value of the TBCHeader structure that contains this structure does not equal 0x0001.
        self.fAlwaysEnabled = flags.readBit()
        
        /// I - fAlwaysVisible (1 bit): A bit that specifies whether this toolbar control is visible by default. A value of 1 specifies that the toolbar control
        /// is visible by default. MUST be 0 if the tcid value of the TBCHeader structure that contains this structure equals 0x0001. If the tcid value
        /// of the TBCHeader structure that contains this structure does not equal 0x0001, this value MUST be equal to the value associated with
        /// the tcid listed in [MS-CTDOC] section 2.2 or in [MS-CTXLS] section 2.2.
        self.fAlwaysVisible = flags.readBit()
        
        /// J - fNoChangeLabel (1 bit): A bit that specifies whether the label of the toolbar control can change. A value of 1 specifies that the toolbar
        /// control label does not be changed by the application. MUST be 0 if the tcid value of the TBCHeader structure (section 2.3.1.10) that
        /// contains this structure equals 0x0001. If the tcid value of the TBCHeader structure that contains this structure does not equal 0x0001,
        /// this value MUST be equal to the value associated with the tcid listed in [MSCTDOC] section 2.2 or in [MS-CTXLS] section 2.2.
        self.fNoChangeLabel = flags.readBit()
        
        /// K - fKeepLabel (1 bit): A bit that specifies whether the label of the toolbar control can change. A value of 1 specifies that the toolbar
        /// control label will not be changed by the application unless the toolbar control is reset.
        self.fKeepLabel = flags.readBit()
        
        /// L - fNoQueryTooltip (1 bit): A bit that specifies whether the toolbar control can use an internal string as a ToolTip. A value of 1 specifies
        /// that the toolbar control will not use an internal string as a ToolTip. If the toolbar control has a custom ToolTip, it will use it. MUST be 0
        /// if the tcid value of the TBCHeader structure (section 2.3.1.10) that contains this structure equals 0x0001. If the tcid value of the
        /// TBCHeader structure that contains this structure does not equal 0x0001, this value MUST be equal to the value associated with the tcid
        /// listed in [MS-CTDOC] section 2.2 or in [MS-CTXLS] section 2.2.
        self.fNoQueryTooltip = flags.readBit()
        
        /// M - fSaveUIStrings (1 bit): A bit that specifies whether none, one, or more of a variety of strings are saved to the file. A value of 1
        /// specifies that one or more of the following fields will be saved to the file: customText, descriptionText, and tooltip fields of the
        /// TBCGeneralInfo structure (section 2.3.1.14) contained by the TBCData structure (section 2.3.1.13) contained by the structure that
        /// contains the TBCHeader structure (section 2.3.1.10) that contains this structure and if this toolbar control is of type Button or
        /// ExpandingGrid, the wstrAcc field of the TBCBSpecific structure (section 2.3.1.17) contained by the TBCData structure contained by the
        /// structure that contains the TBCHeader structure that contains this structure. When the value of the tcid field of the TBCHeader structure
        /// that contains the TBCSFlags structure (section 2.3.1.12) that contains this field equals 1, fSaveUIStrings is equal to 1, even if no extra
        /// strings are saved to the file.
        self.fSaveUIStrings = flags.readBit()
        
        /// N - fExclusivePopup (1 bit): A bit that specifies whether the toolbar control is going to drop a unique custom toolbar. This bit is only
        /// used by toolbar controls that drop a menu toolbar. A value of 1 specifies that the toolbar control is going to drop a unique custom
        /// toolbar. SHOULD<7> be 0.
        self.fExclusivePopup = flags.readBit()
        
        /// O - fDefaultBehavior (1 bit): A bit that specifies whether the toolbar control will have default behavior during OLE merging. A value of 1
        /// specifies that the toolbar control will have default behavior during OLE merging. A value of 0 specifies that the application can change
        /// the behavior of the toolbar control during OLE merging. SHOULD<8> be 0.
        self.fDefaultBehavior = flags.readBit()
        
        /// P - unused2 (1 bit): Undefined and MUST be ignored.
        self.unused2 = flags.readBit()
        
        /// Q - fWrapText (1 bit): A bit that specifies whether the toolbar control can wrap its label across multiple lines. A value of 1 specifies that
        /// the label of the toolbar control can wrap across multiple lines.
        self.fWrapText = flags.readBit()
        
        /// R - fTextBelow (1 bit): A bit that specifies that the label of the toolbar control will be displayed under the toolbar control icon. A value of
        /// 1 specifies that the label of the toolbar control will be displayed under the toolbar control icon, rather than beside it.
        self.fTextBelow = flags.readBit()
        
        /// unused3 (4 bits): Undefined and MUST be ignored.
        self.unused3 = UInt8(flags.readBits(count: 4))
        
        /// S - reserved1 (1 bit): Reserved bit. MUST be 0.
        self.reserved1 = flags.readBit()
    }
}
