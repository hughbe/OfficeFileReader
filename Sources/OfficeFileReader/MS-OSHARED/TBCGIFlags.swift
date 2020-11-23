//
//  TBCGIFlags.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.3.1.15 TBCGIFlags
/// Referenced by: TBCGeneralInfo
/// Toolbar control general information flags that specify which fields in the TBCGeneralInfo structure (section 2.3.1.14) that contains this structure
/// will be saved to the file. The bit description begins from the least significant bit.
public struct TBCGIFlags {
    public let fSaveText: Bool
    public let fSaveMiscUIStrings: Bool
    public let fSaveMiscCustom: Bool
    public let fDisabled: Bool
    public let unused: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fSaveText (1 bit): A bit that specifies whether the toolbar control will save its custom text. A value of 1 specifies that the customText
        /// field of the TBCGeneralInfo structure (section 2.3.1.14) that contains this structure MUST exist. If the value equals 1, the value of the
        /// fSaveUIStrings field of the TBCSFlags structure (section 2.3.1.12) contained by the TBCHeader structure (section 2.3.1.10) contained
        /// by the structure that contains the TBCData structure (section 2.3.1.13) that contains the TBCGeneralInfo structure (section 2.3.1.14) that
        /// contains this structure MUST be 1.
        self.fSaveText = flags.readBit()
        
        /// B - fSaveMiscUIStrings (1 bit): A bit that specifies whether the toolbar control will save its description and ToolTip strings. A value of 1
        /// specifies that the descriptionText and tooltip fields of the TBCGeneralInfo structure that contains this structure MUST exist. If the value
        /// equals 1, the value of the fSaveUIStrings field of the TBCSFlags structure contained by the TBCHeader structure contained by the
        /// structure that contains the TBCData structure that contains the TBCGeneralInfo structure that contains this structure MUST be 1.
        self.fSaveMiscUIStrings = flags.readBit()
        
        /// C - fSaveMiscCustom (1 bit): A bit that specifies whether the toolbar control will save toolbar control extra information. A value of 1
        /// specifies that the extraInfo field of the TBCGeneralInfo structure that contains this structure MUST exist.
        self.fSaveMiscCustom = flags.readBit()
        
        /// D - fDisabled (1 bit): A bit that specifies whether the toolbar control is disabled. A value of 1 specifies that the toolbar control is disabled.
        self.fDisabled = flags.readBit()
        
        /// Unused (4 bits): Undefined and MUST be ignored.
        self.unused = flags.readRemainingBits()
    }
}
