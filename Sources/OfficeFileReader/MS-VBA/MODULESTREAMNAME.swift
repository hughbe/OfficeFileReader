//
//  MODULESTREAMNAME.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.3.2.3 MODULESTREAMNAME Record
/// Specifies the stream name of the ModuleStream (section 2.3.4.3) in the VBA Storage (section 2.3.4) corresponding to the containing MODULE
/// Record (section 2.3.4.2.3.2).
public struct MODULESTREAMNAME {
    public let id: UInt16
    public let sizeOfStreamName: UInt32
    public let streamName: String
    public let reserved: UInt16
    public let sizeOfStreamNameUnicode: UInt32
    public let streamNameUnicode: String
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x001A.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x001A else {
            throw OfficeFileError.corrupted
        }
        
        /// SizeOfStreamName (4 bytes): An unsigned integer that specifies the size in bytes of StreamName.
        self.sizeOfStreamName = try dataStream.read(endianess: .littleEndian)
        
        /// StreamName (variable): An array of SizeOfStreamName bytes that specifies the stream name of the ModuleStream (section 2.3.4.3).
        /// MUST contain MBCS characters encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4). MUST NOT
        /// contain null characters.
        self.streamName = try dataStream.readString(count: Int(self.sizeOfStreamName), encoding: .ascii)!
        
        /// Reserved (2 bytes): MUST be 0x0032. MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        /// SizeOfStreamNameUnicode (4 bytes): An unsigned integer that specifies the size in bytes of StreamNameUnicode. MUST be even.
        self.sizeOfStreamNameUnicode = try dataStream.read(endianess: .littleEndian)
        guard (self.sizeOfStreamNameUnicode % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        /// StreamNameUnicode (variable): An array of SizeOfStreamNameUnicode bytes that specifies the stream name of the ModuleStream
        /// (section 2.3.4.3). MUST contain UTF-16 characters. MUST NOT contain null characters. MUST contain the UTF-16 encoding of StreamName.
        self.streamNameUnicode = try dataStream.readString(count: Int(self.sizeOfStreamNameUnicode), encoding: .ascii)!
    }
}

