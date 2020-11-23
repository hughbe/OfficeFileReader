//
//  DigSigBlob.swift
//  
//
//  Created by Hugh Bellamy on 10/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.2.2 DigSigBlob
/// Referenced by: VtDigSigValue
/// Specifies the layout of the VBA digital signature data.
public struct DigSigBlob {
    public let cb: UInt32
    public let serializedPointer: UInt32
    public let signatureInfo: DigSigInfoSerialized
    
    public init(dataStream: inout DataStream) throws {
        let startPosition1 = dataStream.position
        
        /// cb (4 bytes): An unsigned integer that specifies the size of the signatureInfo and padding fields combined, in bytes.
        self.cb = try dataStream.read(endianess: .littleEndian)
        
        /// serializedPointer (4 bytes): An unsigned integer that specifies the offset of the signatureInfo field within this structure. MUST be 0x00000008.
        self.serializedPointer = try dataStream.read(endianess: .littleEndian)
        
        let startPosition2 = dataStream.position
        
        /// signatureInfo (variable): A DigSigInfoSerialized structure (section 2.3.2.1) containing the data for the signature.
        self.signatureInfo = try DigSigInfoSerialized(dataStream: &dataStream, startPosition: startPosition1)
        
        /// padding (variable): An array of bytes. The size of this array is the number of bytes necessary to pad the size of the signatureInfo field to
        /// a multiple of 4 bytes. The contents of this field are undefined and MUST be ignored.
        let excessBytes = (dataStream.position - startPosition2) % 4
        if excessBytes != 0 {
            let newPosition = dataStream.position + (4 - excessBytes)
            if newPosition > dataStream.count {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position = newPosition
        }
        
        if dataStream.position - startPosition2 != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
