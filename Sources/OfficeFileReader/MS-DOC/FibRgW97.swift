//
//  FibRgW97.swift
//  
//
//  Created by Hugh Bellamy on 05/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.3 FibRgW97
/// The FibRgW97 structure is a variable-length portion of the Fib.
public struct FibRgW97 {
    public let reserved1: UInt16
    public let reserved2: UInt16
    public let reserved3: UInt16
    public let reserved4: UInt16
    public let reserved5: UInt16
    public let reserved6: UInt16
    public let reserved7: UInt16
    public let reserved8: UInt16
    public let reserved9: UInt16
    public let reserved10: UInt16
    public let reserved11: UInt16
    public let reserved12: UInt16
    public let reserved13: UInt16
    public let lidFE: LID

    public init(dataStream: inout DataStream) throws {
        /// reserved1 (2 bytes): This value is undefined and MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved2 (2 bytes): This value is undefined and MUST be ignored.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved3 (2 bytes): This value is undefined and MUST be ignored.
        self.reserved3 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved4 (2 bytes): This value is undefined and MUST be ignored.
        self.reserved4 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved5 (2 bytes): This value SHOULD<17> be zero, and MUST be ignored.
        self.reserved5 = try dataStream.read(endianess: .littleEndian)
    
        /// reserved6 (2 bytes): This value SHOULD<18> be zero, and MUST be ignored.
        self.reserved6 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved7 (2 bytes): This value SHOULD<19> be zero, and MUST be ignored.
        self.reserved7 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved8 (2 bytes): This value SHOULD<20> be zero, and MUST be ignored.
        self.reserved8 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved9 (2 bytes): This value SHOULD<21> be zero, and MUST be ignored.
        self.reserved9 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved10 (2 bytes): This value SHOULD<22> be zero, and MUST be ignored.
        self.reserved10 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved11 (2 bytes): This value SHOULD<23> be zero, and MUST be ignored.
        self.reserved11 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved12 (2 bytes): This value SHOULD<24> be zero, and MUST be ignored.
        self.reserved12 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved13 (2 bytes): This value SHOULD<25> be zero, and MUST be ignored.
        self.reserved13 = try dataStream.read(endianess: .littleEndian)
        
        /// lidFE (2 bytes): A LID whose meaning depends on the nFib value, which is one of the following.
        /// nFib value Meaning
        /// 0x00C1 If FibBase.fFarEast is "true", this is the LID of the stored style names. Otherwise it MUST be ignored.
        /// 0x00D9
        /// 0x0101
        /// 0x010C
        /// 0x0112
        /// The LID of the stored style names (STD.xstzName)
        self.lidFE = try dataStream.read(endianess: .littleEndian)
    }
}
