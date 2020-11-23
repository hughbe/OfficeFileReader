//
//  TBCHeader.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.10 TBCHeader
/// Toolbar control header information.
public struct TBCHeader {
    public let bSignature: Int8
    public let bVersion: Int8
    public let bFlagsTCR: TBCFlags
    public let tct: ToolbarControlType
    public let tcid: UInt16
    public let tbct: TBCSFlags
    public let bPriority: UInt8
    public let width: UInt16?
    public let height: UInt16?
    
    public init(dataStream: inout DataStream) throws {
        /// bSignature (1 byte): Signed integer that specifies the toolbar control signature number. MUST be 0x03.
        self.bSignature = try dataStream.read()
        if self.bSignature != 0x03 {
            throw OfficeFileError.corrupted
        }
        
        /// bVersion (1 byte): Signed integer that specifies the toolbar control version number. MUST be 0x01.
        self.bVersion = try dataStream.read()
        if self.bVersion != 0x01 {
            throw OfficeFileError.corrupted
        }

        /// bFlagsTCR (1 byte): Structure of type TBCFlags (section 2.3.1.11) that specifies toolbar control flags.
        self.bFlagsTCR = try TBCFlags(dataStream: &dataStream)
        
        /// tct (1 byte): Unsigned integer that specifies the toolbar control type. The value MUST be in the following table:
        let tctRaw: UInt8 = try dataStream.read()
        guard let tct = ToolbarControlType(rawValue: tctRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.tct = tct
        
        /// tcid (2 bytes): Unsigned integer that specifies the toolbar control identifier (TCID) for this toolbar control. MUST be 0x0001 when the
        /// toolbar control is a custom toolbar control or MUST be equal to one of the values listed in [MS-CTDOC] section 2.2 or in [MS-CTXLS]
        /// section 2.2 when the toolbar control is not a custom toolbar control.
        self.tcid = try dataStream.read(endianess: .littleEndian)
        
        /// tbct (4 bytes): Structure of type TBCSFlags (section 2.3.1.12) that specifies toolbar control flags.
        self.tbct = try TBCSFlags(dataStream: &dataStream)
        
        /// bPriority (1 byte): Unsigned integer that specifies the toolbar control priority for dropping and wrapping purposes. The value MUST be
        /// in the range 0x00 to 0x07. If the value equals 0x00, it is considered the default state. If it equals 0x01 the toolbar control will never be
        /// dropped from the toolbar and will be wrapped when needed. Otherwise, the higher the number the sooner the toolbar control will be
        /// dropped.
        self.bPriority = try dataStream.read()
        if self.bPriority > 0x07 {
            throw OfficeFileError.corrupted
        }
        
        /// width (2 bytes): Unsigned integer that specifies the width, in pixels, of the toolbar control. MUST only exist if bFlagsTCR.fSaveDxy equals 1.
        if self.bFlagsTCR.fSaveDxy {
            self.width = try dataStream.read(endianess: .littleEndian)
        } else {
            self.width = nil
        }
        
        /// height (2 bytes): Unsigned integer that specifies the height, in pixels, of the toolbar control. MUST only exist if bFlagsTCR.fSaveDxy equals 1.
        if self.bFlagsTCR.fSaveDxy {
            self.height = try dataStream.read(endianess: .littleEndian)
        } else {
            self.height = nil
        }
    }
    
    /// tct (1 byte): Unsigned integer that specifies the toolbar control type. The value MUST be in the following table:
    public enum ToolbarControlType: UInt8 {
        /// 0x01 Button control
        case button = 0x01
        
        /// 0x02 Edit control
        case edit = 0x02
        
        /// 0x03 DropDown control
        case dropDown = 0x03
        
        /// 0x04 ComboBox control
        case comboBox = 0x04
        
        /// 0x06 SplitDropDown control
        case splitDropDown = 0x06
        
        /// 0x07 OCXDropDown control
        case ocxDropDown = 0x07
        
        /// 0x09 GraphicDropDown control
        case graphicDropDown = 0x09
        
        /// 0x0A Popup control
        case popup = 0x0A
        
        /// 0x0C ButtonPopup control
        case buttonPopup = 0x0C
        
        /// 0x0D SplitButtonPopup control
        case splitButtonPopup = 0x0D
        
        /// 0x0E SplitButtonMRUPopup control
        case splitButtonMRUPopup = 0x0E
        
        /// 0x0F Label control
        case label = 0x0F
        
        /// 0x10 ExpandingGrid control
        case expandingGrid = 0x10
        
        /// 0x12 Grid control
        case grid = 0x12
        
        /// 0x13 Gauge control
        case gauge = 0x13
        
        /// 0x14 GraphicCombo control
        case graphicCombo = 0x14
        
        /// 0x15 Pane control
        case pane = 0x15
        
        /// 0x16 ActiveX control
        case activeX = 0x16
    }
}
