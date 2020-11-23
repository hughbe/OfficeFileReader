//
//  TBCGeneralInfo.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.14 TBCGeneralInfo
/// Referenced by: TBCData
/// Toolbar control general information.
public struct TBCGeneralInfo {
    public let bFlags: TBCGIFlags
    public let customText: WString?
    public let descriptionText: WString?
    public let tooltip: WString?
    public let extraInfo: TBCExtraInfo?
    
    public init(dataStream: inout DataStream) throws {
        /// bFlags (1 byte): Structure of type TBCGIFlags (section 2.3.1.15) that specifies which of the fields of this structure have been saved to the file.
        self.bFlags = try TBCGIFlags(dataStream: &dataStream)
        
        /// customText (variable): Structure of type WString (section 2.3.1.4) that specifies the custom label of the toolbar control. MUST exist if
        /// bFlags.fSaveText equals 1. MUST NOT exist if bFlags.fSaveText equals 0.
        if self.bFlags.fSaveText {
            self.customText = try WString(dataStream: &dataStream)
        } else {
            self.customText = nil
        }
        
        /// descriptionText (variable): Structure of type WString that specifies a description of this toolbar control. MUST exist if
        /// bFlags.fSaveMiscUIStrings equals 1. MUST NOT exist if bflags.fSaveMiscUIString equals 0.
        if self.bFlags.fSaveMiscUIStrings {
            self.descriptionText = try WString(dataStream: &dataStream)
        } else {
            self.descriptionText = nil
        }
        
        /// tooltip (variable): Structure of type WString that SHOULD specify the ToolTip of this toolbar control. MUST exist if
        /// bFlags.fSaveMiscUIStrings equals 1. MUST NOT exist if bFlags.fSaveMiscUIStrings equals 0. If the toolbar control is of type Button
        /// or ExpandingGrid, and the fHyperlinkType field of the TBCBSFlags structure (section 2.3.1.18) contained by the TBCBSpecific structure
        /// (section 2.3.1.17), contained by the TBCData structure (section 2.3.1.13) that contains the TBCGeneralInfo structure (section 2.3.1.14)
        /// that contains this structure does not equal 0, the value of tooltip specifies the hyperlink path for the toolbar control.
        if self.bFlags.fSaveMiscUIStrings {
            self.tooltip = try WString(dataStream: &dataStream)
        } else {
            self.tooltip = nil
        }
        
        /// extraInfo (variable): Structure of type TBCExtraInfo (section 2.3.1.16) that specifies extra information saved for a toolbar control.
        /// MUST exist if bFlags.fSaveMiscCustom equals 1. MUST NOT exist if bFlags.fSaveMiscCustom equals 0.
        if self.bFlags.fSaveMiscCustom {
            self.extraInfo = try TBCExtraInfo(dataStream: &dataStream)
        } else {
            self.extraInfo = nil
        }
    }
}
