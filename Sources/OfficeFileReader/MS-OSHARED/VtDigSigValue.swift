//
//  VtDigSigValue.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.16 VtDigSigValue
/// Referenced by: VtDigSig
/// Specifies the data for a VBA digital signature property. This type conforms to the VT_BLOB TypedPropertyValue value format as specified in
/// [MS-OLEPS] section 2.15, but this section specifies additional detail applicable to this type.
public struct VtDigSigValue {
    public let cb: UInt32
    public let vbaDigSig: DigSigBlob
    
    public init(dataStream: inout DataStream) throws {
        /// cb (4 bytes): An unsigned integer that specifies the size in bytes of vbaDigSig. MUST be equal to vbaDigSig.cb + 8.
        self.cb = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// vbaDigSig (variable): A DigSigBlob (section 2.3.2.2) structure that specifies a VBA digital signature.
        self.vbaDigSig = try DigSigBlob(dataStream: &dataStream)
        if self.cb != self.vbaDigSig.cb + 8 {
            throw OfficeFileError.corrupted
        }
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
