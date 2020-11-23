//
//  TBCComboDropdownSpecific.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.3.1.19 TBCComboDropdownSpecific
/// Contains information specific to Edit, ComboBox, GraphicCombo, DropDown, SplitDropDown, and GraphicDropDown type toolbar controls.
public struct TBCComboDropdownSpecific {
    public let data: TBCCDData?
    
    public init(dataStream: inout DataStream, header: TBCHeader) throws {
        /// data (variable): Structure of type TBCCDData (section 2.3.1.20). MUST exist if the toolbar control identifier (TCID) (the tcid field of the
        /// TBCHeader structure (section 2.3.1.10) contained by the structure that contains the TBCData structure (section 2.3.1.13) that contains
        /// this structure) equals 0x0001. MUST NOT exist if the TCID does not equal 0x0001.
        if header.tcid == 0x0001 {
            self.data = try TBCCDData(dataStream: &dataStream)
        } else {
            self.data = nil
        }
    }
}
