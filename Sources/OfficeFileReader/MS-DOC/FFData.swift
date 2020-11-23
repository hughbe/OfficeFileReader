//
//  FFData.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.78 FFData
/// The FFData structure specifies form field data for a text box, check box, or drop-down list box.
public struct FFData {
    public let version: UInt32
    public let bits: FFDataBits
    public let cch: UInt16
    public let hps: UInt16
    public let xstzName: Xstz
    public let xstzTextDef: Xstz?
    public let wDef: UInt16?
    public let xstzTextFormat: Xstz
    public let xstzHelpText: Xstz
    public let xstzStatText: Xstz
    public let xstzEntryMcr: Xstz
    public let xstzExitMcr: Xstz
    public let hsttbDropList: STTB<String>?
    
    public init(dataStream: inout DataStream) throws {
        /// version (4 bytes): An unsigned integer that MUST be 0xFFFFFFFF.
        self.version = try dataStream.read(endianess: .littleEndian)
        if self.version != 0xFFFFFFFF {
            throw OfficeFileError.corrupted
        }
        
        /// bits (2 bytes): An FFDataBits that specifies the type and state of this form field.
        let bits: FFDataBits = try FFDataBits(dataStream: &dataStream)
        self.bits = bits
        
        /// cch (2 bytes): An unsigned integer that specifies the maximum length, in characters, of the value of the textbox. This value MUST NOT
        /// exceed 32767. A value of 0 means there is no maximum length of the value of the textbox. If bits.iType is not iTypeText (0), this value
        /// MUST be 0.
        let cch: UInt16 = try dataStream.read(endianess: .littleEndian)
        if cch > 32767 {
            throw OfficeFileError.corrupted
        }
        if self.bits.iType != .text && cch != 0 {
            throw OfficeFileError.corrupted
        }
        
        self.cch = cch
        
        /// hps (2 bytes): An unsigned integer. If bits.iType is iTypeChck (1), hps specifies the size, in halfpoints, of the checkbox and
        /// MUST be between 2 and 3168, inclusive. If bits.iType is not iTypeChck (1), hps is undefined and MUST be ignored.
        let hps: UInt16 = try dataStream.read(endianess: .littleEndian)
        if self.bits.iType == .chck && (hps < 2 || hps > 3168) {
            throw OfficeFileError.corrupted
        }
        
        self.hps = hps
        
        /// xstzName (variable): An Xstz that specifies the name of this form field. xstzName.cch MUST NOT exceed 20.
        self.xstzName = try Xstz(dataStream: &dataStream)
        if self.xstzName.xst.rgtchar.count > 20 {
            throw OfficeFileError.corrupted
        }
        
        /// xstzTextDef (variable): An optional Xstz that specifies the default text of this textbox. This structure MUST exist if and only if bits.iType
        /// is iTypeTxt (0). xstzTextDef.cch MUST NOT exceed 255. If bits.iTypeTxt is either iTypeTxtCurDate (3) or iTypeTxtCurTime (4), xstzTextDef
        /// MUST be an empty string. If bits.iTypeTxt is iTypeTxtCalc (5), xstzTextDef specifies an expression to calculate.
        if self.bits.iType == .text {
            let xstzTextDef = try Xstz(dataStream: &dataStream)
            if xstzTextDef.xst.rgtchar.count > 255 {
                throw OfficeFileError.corrupted
            }
            
            self.xstzTextDef = xstzTextDef
        } else {
            self.xstzTextDef = nil
        }
        
        /// wDef (2 bytes): An optional unsigned integer that specifies the default state of the checkbox or dropdown list box. This value MUST
        /// exist if and only if bits.iType is iTypeChck (1) or iTypeDrop (2). If bits.iType is iTypeChck (1), wDef MUST be 0 or 1 and specify the
        /// default state of the checkbox as unchecked or checked, respectively. If bits.iType is iTypeDrop (2), wDef MUST be less than the number
        /// of items in the dropdown list box and specify the default item selected (zerobased index).
        if bits.iType == .chck || bits.iType == .drop {
            let wDef: UInt16 = try dataStream.read(endianess: .littleEndian)
            if self.bits.iType == .chck && wDef != 0 && wDef != 1 {
                throw OfficeFileError.corrupted
            }
            
            self.wDef = wDef
        } else {
            self.wDef = nil
        }
        
        /// xstzTextFormat (variable): An Xstz that specifies the string format of the textbox. xstzTextFormat MUST be an empty string if bits.iType
        /// is not iTypeTxt (0). xstzTextFormat.cch MUST NOT exceed 64. Valid formatting strings are specified in [ECMA-376] part 4, section
        /// 2.16.22 format (Text Box Form Field Formatting).
        let xstzTextFormat = try Xstz(dataStream: &dataStream)
        if self.bits.iType != .text && xstzTextFormat.xst.rgtchar.count != 0 {
            throw OfficeFileError.corrupted
        } else if xstzTextFormat.xst.rgtchar.count > 64 {
            throw OfficeFileError.corrupted
        }
        
        self.xstzTextFormat = xstzTextFormat
        
        /// xstzHelpText (variable): An Xstz that specifies the help text for the form field. The value of xstzHelpText.cch MUST NOT exceed 255.
        self.xstzHelpText = try Xstz(dataStream: &dataStream)
        if self.xstzHelpText.xst.rgtchar.count > 255 {
            throw OfficeFileError.corrupted
        }
        
        /// xstzStatText (variable): An Xstz that specifies the status bar text for the form field. The value of xstzStatText.cch MUST NOT exceed 138.
        self.xstzStatText = try Xstz(dataStream: &dataStream)
        if self.xstzStatText.xst.rgtchar.count > 138 {
            throw OfficeFileError.corrupted
        }
        
        /// xstzEntryMcr (variable): An Xstz that specifies a macro to run on entry of the form field. The value of xstzEntryMcr.cch MUST NOT
        /// exceed 32.
        self.xstzEntryMcr = try Xstz(dataStream: &dataStream)
        if self.xstzEntryMcr.xst.rgtchar.count > 32 {
            throw OfficeFileError.corrupted
        }
        
        /// xstzExitMcr (variable): An Xstz that specifies a macro to run after the value of the form field changes. The value of xstzExitMcr.cch
        /// MUST NOT exceed 32.
        self.xstzExitMcr = try Xstz(dataStream: &dataStream)
        if self.xstzExitMcr.xst.rgtchar.count > 32 {
            throw OfficeFileError.corrupted
        }
        
        /// hsttbDropList (variable): An optional STTB that specifies the entries in the dropdown list box. This MUST exist if and only if bits.iType
        /// is iTypeDrop (2). The entries are Unicode strings and do not have extra data. This MUST NOT exceed 25 elements.
        if self.bits.iType == .drop {
            let hsttbDropList: STTB<String> = try STTB(dataStream: &dataStream)
            if hsttbDropList.cData > 25 {
                throw OfficeFileError.corrupted
            }
            
            self.hsttbDropList = hsttbDropList
        } else {
            self.hsttbDropList = nil
        }
    }
}
