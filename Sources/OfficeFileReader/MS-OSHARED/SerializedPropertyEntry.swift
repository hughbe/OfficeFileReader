//
//  SerializedPropertyEntry.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.2.5.3 SerializedPropertyEntry
/// Referenced by: CertStoreCertificateGroup
/// Specifies an entry in a serialized digital certificate store that contains data for a property associated with a certificate in the store.
public struct SerializedPropertyEntry {
    public let id: UInt32
    public let encodingType: UInt32
    public let length: UInt32
    public let value: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// id (4 bytes): An unsigned integer specifying the identifier of the property. MUST be less than or equal to 0x0000FFFF and MUST
        /// NOT be the value 0x00000000 or 0x00000020 because these values specify the special entries SerializedCertificateEntry
        /// (section 2.3.2.5.1) and EndElementMarkerEntry (section 2.3.2.5.2).
        let id: UInt32 = try dataStream.read(endianess: .littleEndian)
        if id == 0x00000000 || id == 0x00000020 || id > 0x0000FFFF {
            throw OfficeFileError.corrupted
        }
        
        self.id = id
        
        /// encodingType (4 bytes): An unsigned integer that MUST be the value 0x00000001, which specifies ASN.1 encoding ([ITUX680-1994]).
        self.encodingType = try dataStream.read(endianess: .littleEndian)
        if self.encodingType != 0x00000001 {
            throw OfficeFileError.corrupted
        }
        
        /// length (4 bytes): An unsigned integer that specifies the count of bytes for the value field.
        self.length = try dataStream.read(endianess: .littleEndian)
        
        /// value (variable): Specifies the value of the property. This field SHOULD be ignored on read<13>.
        self.value = try dataStream.readBytes(count: Int(self.length))
    }
}
