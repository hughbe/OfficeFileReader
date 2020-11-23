//
//  CertStoreCertificateGroup.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.2.5.4 CertStoreCertificateGroup
/// Referenced by: DocSigSerializedCertStore, VBASigSerializedCertStore
/// Specifies a grouping of elements in a serialized digital certificate store that consists of zero or more properties of a certificate, and the serialized
/// certificate itself.
public struct CertStoreCertificateGroup {
    public let elementList: [SerializedPropertyEntry]
    public let certificateElement: SerializedCertificateEntry

    public init(dataStream: inout DataStream) throws {
        /// elementList (variable): An array of SerializedPropertyEntry (section 2.3.2.5.3). This array can contain zero or more elements. Elements
        /// of this array are read and processed until a SerializedPropertyEntry.id is read with the unsigned integer value 0x00000020, which specifies
        /// the end of this array and the beginning of the certificateElement field. The terminating SerializedPropertyEntry.id that is read is actually
        /// the certificateElement.id field and not a part of this field.
        var elementList: [SerializedPropertyEntry] = []
        while try dataStream.peek(endianess: .littleEndian) != 0x00000020 {
            elementList.append(try SerializedPropertyEntry(dataStream: &dataStream))
        }
        
        self.elementList = elementList
        
        /// certificateElement (variable): A SerializedCertificateEntry (section 2.3.2.5.1) specifying a digital certificate stored in this digital certificate store.
        self.certificateElement = try SerializedCertificateEntry(dataStream: &dataStream)
    }
}
