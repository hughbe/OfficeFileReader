//
//  PLRSID.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.203 PLRSID
/// The PLRSID structure is an array of revision-save identifiers (RSIDs), as specified in [ECMA-376] part 4, section 2.15.1.70.
public struct PLRSID {
    public let irsidMac: UInt32
    public let cbRsidInFile: UInt32
    public let cbHeadExtraInFile: UInt32
    public let reserved1: UInt32
    public let reserved2: UInt32
    public let reserved3: UInt32
    public let rgrsid: [RSID]
    
    public init(dataStream: inout DataStream) throws {
        /// irsidMac (4 bytes): An unsigned integer value that specifies the count of RSIDs that are contained in rgrsid.
        self.irsidMac = try dataStream.read(endianess: .littleEndian)
        
        /// cbRsidInFile (4 bytes): An unsigned integer value that specifies the size, in bytes, of an RSID. This value MUST be 4.
        self.cbRsidInFile = try dataStream.read(endianess: .littleEndian)
        if self.cbRsidInFile != 4 {
            throw OfficeFileError.corrupted
        }
        
        /// cbHeadExtraInFile (4 bytes): An unsigned integer value that MUST be 8.
        self.cbHeadExtraInFile = try dataStream.read(endianess: .littleEndian)
        if self.cbHeadExtraInFile != 8 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved1 (4 bytes): An unsigned integer value that MUST be 229.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        if self.reserved1 != 229 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved2 (4 bytes): An unsigned integer value that MUST be less than "32". This value MUST be ignored.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved3 (4 bytes): This value is undefined and MUST be ignored.
        self.reserved3 = try dataStream.read(endianess: .littleEndian)
        
        /// rgrsid (variable): An array of RSID elements.
        var rgrsid: [RSID] = []
        rgrsid.reserveCapacity(Int(self.irsidMac))
        for _ in 0..<self.irsidMac {
            rgrsid.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.rgrsid = rgrsid
    }
}
