//
//  TBCExtraInfo.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.3.1.16 TBCExtraInfo
/// Referenced by: TBCGeneralInfo
/// Structure that specifies extra information saved for a toolbar control.
public struct TBCExtraInfo {
    public let wstrHelpFile: WString
    public let idHelpContext: Int32
    public let wstrTag: WString
    public let wstrOnAction: WString
    public let wstrParam: WString
    public let tbcu: OleMergingBehavior
    public let tbmg: OleMenuMergingBehavior
    
    public init(dataStream: inout DataStream) throws {
        /// wstrHelpFile (variable): A structure of type WString (section 2.3.1.4) that specifies the full path to the help file used to provide the help
        /// topic of the toolbar control. For this field to be used idHelpContext MUST be greater than zero.
        self.wstrHelpFile = try WString(dataStream: &dataStream)
        
        /// idHelpContext (4 bytes): Signed integer that specifies the help context id number for the help topic of the toolbar control. A help context
        /// id is a numeric identifier associated with a specific help topic. For this field to be used wstrHelpFile MUST specify a non-empty string.
        self.idHelpContext = try dataStream.read(endianess: .littleEndian)
        
        /// wstrTag (variable): Structure of type WString that specifies a custom string used to store arbitrary information about the toolbar control.
        self.wstrTag = try WString(dataStream: &dataStream)
        
        /// wstrOnAction (variable): Structure of type WString that specifies the name of the macro associated with this toolbar control.
        self.wstrOnAction = try WString(dataStream: &dataStream)
        
        /// wstrParam (variable): Structure of type WString that specifies a custom string used to store arbitrary information about the toolbar control.
        self.wstrParam = try WString(dataStream: &dataStream)
        
        /// tbcu (1 byte): Signed integer that specifies how the toolbar control will be used during OLE merging. The value MUST be in the
        /// following table.
        let tbcuRaw: Int8 = try dataStream.read()
        guard let tbcu = OleMergingBehavior(rawValue: tbcuRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.tbcu = tbcu
        
        /// tbmg (1 byte): Signed integer that specifies how the toolbar control will be used during OLE menu merging. This field is only used by
        /// toolbar controls of type Popup. The value MUST be in the following table.
        let tbmgRaw: Int8 = try dataStream.read()
        guard let tbmg = OleMenuMergingBehavior(rawValue: tbmgRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.tbmg = tbmg
    }
    
    /// tbcu (1 byte): Signed integer that specifies how the toolbar control will be used during OLE merging. The value MUST be in the following table.
    public enum OleMergingBehavior: Int8 {
        /// 0xFF A correct value was not found for this toolbar control. A value of 0x01 will be used when the value of this field is requested.
        case invalid = -1
        
        /// 0x00 Neither. Toolbar control is not applicable when the application is in either OLE host mode or OLE server mode.
        case neither = 0x00
        
        /// 0x01 Server. Toolbar control is applicable when the application is in OLE server mode. (This is the default value used by custom toolbar
        /// controls.)
        case server = 0x01
        
        /// 0x02 Host. Toolbar control is applicable when the application is in OLE host mode.
        case host = 0x02
        
        /// 0x03 Both. Toolbar control is applicable when the application is in OLE server mode and OLE host mode.
        case both = 0x03
    }
    
    /// tbmg (1 byte): Signed integer that specifies how the toolbar control will be used during OLE menu merging. This field is only used by
    /// toolbar controls of type Popup. The value MUST be in the following table.
    public enum OleMenuMergingBehavior: Int8 {
        /// 0xFFFF None. Toolbar control will not be placed in any OLE menu group.
        case none = -1
        
        /// 0x0000 File. Toolbar control will be placed in the File OLE menu group.
        case file = 0x00
        
        /// 0x0001 Edit. Toolbar control will be placed in the Edit OLE menu group.
        case edit = 0x01
        
        /// 0x0002 Container. Toolbar control will be placed in the Container OLE menu group.
        case container = 0x02
        
        /// 0x0003 Object. Toolbar control will be placed in the Object OLE menu group.
        case object = 0x03
        
        /// 0x0004 Window. Toolbar control will be placed in the Window OLE menu group.
        case window = 0x04
        
        /// 0x0005 Help. Toolbar control will be placed in the Help OLE menu group.
        case help = 0x05
    }
}
