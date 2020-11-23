//
//  GRFSTD.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.112 GRFSTD
/// The GRFSTD structure specifies the general properties of a style.
public struct GRFSTD {
    public let fAutoRedef: Bool
    public let fHidden: Bool
    public let f97LidsSet: Bool
    public let fCopyLang: Bool
    public let fPersonalCompose: Bool
    public let fPersonalReply: Bool
    public let fPersonal: Bool
    public let fNoHtmlExport: Bool
    public let fSemiHidden: Bool
    public let fLocked: Bool
    public let fInternalUse: Bool
    public let fUnhideWhenUsed: Bool
    public let fQFormat: Bool
    public let fReserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var rawValue: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fAutoRedef (1 bit): Specifies whether user formatting modifications are automatically merged into the paragraph style definition,
        /// as specified in [ECMA-376] part 4, section 2.7.3.2 (autoRedefine).
        self.fAutoRedef = rawValue.readBit()
        
        /// B - fHidden (1 bit): Specifies whether this style is not shown in the application UI, as specified in [ECMA-376] part 4, section
        /// 2.7.3.4 (hidden).
        self.fHidden = rawValue.readBit()
        
        /// C - f97LidsSet (1 bit): Specifies whether sprmCRgLid0_80 and sprmCRgLid1_80 were applied, as appropriate, to this paragraph
        /// or character style for compatibility with applications that do not support sprmCRgLid0, sprmCRgLid1, and sprmCFNoProof. If
        /// this value is 1, the compatibility Sprms have already been applied for this style. If this value is 0, the compatibility Sprms need to
        /// be applied to the formatting properties of the current style or a base style. This value SHOULD<225> be 0.
        self.f97LidsSet = rawValue.readBit()
        
        /// D - fCopyLang (1 bit): If f97LidsSet is 1, this value specifies whether the applied compatibility sprmCRgLid0_80 or sprmCRgLid1_80
        /// specified an actual language or a special LID value (0x0400) signifying that no proofing is needed for the text. This MUST be ignored
        /// if f97LidsSet is 0.
        self.fCopyLang = rawValue.readBit()
        
        /// E - fPersonalCompose (1 bit): Specifies whether this character style can be used to automatically format the new message text in
        /// a new e-mail, as specified in [ECMA-376] part 4, section 2.7.3.12 (personalCompose). This MUST be ignored if this is not a
        /// character style.
        self.fPersonalCompose = rawValue.readBit()
        
        /// F - fPersonalReply (1 bit): Specifies whether this character style can be used to automatically format the new message text when
        /// replying to an e-mail, as specified in [ECMA-376] part 4, section 2.7.3.13 (personalReply). This MUST be ignored if this is not a
        /// character style.
        self.fPersonalReply = rawValue.readBit()

        /// G - fPersonal (1 bit): Specifies whether this character style was applied to format all message text from one or more users in an
        /// e-mail, as specified in [ECMA-376] part 4, section 2.7.3.11 (personal). This MUST be ignored if this is not a character style.
        self.fPersonal = rawValue.readBit()
        
        /// H - fNoHtmlExport (1 bit): This value MUST be 0 and MUST be ignored.
        self.fNoHtmlExport = rawValue.readBit()
        
        /// I - fSemiHidden (1 bit): Specifies whether this style is not shown in the simplified main styles UI of the application, as specified in
        /// [ECMA-376] part 4, section 2.7.3.16 (semiHidden).
        self.fSemiHidden = rawValue.readBit()
        
        /// J - fLocked (1 bit): Specifies whether this style is prevented from being applied by using the application UI, as specified in
        /// [ECMA-376] part 4, section 2.7.3.7 (locked).
        self.fLocked = rawValue.readBit()
        
        /// K - fInternalUse (1 bit): This bit is undefined and MUST be ignored.
        self.fInternalUse = rawValue.readBit()
        
        /// L - fUnhideWhenUsed (1 bit): Specifies whether the fSemiHidden property is to be set to 0 when this style is used, as specified in
        /// [ECMA-376] part 4, section 2.7.3.20 (unhideWhenUsed).
        self.fUnhideWhenUsed = rawValue.readBit()
        
        /// M - fQFormat (1 bit): Specifies whether this style is shown in the Ribbon Style gallery, as specified in [ECMA-376] part 4, section
        /// 2.7.3.14 (qFormat).
        self.fQFormat = rawValue.readBit()
        
        /// N - fReserved (3 bits): This value MUST be 0 and MUST be ignored.
        self.fReserved = UInt8(rawValue.readRemainingBits())
    }
}
