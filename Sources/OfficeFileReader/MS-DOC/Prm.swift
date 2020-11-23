//
//  Prm.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.214 Prm
/// A Prm structure is either a Prm0 structure or a Prm1 structure, depending on the value of the fComplex bit.
public enum Prm {
    case simple(data: Prm0)
    case complex(data: Prm1)
    
    public init(dataStream: inout DataStream) throws {
        /// A - fComplex (1 bit): If fComplex is 1, this Prm is a Prm1 structure. If fComplex is zero, this Prm is a Prm0 structure.
        var rawValue: BitFieldReader<UInt16> = try dataStream.peekBits(endianess: .littleEndian)
        let fComplex = rawValue.readBit()
        if !fComplex {
            self = .simple(data: try Prm0(dataStream: &dataStream))
        } else {
            self = .complex(data: try Prm1(dataStream: &dataStream))
        }
    }
    
    /// [MS-DOC] 2.9.215 Prm0
    /// The Prm0 structure is a Prm that has an fComplex value of zero. It specifies a single Sprm and operand to apply to all document
    /// content that is referenced by a Pcd.
    public struct Prm0 {
        public let fComplex: Bool
        public let isprm: UInt8
        public let val: UInt8
        
        private static let dictionary: [UInt8: Sprm] = [
            0x00: .sprmCLbcCRJ,
            0x04: .sprmPIncLvl,
            0x05: .sprmPJc,
            0x07: .sprmPFKeep,
            0x08: .sprmPFKeepFollow,
            0x09: .sprmPFPageBreakBefore,
            0x0C: .sprmPIlvl,
            0x0D: .sprmPFMirrorIndents,
            0x0E: .sprmPFNoLineNumb,
            0x0F: .sprmPTtwo,
            0x18: .sprmPFInTable,
            0x19: .sprmPFTtp,
            0x1D: .sprmPPc,
            0x25: .sprmPWr,
            0x2C: .sprmPFNoAutoHyph,
            0x32: .sprmPFLocked,
            0x33: .sprmPFWidowControl,
            0x35: .sprmPFKinsoku,
            0x36: .sprmPFWordWrap,
            0x37: .sprmPFOverflowPunct,
            0x38: .sprmPFTopLinePunct,
            0x39: .sprmPFAutoSpaceDE,
            0x3A: .sprmPFAutoSpaceDN,
            0x41: .sprmCFRMarkDel,
            0x42: .sprmCFRMarkIns,
            0x43: .sprmCFFldVanish,
            0x47: .sprmCFData,
            0x4B: .sprmCFOle2,
            0x4D: .sprmCHighlight,
            0x4E: .sprmCFEmboss,
            0x4F: .sprmCSfxText,
            0x50: .sprmCFWebHidden,
            0x51: .sprmCFSpecVanish,
            0x53: .sprmCPlain,
            0x55: .sprmCFBold,
            0x56: .sprmCFItalic,
            0x57: .sprmCFStrike,
            0x58: .sprmCFOutline,
            0x59: .sprmCFShadow,
            0x5A: .sprmCFSmallCaps,
            0x5B: .sprmCFCaps,
            0x5C: .sprmCFVanish,
            0x5E: .sprmCKul,
            0x62: .sprmCIco,
            0x68: .sprmCIss,
            0x73: .sprmCFDStrike,
            0x74: .sprmCFImprint,
            0x75: .sprmCFSpec,
            0x76: .sprmCFObj,
            0x78: .sprmPOutLvl,
            0x7B: .sprmCFSdtVanish,
            0x7C: .sprmCNeedFontFixup,
            0x7E: .sprmPFNumRMIns,
        ]
        
        public var sprm: Sprm? {
            return Prm0.dictionary[isprm]
        }
        
        public init(dataStream: inout DataStream) throws {
            var rawValue: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
            
            /// A - fComplex (1 bit): This value MUST be 0.
            self.fComplex = rawValue.readBit()
            if self.fComplex {
                throw OfficeFileError.corrupted
            }
            
            /// isprm (7 bits): An unsigned integer that specifies the Sprm to apply, according to the following table. The operand is specified
            /// by val.
            /// Isprm Sprm
            /// 0x00 sprmCLbcCRJ. If val is also zero, this Prm0 does not apply sprmCLbcCRJ with an operand of zero; instead, it has no effect.
            /// 0x04 sprmPIncLvl
            /// 0x05 sprmPJc
            /// 0x07 sprmPFKeep
            /// 0x08 sprmPFKeepFollow
            /// 0x09 sprmPFPageBreakBefore
            /// 0x0C sprmPIlvl
            /// 0x0D sprmPFMirrorIndents
            /// 0x0E sprmPFNoLineNumb
            /// 0x0F sprmPTtwo
            /// 0x18 sprmPFInTable
            /// 0x19 sprmPFTtp
            /// 0x1D sprmPPc
            /// 0x25 sprmPWr
            /// 0x2C sprmPFNoAutoHyph
            /// 0x32 sprmPFLocked
            /// 0x33 sprmPFWidowControl
            /// 0x35 sprmPFKinsoku
            /// 0x36 sprmPFWordWrap
            /// 0x37 sprmPFOverflowPunct
            /// 0x38 sprmPFTopLinePunct
            /// 0x39 sprmPFAutoSpaceDE
            /// 0x3A sprmPFAutoSpaceDN
            /// 0x41 sprmCFRMarkDel
            /// 0x42 sprmCFRMarkIns
            /// 0x43 sprmCFFldVanish
            /// 0x47 sprmCFData
            /// 0x4B sprmCFOle2
            /// 0x4D sprmCHighlight
            /// 0x4E sprmCFEmboss
            /// 0x4F sprmCSfxText
            /// 0x50 sprmCFWebHidden
            /// 0x51 sprmCFSpecVanish
            /// 0x53 sprmCPlain
            /// 0x55 sprmCFBold
            /// 0x56 sprmCFItalic
            /// 0x57 sprmCFStrike
            /// 0x58 sprmCFOutline
            /// 0x59 sprmCFShadow
            /// 0x5A sprmCFSmallCaps
            /// 0x5B sprmCFCaps
            /// 0x5C sprmCFVanish
            /// 0x5E sprmCKul
            /// 0x62 sprmCIco
            /// 0x68 sprmCIss
            /// 0x73 sprmCFDStrike
            /// 0x74 sprmCFImprint
            /// 0x75 sprmCFSpec
            /// 0x76 sprmCFObj
            /// 0x78 sprmPOutLvl
            /// 0x7B sprmCFSdtVanish
            /// 0x7C sprmCNeedFontFixup
            /// 0x7E sprmPFNumRMIns
            self.isprm = UInt8(rawValue.readBits(count: 7))
            
            /// val (8 bits): The operand for the Sprm that is specified by isprm.
            self.val = UInt8(rawValue.readBits(count: 8))
        }
    }
    
    /// [MS-DOC] 2.9.216 Prm1
    /// The Prm1 structure is a Prm with an fComplex value of 1. It specifies properties for document content that is referenced by a Pcd.
    public struct Prm1 {
        public let fComplex: Bool
        public let igrpprl: UInt16
        
        public init(dataStream: inout DataStream) throws {
            var rawValue: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
            
            /// A - fComplex (1 bit): This value MUST be 1.
            self.fComplex = rawValue.readBit()
            if !self.fComplex {
                throw OfficeFileError.corrupted
            }
            
            /// igrpprl (15 bits): An unsigned integer that specifies a zero-based index of a Prc in Clx.RgPrc. This value MUST be less than
            /// the number of Prc elements in Clx.RgPrc.
            self.igrpprl = rawValue.readRemainingBits()
        }
    }
}
