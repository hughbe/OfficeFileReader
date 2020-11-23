//
//  MsoEnvelopeCLSID.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OSHARED] 2.3.8.1 MsoEnvelopeCLSID
/// A structure that specifies the type of data in EnvelopeData based on the value of CLSID.
public struct MsoEnvelopeCLSID {
    public let clsid: GUID
    public let envelopeData: EnvelopeData
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 16 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// CLSID (16 bytes): A GUID, as specified by [MS-DTYP], that specifies the type of data in EnvelopeData. If this GUID equals
        /// { 0x0006F01A, 0x0000, 0x0000, { 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46 } }, then the data in EnvelopeData is specified by MsoEnvelope
        /// structure (section 2.3.8.2). If not, then the data in EnvelopeData is out of scope for this document.
        self.clsid = try GUID(dataStream: &dataStream)
        
        /// EnvelopeData (variable): An array of bytes that is either specified by MsoEnvelope structure (section 2.3.8.2) or is out of scope, depending on the
        /// value of CLSID.
        if self.clsid == GUID(0x0006F01A, 0x0000, 0x0000, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46) {
            self.envelopeData = .envelope(data: try MsoEnvelope(dataStream: &dataStream))
        } else {
            self.envelopeData = .other(data: try dataStream.readBytes(count: Int(size - 16)))
        }
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
    
    /// EnvelopeData (variable): An array of bytes that is either specified by MsoEnvelope structure (section 2.3.8.2) or is out of scope, depending on the
    /// value of CLSID.
    public enum EnvelopeData {
        case envelope(data: MsoEnvelope)
        case other(data: [UInt8])
    }
}
