//
//  HFD.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-DOC] 2.9.115 HFD
/// The HFD structure specifies hyperlink field data including how to handle the hyperlink when it is traversed and a location in this document
/// or an external document or webpage.
public struct HFD {
    public let bits: HFDBits
    public let clsid: GUID
    public let hyperlink: Hyperlink
    
    public init(dataStream: inout DataStream) throws {
        /// bits (1 byte): An HFDBits that specifies how to handle the hyperlink when it is traversed.
        self.bits = try HFDBits(dataStream: &dataStream)
        
        /// clsid (16 bytes): A CLSID that specifies the COM component that is used to create the hyperlink.
        self.clsid = try GUID(dataStream: &dataStream)
        
        /// hyperlink (variable): A Hyperlink Object as specified in [MS-OSHARED] section 2.3.7.1. This object specifies a location in this document
        /// or an external document or webpage.
        self.hyperlink = try Hyperlink(dataStream: &dataStream)
    }
}
