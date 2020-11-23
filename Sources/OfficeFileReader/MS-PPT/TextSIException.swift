//
//  TextSIException.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.32 TextSIException
/// Referenced by: StyleTextProp11, StyleTextProp9, TextSIExceptionAtom, TextSIRun
/// A structure that specifies additional text properties.
public struct TextSIException {
    public let spell: Bool
    public let lang: Bool
    public let altLang: Bool
    public let unused1: Bool
    public let unused2: Bool
    public let fPp10ext: Bool
    public let fBidi: Bool
    public let unused3: Bool
    public let reserved1: Bool
    public let smartTag: Bool
    public let reserved2: UInt32
    public let spellInfo: SpellingFlags?
    public let lid: TxLCID?
    public let altLid: TxLCID?
    public let bidi: UInt32?
    public let pp10runid: UInt8?
    public let reserved3: UInt32?
    public let grammarError: Bool?
    public let smartTags: SmartTags?
    
    public init(dataStream: inout DataStream) throws {
        var flags1: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - spell (1 bit): A bit that specifies whether the spellInfo field exists.
        self.spell = flags1.readBit()
        
        /// B - lang (1 bit): A bit that specifies whether the lid field exists.
        self.lang = flags1.readBit()
        
        /// C - altLang (1 bit): A bit that specifies whether the altLid field exists.
        self.altLang = flags1.readBit()
        
        /// D - unused1 (1 bit): Undefined and MUST be ignored.
        self.unused1 = flags1.readBit()
        
        /// E - unused2 (1 bit): Undefined and MUST be ignored.
        self.unused2 = flags1.readBit()
        
        /// F - fPp10ext (1 bit): A bit that specifies whether the pp10runid, reserved3, and grammarError fields exist.
        self.fPp10ext = flags1.readBit()
        
        /// G - fBidi (1 bit): A bit that specifies whether the bidi field exists.
        self.fBidi = flags1.readBit()
        
        /// H - unused3 (1 bit): Undefined and MUST be ignored.
        self.unused3 = flags1.readBit()
        
        /// I - reserved1 (1 bit): MUST be zero and MUST be ignored.
        self.reserved1 = flags1.readBit()
        
        /// J - smartTag (1 bit): A bit that specifies whether the smartTags field exists.
        self.smartTag = flags1.readBit()
        
        /// reserved2 (22 bits): MUST be zero and MUST be ignored.
        self.reserved2 = flags1.readRemainingBits()
        
        /// spellInfo (2 bytes): An optional SpellingFlags structure that specifies the spelling status of this text. It MUST exist if and only if spell is TRUE.
        /// The spellInfo.grammar sub-field MUST be zero.
        if self.spell {
            self.spellInfo = try SpellingFlags(dataStream: &dataStream)
        } else {
            self.spellInfo = nil
        }
        
        /// lid (2 bytes): An optional TxLCID that specifies the language identifier of this text. It MUST exist if and only if lang is TRUE.
        if self.lang {
            self.lid = try TxLCID(dataStream: &dataStream)
        } else {
            self.lid = nil
        }
        
        /// altLid (2 bytes): An optional TxLCID that specifies the alternate language identifier of this text. It MUST exist if and only if altLang is TRUE.
        if self.altLang {
            self.altLid = try TxLCID(dataStream: &dataStream)
        } else {
            self.altLid = nil
        }
        
        /// bidi (2 bytes): An optional signed integer that specifies whether the text contains bidirectional characters. It MUST exist if and only if fBidi is TRUE.
        /// It MUST be a value from the following table:
        /// Value Meaning
        /// 0x0000 Contains no bidirectional characters.
        /// 0x0001 Contains bidirectional characters.
        if self.fBidi {
            self.bidi = try dataStream.read(endianess: .littleEndian)
        } else {
            self.bidi = nil
        }
        
        if self.fPp10ext {
            var flags2: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
            
            /// K - pp10runid (4 bits): An optional unsigned integer that specifies an identifier for a character run that contains StyleTextProp11 data. It MUST
            /// exist if and only if fPp10ext is TRUE.
            self.pp10runid = UInt8(flags2.readBits(count: 4))
            
            /// reserved3 (27 bits): An optional unsigned integer that MUST be zero, and MUST be ignored. It MUST exist if and only if fPp10ext is TRUE.
            self.reserved3 = flags2.readBits(count: 27)
            
            /// L - grammarError (1 bit): An optional bit that specifies a grammar error. It MUST exist if and only if fPp10ext is TRUE.
            self.grammarError = flags2.readBit()
        } else {
            self.pp10runid = nil
            self.reserved3 = nil
            self.grammarError = nil
        }
        
        /// smartTags (variable): An optional SmartTags structure that specifies smart tags applied to the text. It MUST exist if and only if smartTag is TRUE.
        if self.smartTag {
            self.smartTags = try SmartTags(dataStream: &dataStream)
        } else {
            self.smartTags = nil
        }
    }
}
