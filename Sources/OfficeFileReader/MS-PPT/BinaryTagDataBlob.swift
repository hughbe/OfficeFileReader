//
//  BinaryTagDataBlob.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.34 BinaryTagDataBlob
/// Referenced by: UnknownBinaryTag
/// An atom record that contains the value of the name-value pair in a programmable tag.
public struct BinaryTagDataBlob {
    public let rh: RecordHeader
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_BinaryTagDataBlob.
        let rh: RecordHeader = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        if rh.recInstance != 0x000 {
            throw OfficeFileError.corrupted
        }
        if rh.recType != .binaryTagDataBlob {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// data (variable): An array of bytes that specifies the data of this item. The size, in bytes, of the data is specified by rh.recLen.
        self.data = try dataStream.readBytes(count: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
