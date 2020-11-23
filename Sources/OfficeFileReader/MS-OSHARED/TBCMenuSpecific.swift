//
//  TBCMenuSpecific.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.21 TBCMenuSpecific
/// Contains information specific to Popup, ButtonPopup, SplitButtonPopup, and SplitButtonMRUPopup type toolbar controls.
public struct TBCMenuSpecific {
    public let tbid: Int32
    public let name: WString?
    
    public init(dataStream: inout DataStream) throws {
        /// tbid (4 bytes): Signed integer that specifies the toolbar ID of the toolbar that the toolbar control drops. MUST be greater than or equal to
        /// 0x00000000. A value of 0x00000000 means that the toolbar control does not drop a toolbar. A value of 0x00000001 means that the
        /// toolbar control drops a custom toolbar. A value greater than 0x00000001 means that the toolbar control drops a built-in toolbar.
        /// See [MS-CTDOC] section 2.1 and [MS-CTXLS] section 2.1 for a list of toolbar identifiers associated with built-in toolbars.
        self.tbid = try dataStream.read(endianess: .littleEndian)
        if self.tbid < 0x00000000 {
            throw OfficeFileError.corrupted
        }
        
        /// name (variable): Structure of type WString (section 2.3.1.4). Name of the custom toolbar that the toolbar control drops. MUST exist if
        /// tbid equals 0x00000001. MUST NOT exist if tbid is not equal to 0x00000001.
        if self.tbid == 0x00000001 {
            self.name = try WString(dataStream: &dataStream)
        } else {
            self.name = nil
        }
    }
}
