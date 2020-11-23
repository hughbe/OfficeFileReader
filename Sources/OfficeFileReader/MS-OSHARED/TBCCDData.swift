//
//  TBCCDData.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.20 TBCCDData
/// Referenced by: TBCComboDropdownSpecific
/// Contains information specific to Edit, ComboBox, GraphicCombo, DropDown, SplitDropDown, and GraphicDropDown type toolbar controls.
public struct TBCCDData {
    public let cwstrItems: Int16
    public let wstrList: [WString]
    public let cwstrMRU: Int16
    public let iSel: Int16
    public let cLines: Int16
    public let dxWidth: Int16
    public let wstrEdit: WString
    
    public init(dataStream: inout DataStream) throws {
        /// cwstrItems (2 bytes): Signed integer that specifies the number of items in wstrList. MUST be positive.
        let cwstrItems: Int16 = try dataStream.read(endianess: .littleEndian)
        if cwstrItems < 0 {
            throw OfficeFileError.corrupted
        }
        
        self.cwstrItems = cwstrItems
        
        /// wstrList (variable): Zero-based index array of WString structures (section 2.3.1.4). The number of elements MUST be equal to
        /// cwstrItems. Contains the list of strings that are dropped by this toolbar control.
        var wstrList: [WString] = []
        wstrList.reserveCapacity(Int(self.cwstrItems))
        for _ in 0..<self.cwstrItems {
            wstrList.append(try WString(dataStream: &dataStream))
        }
        
        self.wstrList = wstrList
        
        /// cwstrMRU (2 bytes): Signed integer that specifies the number of most recently used strings. MUST be equal to 0xFFFF (-1) or greater
        /// than or equal to 0x0000. A value of 0xFFFF (-1) means that there are no most recently used strings.
        self.cwstrMRU = try dataStream.read(endianess: .littleEndian)
        if self.cwstrMRU < -1 {
            throw OfficeFileError.corrupted
        }
        
        /// iSel (2 bytes): Signed integer that specifies the zero-based index of the selected item in the wstrList field. MUST be equal to 0xFFFF
        /// (-1) or greater than or equal to 0x0000. A value of 0xFFFF (-1) means that there is no selected item. MUST be less than the cwstrItems value.
        let iSel: Int16 = try dataStream.read(endianess: .littleEndian)
        if iSel < -1 || iSel >= cwstrItems {
            throw OfficeFileError.corrupted
        }
        
        self.iSel = iSel
        
        /// cLines (2 bytes): Signed integer that specifies the suggested number of lines that the toolbar control will display at any time when
        /// displaying the elements of wstrList. A value of 0x0000 means that the toolbar control will size itself according to the number of items.
        /// MUST equal to or greater than 0x0000.
        self.cLines = try dataStream.read(endianess: .littleEndian)
        if self.cLines < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// dxWidth (2 bytes): Signed integer that specifies the width in pixels that the interior of the dropdown has. This excludes the width of the
        /// toolbar control border and scroll bar. MUST be equal to 0xFFFF (-1) or greater than or equal to 0x0000. A value of 0xFFFF (-1) will set
        /// the width to accommodate all the strings in wstrList.
        self.dxWidth = try dataStream.read(endianess: .littleEndian)
        if self.dxWidth < -1 {
            throw OfficeFileError.corrupted
        }
        
        /// wstrEdit (variable): Structure of type WString (section 2.3.1.4). Editable text for editable area of the ComboBox toolbar control.
        self.wstrEdit = try WString(dataStream: &dataStream)
    }
}
