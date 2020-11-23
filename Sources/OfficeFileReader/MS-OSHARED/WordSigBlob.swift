//
//  WordSigBlob.swift
//  
//
//  Created by Hugh Bellamy on 10/11/2020.
//

import DataStream

/// [MS-DOC] 2.3.2.3 WordSigBlob
/// Specifies the layout of the VBA digital signature data when it is wrapped as a length-prefixed Unicode character string.
public struct WordSigBlob {
    public let cch: UInt16
    public let cbSigInfo: UInt32
    public let serializedPointer: UInt32
    public let signatureInfo: DigSigInfoSerialized
    
    public init(dataStream: inout DataStream) throws {
        /// cch (2 bytes): An unsigned integer that specifies half the count of bytes of the remainder of the structure. MUST be the value given
        /// by the following formula. cch = (cbSigInfo + (cbSigInfo mod 2) + 8) / 2
        self.cch = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// cbSigInfo (4 bytes): An unsigned integer that specifies the size of the signatureInfo field in bytes.
        self.cbSigInfo = try dataStream.read(endianess: .littleEndian)
        
        /// serializedPointer (4 bytes): An unsigned integer that specifies the offset of the signatureInfo field within this structure relative to the
        /// cbSigInfo field. MUST be 0x00000008.
        self.serializedPointer = try dataStream.read(endianess: .littleEndian)
        if self.serializedPointer != 0x00000008 {
            throw OfficeFileError.corrupted
        }
        
        /// signatureInfo (variable): A DigSigInfoSerialized structure (section 2.3.2.1) containing the data for the signature.
        self.signatureInfo = try DigSigInfoSerialized(dataStream: &dataStream, startPosition: startPosition)
        
        /// padding (variable): An array of bytes. The size of this array is the number of bytes necessary to pad the entire structure’s size to a multiple
        /// of 2 bytes. The contents of this field are undefined and MUST be ignored.
        let excessBytes = (dataStream.position - startPosition) % 2
        if excessBytes > 2 {
            let position = dataStream.position + (2 - excessBytes)
            if position > dataStream.position {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position = position
        }
        
        if dataStream.position - startPosition != self.cch {
            throw OfficeFileError.corrupted
        }
    }
}
