//
//  WKB.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.346 WKB
/// The WKB structure describes a subdocument.
public struct WKB {
    public let fn: UInt16
    public let fReserved1: Bool
    public let fReserved2: Bool
    public let fReserved3: Bool
    public let fReserved4: Bool
    public let fReserved5: Bool
    public let fReserved6: Bool
    public let fReserved7: Bool
    public let fReserved8: Bool
    public let fReserved9: UInt16
    public let lvl: UInt16
    public let fnpi: FNPI
    public let pdod: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// fn (2 bytes): This value MUST be zero.
        self.fn = try dataStream.read(endianess: .littleEndian)
        if self.fn != 0 {
            throw OfficeFileError.corrupted
        }
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fReserved1 (1 bit): This value MUST be zero.
        self.fReserved1 = flags.readBit()
        if self.fReserved1 {
            throw OfficeFileError.corrupted
        }
        
        /// B - fReserved2 (1 bit): This value MUST be zero.
        self.fReserved2 = flags.readBit()
        if self.fReserved2 {
            throw OfficeFileError.corrupted
        }

        /// C - fReserved3 (1 bit): This value is undefined and MUST be ignored.
        self.fReserved3 = flags.readBit()
        
        /// D - fReserved4 (1 bit): This value MUST be zero.
        self.fReserved4 = flags.readBit()
        if self.fReserved4 {
            throw OfficeFileError.corrupted
        }
        
        /// E - fReserved5 (1 bit): This value MUST be zero.
        self.fReserved5 = flags.readBit()
        if self.fReserved5 {
            throw OfficeFileError.corrupted
        }

        /// F - fReserved6 (1 bit): This value MUST be 1.
        self.fReserved6 = flags.readBit()
        if !self.fReserved6 {
            throw OfficeFileError.corrupted
        }

        /// G - fReserved7 (1 bit): This value MUST be zero.
        self.fReserved7 = flags.readBit()
        if self.fReserved7 {
            throw OfficeFileError.corrupted
        }

        /// H - fReserved8 (1 bit): This value is undefined and MUST be ignored.
        self.fReserved8 = flags.readBit()
        
        /// fReserved9 (1 byte): This value MUST be zero.
        self.fReserved9 = try dataStream.read()
        if self.fReserved9 != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// lvl (2 bytes): This value MUST be 0x0002.
        self.lvl = try dataStream.read(endianess: .littleEndian)
        if self.lvl != 0x0002 {
            throw OfficeFileError.corrupted
        }
        
        /// fnpi (2 bytes): An FNPI structure that specifies the type and identifier of a file name. The string that is contained in the SttbFnm
        /// structure and that is appended by an FNIF structure that has an fnpi which is identical to this one, is the file name of the file that this
        /// WKB references.
        self.fnpi = try FNPI(dataStream: &dataStream)
        
        /// pdod (4 bytes): This value is unused and MUST be zero.
        self.pdod = try dataStream.read(endianess: .littleEndian)
    }
}
