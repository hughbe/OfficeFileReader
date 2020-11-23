//
//  Hyperlink.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OSHARED] 2.3.7.1 Hyperlink Object
/// This structure specifies a hyperlink and hyperlink-related information.
public struct Hyperlink {
    public let streamVersion: UInt32
    public let hlstmfHasMoniker: Bool
    public let hlstmfIsAbsolute: Bool
    public let hlstmfSiteGaveDisplayName: Bool
    public let hlstmfHasLocationStr: Bool
    public let hlstmfHasDisplayName: Bool
    public let hlstmfHasGUID: Bool
    public let hlstmfHasCreationTime: Bool
    public let hlstmfHasFrameName: Bool
    public let hlstmfMonikerSavedAsStr: Bool
    public let hlstmfAbsFromGetdataRel: Bool
    public let reserved: UInt32
    public let displayName: HyperlinkString?
    public let targetFrameName: HyperlinkString?
    public let moniker: HyperlinkString?
    public let oleMoniker: HyperlinkMoniker?
    public let location: HyperlinkString?
    public let guid: GUID?
    public let fileTime: FILETIME?
    
    public init(dataStream: inout DataStream) throws {
        /// streamVersion (4 bytes): An unsigned integer that specifies the version number of the serialization implementation used to save this
        /// structure. This value MUST equal 2.
        self.streamVersion = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - hlstmfHasMoniker (1 bit): A bit that specifies whether this structure contains a moniker. If hlstmfMonikerSavedAsStr equals 1, this
        /// value MUST equal 1.
        self.hlstmfHasMoniker = flags.readBit()
        
        /// B - hlstmfIsAbsolute (1 bit): A bit that specifies whether this hyperlink is an absolute path or relative path.
        /// Value Meaning
        /// 0 This hyperlink is a relative path.
        /// 1 This hyperlink is an absolute path.
        self.hlstmfIsAbsolute = flags.readBit()
        
        /// C - hlstmfSiteGaveDisplayName (1 bit): A bit that specifies whether the creator of the hyperlink specified a display name.
        self.hlstmfSiteGaveDisplayName = flags.readBit()
        
        /// D - hlstmfHasLocationStr (1 bit): A bit that specifies whether this structure contains a hyperlink location.
        self.hlstmfHasLocationStr = flags.readBit()
        
        /// E - hlstmfHasDisplayName (1 bit): A bit that specifies whether this structure contains a display name.
        self.hlstmfHasDisplayName = flags.readBit()
        
        /// F - hlstmfHasGUID (1 bit): A bit that specifies whether this structure contains a GUID as specified by [MS-DTYP].
        self.hlstmfHasGUID = flags.readBit()
        
        /// G - hlstmfHasCreationTime (1 bit): A bit that specifies whether this structure contains the creation time of the file that contains the hyperlink.
        self.hlstmfHasCreationTime = flags.readBit()
        
        /// H - hlstmfHasFrameName (1 bit): A bit that specifies whether this structure contains a target frame name.
        self.hlstmfHasFrameName = flags.readBit()
        
        /// I - hlstmfMonikerSavedAsStr (1 bit): A bit that specifies whether the moniker was saved as a string.
        let hlstmfMonikerSavedAsStr = flags.readBit()
        self.hlstmfMonikerSavedAsStr = hlstmfMonikerSavedAsStr
        
        /// J - hlstmfAbsFromGetdataRel (1 bit): A bit that specifies whether the hyperlink specified by this structure is an absolute path generated
        /// from a relative path.
        self.hlstmfAbsFromGetdataRel = flags.readBit()
        
        /// reserved (22 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// displayName (variable): An optional HyperlinkString (section 2.3.7.9) that specifies the display name for the hyperlink.
        /// MUST exist if and only if hlstmfHasDisplayName equals 1.
        if self.hlstmfHasDisplayName {
            self.displayName = try HyperlinkString(dataStream: &dataStream)
        } else {
            self.displayName = nil
        }
        
        /// targetFrameName (variable): An optional HyperlinkString (section 2.3.7.9) that specifies the target frame. MUST exist if and only if
        /// hlstmfHasFrameName equals 1.
        if self.hlstmfHasFrameName {
            self.targetFrameName = try HyperlinkString(dataStream: &dataStream)
        } else {
            self.targetFrameName = nil
        }
        
        /// moniker (variable): An optional HyperlinkString (section 2.3.7.9) that specifies the hyperlink moniker. MUST exist if and only if
        /// hlstmfHasMoniker equals 1 and hlstmfMonikerSavedAsStr equals 1.
        if self.hlstmfHasMoniker && hlstmfMonikerSavedAsStr {
            self.moniker = try HyperlinkString(dataStream: &dataStream)
        } else {
            self.moniker = nil
        }
        
        /// oleMoniker (variable): An optional HyperlinkMoniker (section 2.3.7.2) that specifies the hyperlink moniker. MUST exist if and only if
        /// hlstmfHasMoniker equals 1 and hlstmfMonikerSavedAsStr equals 0.
        if self.hlstmfHasMoniker && !hlstmfMonikerSavedAsStr {
            self.oleMoniker = try HyperlinkMoniker(dataStream: &dataStream)
        } else {
            self.oleMoniker = nil
        }
        
        /// location (variable): An optional HyperlinkString (section 2.3.7.9) that specifies the hyperlink location. MUST exist if and only if
        /// hlstmfHasLocationStr equals 1.
        if self.hlstmfHasLocationStr {
            self.location = try HyperlinkString(dataStream: &dataStream)
        } else {
            self.location = nil
        }
        
        /// guid (16 bytes): An optional GUID as specified by [MS-DTYP] that identifies this hyperlink. MUST exist if and only if hlstmfHasGUID
        /// equals 1.
        if self.hlstmfHasGUID {
            self.guid = try GUID(dataStream: &dataStream)
        } else {
            self.guid = nil
        }
        
        /// fileTime (8 bytes): An optional FileTime structure as specified by [MS-DTYP] that specifies the UTC file creation time. MUST exist if
        /// and only if hlstmfHasCreationTime equals 1.
        if self.hlstmfHasCreationTime {
            self.fileTime = try FILETIME(dataStream: &dataStream)
        } else {
            self.fileTime = nil
        }
    }
}
