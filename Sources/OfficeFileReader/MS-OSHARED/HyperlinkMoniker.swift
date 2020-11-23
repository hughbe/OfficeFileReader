//
//  HyperlinkMoniker.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OSHARED] 2.3.7.2 HyperlinkMoniker
/// Referenced by: CompositeMoniker, Hyperlink Object
/// This structure specifies a hyperlink moniker.
public struct HyperlinkMoniker {
    public let monikerClsid: GUID
    public let data: Data
    
    public init(dataStream: inout DataStream) throws {
        /// monikerClsid (16 bytes): A class identifier (CLSID) that specifies the Component Object Model (COM) component that saved this structure.
        /// MUST be a value from the following table:
        /// {0x79EAC9E0, 0xBAF9, 0x11CE, 0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B} Data field contains a URLMoniker (section 2.3.7.6).
        /// {0x00000303, 0x0000, 0x0000, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46} Data field contains a FileMoniker (section 2.3.7.8).
        /// {0x00000309, 0x0000, 0x0000, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46} Data field contains a CompositeMoniker (section 2.3.7.3).
        /// {0x00000305, 0x0000, 0x0000, { 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46 } Data field contains an AntiMoniker (section 2.3.7.4).
        /// {0x00000304, 0x0000, 0x0000, { 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46 } Data field contains an ItemMoniker (section 2.3.7.5).
        self.monikerClsid = try GUID(dataStream: &dataStream)
        
        /// data (variable): A moniker of the type specified by monikerClsid.
        switch self.monikerClsid {
        case GUID(0x79EAC9E0, 0xBAF9, 0x11CE, 0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B):
            self.data = .url(data: try URLMoniker(dataStream: &dataStream))
        case GUID(0x00000303, 0x0000, 0x0000, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46):
            self.data = .file(data: try FileMoniker(dataStream: &dataStream))
        case GUID(0x00000309, 0x0000, 0x0000, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46):
            self.data = .composite(data: try CompositeMoniker(dataStream: &dataStream))
        case GUID(0x00000305, 0x0000, 0x0000, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46):
            self.data = .anti(data: try AntiMoniker(dataStream: &dataStream))
        case GUID(0x00000304, 0x0000, 0x0000, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46):
            self.data = .item(data: try ItemMoniker(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
    
    public enum Data {
        case url(data: URLMoniker)
        case file(data: FileMoniker)
        case composite(data: CompositeMoniker)
        case anti(data: AntiMoniker)
        case item(data: ItemMoniker)
    }
}
