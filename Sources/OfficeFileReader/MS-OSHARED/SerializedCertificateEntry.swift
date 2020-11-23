//
//  SerializedCertificateEntry.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.2.5.1 SerializedCertificateEntry
/// Referenced by: CertStoreCertificateGroup
/// Specifies a serialized digital certificate entry in a serialized digital certificate store.
public struct SerializedCertificateEntry {
    public let id: UInt32
    public let encodingType: UInt32
    public let length: UInt32
    public let certificate: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// id (4 bytes): An unsigned integer. MUST be 0x00000020.
        self.id = try dataStream.read(endianess: .littleEndian)
        if self.id != 0x00000020 {
            throw OfficeFileError.corrupted
        }
        
        /// encodingType (4 bytes): An unsigned integer that MUST be the value 0x00000001, which specifies ASN.1 encoding ([ITUX680-1994]).
        self.encodingType = try dataStream.read(endianess: .littleEndian)
        if self.encodingType != 0x00000020 {
            throw OfficeFileError.corrupted
        }
        
        /// length (4 bytes): An unsigned integer that specifies the count of bytes for the certificate field.
        self.length = try dataStream.read(endianess: .littleEndian)
        
        /// certificate (variable): Specifies the certificate data. MUST contain the ASN.1 [ITUX680-1994] DER encoding of an X.509 certificate
        /// as specified by [RFC3280].
        self.certificate = try dataStream.readBytes(count: Int(self.length))
    }
}
