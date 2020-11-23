//
//  TBCBSFlags.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.3.1.18 TBCBSFlags
/// Referenced by: TBCBSpecific
/// Contains flags for Button and ExpandingGrid type toolbar controls. The bit description begins from the least significant bit.
public struct TBCBSFlags {
    public let state: State
    public let fAccelerator: Bool
    public let fCustomBitmap: Bool
    public let fCustomBtnFace: Bool
    public let fHyperlinkType: HyperlinkType
    public let reserved1: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - state (2 bits): Unsigned integer that specifies the toolbar control state. The value MUST be in the following table.
        let stateRaw = flags.readBits(count: 2)
        guard let state = State(rawValue: stateRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.state = state
        
        /// B - fAccelerator (1 bit): A bit that specifies whether the wstrAcc field of the TBCBSpecific structure (section 2.3.1.17) that contains
        /// this structure has been saved to the file. A value of 1 specifies that the wstrAcc field of the TBCBSpecific structure (section 2.3.1.17)
        /// that contains this structure MUST exist. If the value equals 1, the value of the fSaveUIStrings field of the TBCSFlags structure (section
        /// 2.3.1.12) contained by the TBCHeader structure (section 2.3.1.10) contained by the structure that contains the TBCData structure
        /// (section 2.3.1.13) that contains the TBCBSpecific structure (section 2.3.1.17) that contains this structure MUST be 1.
        self.fAccelerator = flags.readBit()
        
        /// C - fCustomBitmap (1 bit): A bit that specifies whether the toolbar control has a custom icon. A value of 1 specifies that the icon and
        /// iconMask fields of the TBCBSpecific structure that contains this structure MUST exist.
        self.fCustomBitmap = flags.readBit()
        
        /// D - fCustomBtnFace (1 bit): A bit that specifies whether the toolbar control is using an alternate icon as its own. A value of 1 specifies
        /// that the iBtnFace field of the TBCBSpecific structure that contains this structure MUST exist.
        self.fCustomBtnFace = flags.readBit()
        
        /// E - fHyperlinkType (2 bits): Unsigned integer that specifies the type of hyperlink associated with this toolbar control. The value MUST
        /// be in the following table.
        let fHyperlinkTypeRaw = flags.readBits(count: 2)
        guard let fHyperlinkType = HyperlinkType(rawValue: fHyperlinkTypeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.fHyperlinkType = fHyperlinkType
        
        /// F - reserved1 (1 bit): Reserved bit. SHOULD<9> be 1.
        self.reserved1 = flags.readBit()
    }
    
    /// A - state (2 bits): Unsigned integer that specifies the toolbar control state. The value MUST be in the following table.
    public enum State: UInt8 {
        /// 0x00 (00) Button is up.
        case up = 0x00
        
        /// 0x01 (01) Button is down (pushed).
        case down = 0x01
        
        /// 0x03 (11) Button is in mixed state.
        case mixed = 0x03
    }
    
    /// E - fHyperlinkType (2 bits): Unsigned integer that specifies the type of hyperlink associated with this toolbar control. The value MUST
    /// be in the following table.
    public enum HyperlinkType: UInt8 {
        /// 0x00 (00) No hyperlink. This toolbar control does not have a hyperlink.
        case none = 0x00
        
        /// 0x01 (01) Open in browser. The hyperlink will be opened in the default browser.
        case openInBrowser = 0x01
        
        /// 0x02 (10) Image link. The hyperlink links to an image file.
        case imageLink = 0x02
    }
}
