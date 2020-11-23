//
//  TBCData.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.13 TBCData
/// Toolbar control information.
public struct TBCData {
    public let controlGeneralInfo: TBCGeneralInfo
    public let controlSpecificInfo: ControlSpecificInfo
    
    public init(dataStream: inout DataStream, header: TBCHeader) throws {
        /// controlGeneralInfo (variable): Structure of type TBCGeneralInfo (section 2.3.1.14) that specifies toolbar control general information.
        self.controlGeneralInfo = try TBCGeneralInfo(dataStream: &dataStream)

        /// controlSpecificInfo (variable): Toolbar control specific information is saved depending on the type of the toolbar control which is specified
        /// by the value of the tct field of the TBCHeader structure (section 2.3.1.10) contained by the structure that contains this structure. The
        /// following table shows the type of structure that is saved according to the type of the toolbar control:
        self.controlSpecificInfo = try ControlSpecificInfo(dataStream: &dataStream, header: header)
    }
    
    /// controlSpecificInfo (variable): Toolbar control specific information is saved depending on the type of the toolbar control which is specified
    /// by the value of the tct field of the TBCHeader structure (section 2.3.1.10) contained by the structure that contains this structure. The
    /// following table shows the type of structure that is saved according to the type of the toolbar control:
    /// Value of the tct field Type of the controlSpecificInfo field
    /// 0x01 (Button control) TBCBSpecific (section 2.3.1.17)
    /// 0x10 (ExpandingGrid control) TBCBSpecific
    /// 0x0A (Popup control) TBCMenuSpecific (section 2.3.1.21)
    /// 0x0C (ButtonPopup control) TBCMenuSpecific
    /// 0x0D (SplitButtonPopup control) TBCMenuSpecific
    /// 0x0E (SplitButtonMRUPopup control) TBCMenuSpecific
    /// 0x02 (Edit control) TBCComboDropdownSpecific (section 2.3.1.19)
    /// 0x04 (ComboBox control) TBCComboDropdownSpecific
    /// 0x14 (GraphicCombo control) TBCComboDropdownSpecific
    /// 0x03 (DropDown control) TBCComboDropdownSpecific
    /// 0x06 (SplitDropDown control) TBCComboDropdownSpecific
    /// 0x09 (GraphicDropDown control) TBCComboDropdownSpecific
    /// 0x07 (OCXDropDown control) controlSpecificInfo MUST NOT exist
    /// 0x0F (Label control) controlSpecificInfo MUST NOT exist
    /// 0x12 (Grid control) controlSpecificInfo MUST NOT exist
    /// 0x13 (Gauge control) controlSpecificInfo MUST NOT exist
    /// 0x15 (Pane control) controlSpecificInfo MUST NOT exist
    /// 0x16 (ActiveX control) controlSpecificInfo MUST NOT exist
    public enum ControlSpecificInfo {
        case specific(data: TBCBSpecific)
        case menuSpecific(data: TBCMenuSpecific)
        case comboDropdownSpecific(data: TBCComboDropdownSpecific)
        case none
        
        public init(dataStream: inout DataStream, header: TBCHeader) throws {
            switch header.tct {
            case .button:
                self = .specific(data: try TBCBSpecific(dataStream: &dataStream))
            case .expandingGrid:
                self = .specific(data: try TBCBSpecific(dataStream: &dataStream))
            case .popup:
                self = .menuSpecific(data: try TBCMenuSpecific(dataStream: &dataStream))
            case .buttonPopup:
                self = .menuSpecific(data: try TBCMenuSpecific(dataStream: &dataStream))
            case .splitButtonPopup:
                self = .menuSpecific(data: try TBCMenuSpecific(dataStream: &dataStream))
            case .splitButtonMRUPopup:
                self = .menuSpecific(data: try TBCMenuSpecific(dataStream: &dataStream))
            case .edit:
                self = .comboDropdownSpecific(data: try TBCComboDropdownSpecific(dataStream: &dataStream, header: header))
            case .comboBox:
                self = .comboDropdownSpecific(data: try TBCComboDropdownSpecific(dataStream: &dataStream, header: header))
            case .graphicCombo:
                self = .comboDropdownSpecific(data: try TBCComboDropdownSpecific(dataStream: &dataStream, header: header))
            case .dropDown:
                self = .comboDropdownSpecific(data: try TBCComboDropdownSpecific(dataStream: &dataStream, header: header))
            case .splitDropDown:
                self = .comboDropdownSpecific(data: try TBCComboDropdownSpecific(dataStream: &dataStream, header: header))
            case .graphicDropDown:
                self = .comboDropdownSpecific(data: try TBCComboDropdownSpecific(dataStream: &dataStream, header: header))
            case .ocxDropDown:
                self = .none
            case .label:
                self = .none
            case .grid:
                self = .none
            case .gauge:
                self = .none
            case .pane:
                self = .none
            case .activeX:
                self = .none
            }
        }
    }
}
