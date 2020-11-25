//
//  PROJECTDOCSTRING.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1.6 PROJECTDOCSTRING Record
/// Specifies the description for the VBA project.
public struct PROJECTDOCSTRING {
    public let id: UInt16
    public let sizeOfDocString: UInt32
    public let docString: String
    public let reserved: UInt16
    public let sizeOfDocStringUnicode: UInt32
    public let docStringUnicode: String
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0005.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0005 else {
            throw OfficeFileError.corrupted
        }
        
        /// SizeOfDocString (4 bytes): An unsigned integer that specifies the size in bytes of DocString. MUST be less than or equal to 2000.
        self.sizeOfDocString = try dataStream.read(endianess: .littleEndian)
        guard self.sizeOfDocString <= 2000 else {
            throw OfficeFileError.corrupted
        }
        
        /// DocString (variable): An array of SizeOfDocString bytes that specifies the description for the VBA project. MUST contain MBCS characters
        /// encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4). MUST NOT contain null characters.
        self.docString = try dataStream.readString(count: Int(self.sizeOfDocString), encoding: .ascii)!
        
        /// Reserved (2 bytes): MUST be 0x0040. MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        /// SizeOfDocStringUnicode (4 bytes): An unsigned integer that specifies the size in bytes of DocStringUnicode. MUST be even.
        self.sizeOfDocStringUnicode = try dataStream.read(endianess: .littleEndian)
        guard (self.sizeOfDocStringUnicode % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        /// DocStringUnicode (variable): An array of SizeOfDocStringUnicode bytes that specifies the description for the VBA project. MUST contain
        /// UTF-16 characters. MUST NOT contain null characters. MUST contain the UTF-16 encoding of DocString.
        self.docStringUnicode = try dataStream.readString(count: Int(self.sizeOfDocStringUnicode), encoding: .utf16LittleEndian)!
    }
}
