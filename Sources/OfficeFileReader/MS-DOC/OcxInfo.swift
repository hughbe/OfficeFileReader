//
//  OcxInfo.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.161 OcxInfo
/// The OcxInfo structure specifies an OLE control (such as a checkbox, radio button, and so on) in the document. The data that is contained in
/// OcxInfo structures SHOULD<229> be ignored.
public struct OcxInfo {
    public let dwCookie: UInt32
    public let ifld: UInt32
    public let hAccel: UInt32
    public let cAccel: UInt32
    public let fifld: Bool
    public let fEatsReturn: Bool
    public let fEatsEscape: Bool
    public let fDefaultButton: Bool
    public let fCancelButton: Bool
    public let fFailedLoad: Bool
    public let fRTL: Bool
    public let fCorrupt: Bool
    public let reserved1: UInt8
    public let idoc: PlcFldType
    public let reserved2: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// dwCookie (4 bytes): An integer value that specifies the index location of this OcxInfo in the RgxOcxInfo array. This value MUST be
        /// unique for all OcxInfo structures in the document.
        self.dwCookie = try dataStream.read(endianess: .littleEndian)
        
        /// ifld (4 bytes): An unsigned integer value that specifies an index location in the PlcFld structure. The value MUST be a valid FLD index
        /// in the correct PlcFld structure.
        /// The PlcFld that is used is dependent on the value of idoc, as specified following.
        /// Value Location
        /// 1 The Main Document (FibRgFcLcb97.fcPlcfFldMom).
        /// 2 The Header Document (FibRgFcLcb97.fcPlcfFldHdr).
        /// 3 The Footnote Document (FibRgFcLcb97.fcPlcfFldFtn).
        /// 4 The Textbox Document (FibRgFcLcb97.fcPlcfFldTxbx).
        /// 6 The Endnote Document (FibRgFcLcb97.fcPlcfFldEdn).
        /// 7 The Comment Document (FibRgFcLcb97.fcPlcfFldAtn).
        /// 8 The Header Textbox Document (FibRgFcLcb97.fcPlcfHdrtxbxTxt).
        self.ifld = try dataStream.read(endianess: .littleEndian)
        
        /// hAccel (4 bytes): This value is undefined and MUST be ignored.
        self.hAccel = try dataStream.read(endianess: .littleEndian)
        
        /// cAccel (2 bytes): An unsigned integer that specifies the number of entries in the accelerator key table of this control.
        self.cAccel = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fifld (1 bit): This field MUST have a value of 1.
        self.fifld = flags.readBit()
        
        /// B - fEatsReturn (1 bit): Specifies whether this control is a sink for the ENTER key.
        self.fEatsReturn = flags.readBit()
        
        /// C - fEatsEscape (1 bit): Specifies whether this control is a sink for the ESC key.
        self.fEatsEscape = flags.readBit()
        
        /// D - fDefaultButton (1 bit): Specifies whether this control is the default button.
        self.fDefaultButton = flags.readBit()
        
        /// E - fCancelButton (1 bit): Specifies whether this control is the default CANCEL button.
        self.fCancelButton = flags.readBit()
        
        /// F - fFailedLoad (1 bit): Specifies whether an error occurred during the loading of this control. A value of 1 specifies that this control
        /// MUST be ignored.
        self.fFailedLoad = flags.readBit()
        
        /// G - fRTL (1 bit): Specifies whether this control has special display handling for right-to-left languages.
        self.fRTL = flags.readBit()
        
        /// H - fCorrupt (1 bit): Specifies whether this control is corrupted. A value of 1 specifies that this control MUST be ignored.
        self.fCorrupt = flags.readBit()
        
        /// reserved1 (8 bits): Undefined and MUST be ignored.
        self.reserved1 = UInt8(flags.readRemainingBits())
        
        /// idoc (2 bytes): An integer that specifies where ifld can be found. The value MUST be one of the following.
        let idocRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let idoc = PlcFldType(rawValue: idocRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.idoc = idoc
        
        /// reserved2 (2 bytes): Undefined and MUST be ignored.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
    }
    
    /// idoc (2 bytes): An integer that specifies where ifld can be found. The value MUST be one of the following.
    public enum PlcFldType: UInt16 {
        /// 1 The Main Document.
        case mainDocument = 1
        
        /// 2 The Header Document.
        case headerDocument = 2
        
        /// 3 The Footnote Document.
        case footnoteDocument = 3
        
        /// 4 The Textbox Document.
        case textboxDocument = 4
        
        /// 6 The Endnote Document.
        case endnoteDocument = 6
        
        /// 7 The Comment Document.
        case commentDocument = 7
        
        /// 8 The Header Textbox Document.
        case headerTextbox = 8
    }
}
