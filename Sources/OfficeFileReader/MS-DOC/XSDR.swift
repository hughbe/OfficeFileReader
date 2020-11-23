//
//  XSDR.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.352 XSDR
/// The XSDR structure specifies a single reference to an XML schema definition.
public struct XSDR {
    public let wzURI: String
    public let wzManifestLocation: String
    public let sttbElements: STTB<String>
    public let sttbAttributes: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// wzURI (variable): A Unicode string that indicates the URI of this schema definition. The string is length-prefixed with a 16-bit integer and is not
        /// null-terminated.
        let wzURILength: UInt16 = try dataStream.read(endianess: .littleEndian)
        if wzURILength == 0 {
            self.wzURI = ""
        } else {
            self.wzURI = try dataStream.readString(count: Int(wzURILength * 2), encoding: .utf16LittleEndian)!
        }
        
        /// wzManifestLocation (variable): A Unicode string that is length-prefixed with a 16-bit integer and is not null-terminated. If this schema definition
        /// was loaded through an XML expansion pack, wzManifestLocation is the URI of the expansion pack manifest. If it was not loaded through an
        /// expansion pack, the string is empty.
        let wzManifestLocationLength: UInt16 = try dataStream.read(endianess: .littleEndian)
        if wzManifestLocationLength == 0 {
            self.wzManifestLocation = ""
        } else {
            self.wzManifestLocation = try dataStream.readString(count: Int(wzURILength * 2), encoding: .utf16LittleEndian)!
        }
        
        /// sttbElements (variable): An STTB structure that contains all the elements within this XML schema. This structure uses a 4-byte cData.
        self.sttbElements = try STTB(dataStream: &dataStream, fourByteCData: true)
        
        /// sttbAttributes (variable): An STTB structure that contains all the attributes within this XML schema. This structure uses a 4-byte cData.
        self.sttbAttributes = try STTB(dataStream: &dataStream, fourByteCData: true)
    }
}
