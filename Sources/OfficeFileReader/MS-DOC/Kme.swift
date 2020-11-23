//
//  Kme.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.125 Kme
/// The Kme structure specifies a mapping of a shortcut key to a command to be executed.
public struct Kme {
    public let reserved1: UInt16
    public let reserved2: UInt16
    public let kcm1: Kcm
    public let kcm2: Kcm
    public let kt: Kt
    public let param: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// reserved1 (2 bytes): This value MUST be zero.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        if self.reserved1 != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved2 (2 bytes): This value MUST be zero.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
        if self.reserved2 != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// kcm1 (2 bytes): A Kcm that specifies the primary shortcut key.
        self.kcm1 = try Kcm(dataStream: &dataStream)
        
        /// kcm2 (2 bytes): A Kcm that specifies the secondary shortcut key, or 0x00FF if there is no secondary shortcut key.
        self.kcm2 = try Kcm(dataStream: &dataStream)
        
        /// kt (2 bytes): A Kt that specifies the type of action to be taken when the key combination is pressed.
        let ktRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let kt = Kt(rawValue: ktRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.kt = kt
        
        /// param (4 bytes): The meaning of this field depends on the value of kt, as follows.
        /// kt param
        /// ktCid A Cid that specifies a command to be executed.
        /// ktChar A 4-byte unsigned integer that specifies a single character to be inserted. This value MUST be between 0 and 65535.
        /// ktMask This MUST be ignored.
        self.param = try dataStream.read(endianess: .littleEndian)
    }
}
