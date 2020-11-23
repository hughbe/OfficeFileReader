//
//  grfhic.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.111 grfhic
/// The grfhic structure is a set of HTML incompatibility flags that specify the HTML incompatibilities of a list structure. The values specify possible
/// incompatibilities between an LVL or LVLF and HTML lists. The values do not define list properties.
public struct grfhic {
    public let fhicChecked: Bool
    public let fhicFormat: Bool
    public let fhicListText: Bool
    public let fhicPeriod: Bool
    public let fhicLeft1: Bool
    public let fhicListTab: Bool
    public let unused: Bool
    public let fhicBullet: Bool
    
    public init(dataStream: inout DataStream) throws {
        self.init(rawValue: try dataStream.read(endianess: .littleEndian))
    }
    
    public init(rawValue: UInt8) {
        var flags = BitFieldReader(rawValue: rawValue)
        
        /// A - fhicChecked (1 bit): A bit that specifies whether the list structure that contains this grfhic structure is checked for HTML incompatibilities.
        self.fhicChecked = flags.readBit()
        
        /// B - fhicFormat (1 bit): A bit that specifies whether the numbering sequence or format of an LVL is unsupported by HTML at the time of the most
        /// recent HTML compatibility check. The numbering sequence or format of an LVL is unsupported by HTML if one or more of the following
        /// conditions are "true".
        ///  LVL.lvlf.nfc is greater than 0x04
        ///  LVL.lvlf.fLegal is nonzero
        ///  LVL.lvlf.fNoRestart is nonzero
        ///  LVL.lvlf.ixchFollow is nonzero
        /// If fhicChecked is zero, this MUST be ignored. If the structure that contains this grfhic is not an LVLF, this MUST be ignored.
        self.fhicFormat = flags.readBit()
        
        /// C - fhicListText (1 bit): A bit that specifies whether the string specified by LVL.xst was not of the standard form "#." (a level number placeholder
        /// followed by a period) at the time of the most recent HTML compatibility check. If fhicChecked is zero, this MUST be ignored. If the structure
        /// that contains this grfhic is not an LVLF, this MUST be ignored.
        self.fhicListText = flags.readBit()
        
        /// D - fhicPeriod (1 bit): A bit that specifies whether something other than a period was the last character of the number text specified by LVL.xst
        /// at the time of the most recent HTML compatibility check. If fhicChecked is zero, this MUST be ignored. If the structure that contains
        /// this grfhic is not an LVLF, this MUST be ignored.
        self.fhicPeriod = flags.readBit()
        
        /// E - fhicLeft1 (1 bit): A bit that specifies whether the indents specified by LVL.grpprlPapx were different than the standard HTML indents at the
        /// time of the most recent HTML compatibility check. The indents that are specified by LVL.grpprlPapx are different than the standard HTML
        /// indents if one or more of the conditions in the following list are "true":
        ///  The logical left indent of the first line of the paragraph properties that are specified by LVL.grpprlPapx (see sprmPDxaLeft1) is not equal to -360.
        ///  The logical left indent of the paragraph properties that are specified by LVL.grpprlPapx (see sprmPDxaLeft) is not equal to 720 * (iLvl + 1),
        /// where iLvl is the zero-based level of the list that LVL corresponds to.
        /// If fhicChecked is zero, this MUST be ignored. If the structure that contains this grfhic is not a LVLF, this MUST be ignored.
        self.fhicLeft1 = flags.readBit()
        
        /// F - fhicListTab (1 bit): A bit that specifies whether the first added custom tab stop of the paragraph properties specified by LVL.grpprlPapx
        /// (see sprmPChgTabs and sprmPChgTabsPapx) was not equal to the logical left indent of the paragraph properties specified by LVL.grpprlPapx (see
        /// sprmPDxaLeft) at the time of the most recent HTML compatibility check. If LVL.grpprlPapx does not add any custom tabs, this MUST be zero.
        /// If fhicChecked is zero, this MUST be ignored. If the structure that contains this grfhic is not an LVLF, this MUST be ignored.
        self.fhicListTab = flags.readBit()
        
        /// G - unused (1 bit): This bit is undefined and MUST be ignored.
        self.unused = flags.readBit()
        
        /// H - fhicBullet (1 bit): A bit that specifies whether the level used bullets instead of numbers at the time of the most recent HTML compatibility
        /// check. A level uses bullets if LVL.lvlf.nfc is equal to 0x17. If fhicChecked is zero, this MUST be ignored. If the structure that contains this grfhic is
        /// not an LVLF, this MUST be ignored.
        self.fhicBullet = flags.readBit()
    }
}
