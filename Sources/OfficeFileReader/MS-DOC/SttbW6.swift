//
//  SttbW6.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.297 SttbW6
/// The SttbW6 structure specifies the count of TrueType fonts that are embedded in the document.
public struct SttbW6 {
    public let unused1: UInt16
    public let ibstMac: Int16
    public let ibstMax: Int16
    public let unused2: Int16
    public let brgbst: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// unused1 (2 bytes): This value MUST be 0 and MUST be ignored.
        self.unused1 = try dataStream.read(endianess: .littleEndian)
        
        /// ibstMac (2 bytes): A signed integer that specifies the count of Ttmbd in SttbTtmbd.rgTTMBD (the number of TrueType fonts embedded in the
        /// document). This value MUST be nonnegative and MUST NOT exceed 64.
        let ibstMac: Int16 = try dataStream.read(endianess: .littleEndian)
        if ibstMac < 0 || ibstMac > 64 {
            throw OfficeFileError.corrupted
        }
        
        self.ibstMac = ibstMac
        
        /// ibstMax (2 bytes): A signed integer that specifies the maximum number of embedded TrueType fonts that are supported by the document. This
        /// value MUST be 64.
        self.ibstMax = try dataStream.read(endianess: .littleEndian)
        if self.ibstMax != 64 {
            throw OfficeFileError.corrupted
        }
        
        /// unused2 (2 bytes): This value MUST be 0 and MUST be ignored.
        self.unused2 = try dataStream.read(endianess: .littleEndian)
        
        /// brgbst (2 bytes): An unsigned integer that specifies the offset from the location of the SttbW6 structure where SttbTtmbd.rgTTMBD begins. This
        /// value SHOULD<248> be 10 (the size of the SttbW6 structure).
        self.brgbst = try dataStream.read(endianess: .littleEndian)
    }
}
