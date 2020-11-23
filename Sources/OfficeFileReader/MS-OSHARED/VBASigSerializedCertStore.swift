//
//  VBASigSerializedCertStore.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.2.5.5 VBASigSerializedCertStore
/// Referenced by: DigSigInfoSerialized
/// The serialized digital certificate store specifies structures for storing a digital certificate store containing a single digital certificate and, optionally,
/// a list of properties associated with the certificate.
public struct VBASigSerializedCertStore {
    public let version: UInt32
    public let fileType: UInt32
    public let certGroup: CertStoreCertificateGroup
    public let endMarkerElement: EndElementMarkerEntry
    
    public init(dataStream: inout DataStream) throws {
        /// version (4 bytes): An unsigned integer identifying the version of the structure. MUST be 0x00000000.
        self.version = try dataStream.read(endianess: .littleEndian)
        if self.version != 0x00000000 {
            throw OfficeFileError.corrupted
        }
        
        /// fileType (4 bytes): An unsigned integer that MUST be the value 0x54524543. This value specifies that the structure is a digital certificate store.
        self.fileType = try dataStream.read(endianess: .littleEndian)
        if self.fileType != 0x54524543 {
            throw OfficeFileError.corrupted
        }
        
        /// certGroup (variable): A CertStoreCertificateGroup (section 2.3.2.5.4) structure that specifies the digital certificate stored in this serialized
        /// digital certificate store along with a set of optional properties.
        self.certGroup = try CertStoreCertificateGroup(dataStream: &dataStream)
        
        /// endMarkerElement (12 bytes): An EndElementMarkerEntry (section 2.3.2.5.2) structure specifying the end of the structure.
        self.endMarkerElement = try EndElementMarkerEntry(dataStream: &dataStream)
    }
}
