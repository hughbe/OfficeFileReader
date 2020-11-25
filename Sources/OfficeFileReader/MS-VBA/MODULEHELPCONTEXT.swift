//
//  MODULEHELPCONTEXT.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.3.2.6 MODULEHELPCONTEXT Record
/// Specifies the Help topic identifier for the containing MODULE Record (section 2.3.4.2.3.2).
public struct MODULEHELPCONTEXT {
    public let id: UInt16
    public let size: UInt32
    public let helpContext: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x001E.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x001E else {
            throw OfficeFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the size of HelpContext. MUST be 0x00000004.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.size == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        /// HelpContext (4 bytes): An unsigned integer that specifies the Help topic identifier in the Help file specified by PROJECTHELPFILEPATH
        /// Record (section 2.3.4.2.1.7).
        self.helpContext = try dataStream.read(endianess: .littleEndian)
    }
}
