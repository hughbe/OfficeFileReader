//
//  PGPInfo.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.188 PGPInfo
/// The PGPInfo structure describes the border and margin properties that can be applied to a contiguous range of paragraphs.
public struct PGPInfo {
    public let ipgpSelf: UInt32
    public let ipgpParent: UInt32
    public let itap: UInt32
    public let grfElements: Elements
    public let pgpOptions: PGPOptions
    
    public init(dataStream: inout DataStream) throws {
        /// ipgpSelf (4 bytes): A unique 4-byte value that is used to identify this entry. This value MUST NOT be 0.
        self.ipgpSelf = try dataStream.read(endianess: .littleEndian)
        if self.ipgpSelf == 0 {
            throw OfficeFileError.corrupted
        }
        
        /// ipgpParent (4 bytes): This is the identifier of the immediate parent PGPInfo structure. A value of 0 indicates that there is no parent and that,
        /// therefore, this is an outermost PGPInfo.
        self.ipgpParent = try dataStream.read(endianess: .littleEndian)
        
        /// itap (4 bytes): The table depth to which this PGPInfo structure is applied. PGPInfo structures can be applied to paragraphs that are within a
        /// table cell.
        self.itap = try dataStream.read(endianess: .littleEndian)
        
        /// grfElements (2 bytes): A bit field that describes how to read in the variable length pgpOptions.
        /// The meanings of the bits are as follows.
        self.grfElements = Elements(rawValue: try dataStream.read(endianess: .littleEndian))
        
        /// pgpOptions (variable): A PGPOptions structure that describes all the relevant paragraph properties that are different than the defaults.
        self.pgpOptions = try PGPOptions(dataStream: &dataStream, grfElements: grfElements)
    }
    
    public struct Elements: OptionSet {
        public let rawValue: UInt16
        
        public init(rawValue: UInt16) {
            self.rawValue = rawValue
        }
        
        /// 0x0001 PGPOptions.dxaLeft is present.
        public static let dxaLeftPresent = Elements(rawValue: 0x0001)
        
        /// 0x0002 PGPOptions.dxaRight is present.
        public static let dxaRightPresent = Elements(rawValue: 0x0002)
        
        /// 0x0004 PGPOptions.dyaBefore is present.
        public static let dyaBeforePresent = Elements(rawValue: 0x0004)
        
        /// 0x0008 PGPOptions.dyaAfter is present.
        public static let dyaAfterPresent = Elements(rawValue: 0x0008)
        
        /// 0x0010 PGPOptions.brcLeft is present.
        public static let brcLeftPresent = Elements(rawValue: 0x0010)
        
        /// 0x0020 PGPOptions.brcRight is present.
        public static let brcRightPresent = Elements(rawValue: 0x0020)
        
        /// 0x0040 PGPOptions.brcTop is present.
        public static let brcTopPresent = Elements(rawValue: 0x0040)
        
        /// 0x0080 PGPOptions.brcBottom is present.
        public static let brcBottomPresent = Elements(rawValue: 0x0080)
        
        /// 0x0100 PGPOptions.type is present.
        public static let typePresent = Elements(rawValue: 0x0100)
        
        public static let all: Elements = [
            .dxaLeftPresent,
            .dxaRightPresent,
            .dyaBeforePresent,
            .dyaAfterPresent,
            .brcLeftPresent,
            .brcRightPresent,
            .brcTopPresent,
            .brcBottomPresent,
            .typePresent
        ]
    }
}
