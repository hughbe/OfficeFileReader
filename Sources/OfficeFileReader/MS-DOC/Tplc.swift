//
//  Tplc.swift
//
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.328 Tplc
/// The Tplc structure is a 32-bit unsigned integer that specifies the format of one level of a bulleted or numbered list.
/// If the first bit (lowest bit) is 1, Tplc specifies an application built-in format, as specified in TplcBuildIn. If the first bit is 0, Tplc specifies a user-defined format,
/// as specified in TplcUser. See SttbRgtplc for more details about how Tplcs are mapped to LVLs inside LSTF.
public enum Tplc {
    case builtIn(data: TplcBuildIn)
    case userDefined(data: TplcUser)
    
    public init(dataStream: inout DataStream) throws {
        var rawValue: BitFieldReader<UInt32> = try dataStream.peekBits(endianess: .littleEndian)
        let builtIn = rawValue.readBit()
        if builtIn {
            self = .builtIn(data: try TplcBuildIn(dataStream: &dataStream))
        } else {
            self = .userDefined(data: try TplcUser(dataStream: &dataStream))
        }
    }
    
    /// [MS-DOC] 2.9.329 TplcBuildIn
    /// The TplcBuildIn structure is a Tplc structure that specifies an application predefined format for the bulleted or numbered list.
    public struct TplcBuildIn {
        public let fBuildIn: Bool
        public let ilgpdM1: UInt16
        public let lid: UInt16
    
        public init(dataStream: inout DataStream) throws {
            var rawValue: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
            
            /// A - fBuildIn (1 bit): This value MUST be 1.
            self.fBuildIn = rawValue.readBit()
            if !self.fBuildIn {
                throw OfficeFileError.corrupted
            }
            
            /// iilgpdM1 (15 bits): An unsigned integer that specifies the predefined bulleted or numbered format and that MUST be one of the values
            /// from the following table. The precise rendering of the bulleted or numbering format is application-dependent.
            /// Value Bullet/numbering format
            /// 0x7FFF (none)
            /// 0x0000
            /// 0x0001
            /// 0x0002
            /// 0x0003
            /// 0x0004
            /// 0x0005
            /// 0x0006
            /// 0x0007
            /// 0x0008
            /// 0x0009
            /// 0x000A
            /// 0x000B
            /// 0x000C
            /// 0x000D
            let ilgpdM1: UInt16 = UInt16(rawValue.readRemainingBits())
            if ilgpdM1 != 0x7FFF && ilgpdM1 > 0x000D {
                throw OfficeFileError.corrupted
            }
            
            self.ilgpdM1 = ilgpdM1
            
            /// lid (2 bytes): A LID that specifies the language identifier for the bullet or number.
            self.lid = try dataStream.read(endianess: .littleEndian)
        }
    }
    
    /// [MS-DOC] 2.9.330 TplcUser
    /// The TplcUser structure is a Tplc value that specifies a user-defined bulleted or numbered format. It MUST correspond to an LSTF structure (see
    /// LSTF.tplc) or it MUST correspond to an individual LVL structure. This LVL structure MUST correspond to an LSTF structure in the PlfLst structure.
    /// The LSTF and LVL structures contain the detailed format specification. See the SttbRgtplc structure for more details about how Tplc values are
    /// mapped to LVL structures inside the LSTF structure.
    public struct TplcUser {
        public let fBuildIn: Bool
        public let wRandom: UInt32
        
        public init(dataStream: inout DataStream) throws {
            var rawValue: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
            
            /// A - fBuildIn (1 bit): This value MUST be 0.
            self.fBuildIn = rawValue.readBit()
            if self.fBuildIn {
                throw OfficeFileError.corrupted
            }
            
            /// wRandom (31 bits): An unsigned random integer assigned by the application. Any unsigned integer is valid as long as it is unique for
            /// each user-defined bulleted or numbered format.
            self.wRandom = rawValue.readRemainingBits()
        }
    }
}
