//
//  ODTPersist1.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.166 ODTPersist1
/// The ODTPersist1 structure is a collection of bits that specify information about an OLE object.
public struct ODTPersist1 {
    public let reserved1: Bool
    public let fDefHandler: Bool
    public let reserved2: Bool
    public let reserved3: Bool
    public let fLink: Bool
    public let reserved4: Bool
    public let fIcon: Bool
    public let fIsOle1: Bool
    public let fManual: Bool
    public let fRecomposeOnResize: Bool
    public let reserved5: Bool
    public let reserved6: Bool
    public let fOCX: Bool
    public let fStream: Bool
    public let reserved7: Bool
    public let fViewObject: Bool
    
    public init(dataStream: inout DataStream) throws {
        var rawValue: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - reserved1 (1 bit): Undefined and MUST be ignored.
        self.reserved1 = rawValue.readBit()
        
        /// B - fDefHandler (1 bit): If this bit is 1, then the application MUST assume that this OLE object’s class identifier (CLSID) is
        /// {00020907-0000-0000-C000-000000000046}.
        self.fDefHandler = rawValue.readBit()
        
        /// C - reserved2 (1 bit): Undefined and MUST be ignored.
        self.reserved2 = rawValue.readBit()
        
        /// D - reserved3 (1 bit): Undefined and MUST be ignored.
        self.reserved3 = rawValue.readBit()
        
        /// E - fLink (1 bit): A bit that specifies whether this OLE object is a link.
        self.fLink = rawValue.readBit()
        
        /// F - reserved4 (1 bit): Undefined and MUST be ignored.
        self.reserved4 = rawValue.readBit()
        
        /// G - fIcon (1 bit): A bit that specifies whether this OLE object is being represented by an icon.
        self.fIcon = rawValue.readBit()
        
        /// H - fIsOle1 (1 bit): A bit that specifies whether this OLE object is only compatible with OLE 1. If this bit is zero, then the object is compatible
        /// with OLE 2.
        self.fIsOle1 = rawValue.readBit()
        
        /// I - fManual (1 bit): A bit that specifies whether the user has requested that this OLE object only be updated in response to a user action.
        /// If fManual is zero, then the user has requested that this OLE object update automatically. If fLink is zero, then fManual is undefined and
        /// MUST be ignored.
        self.fManual = rawValue.readBit()
        
        /// J - fRecomposeOnResize (1 bit): A bit that specifies whether this OLE object has requested to be notified when it is resized by its container.
        self.fRecomposeOnResize = rawValue.readBit()
        
        /// K - reserved5 (1 bit): MUST be zero and MUST be ignored.
        self.reserved5 = rawValue.readBit()
        
        /// L - reserved6 (1 bit): MUST be zero and MUST be ignored.
        self.reserved6 = rawValue.readBit()
        
        /// M - fOCX (1 bit): A bit that specifies whether this object is an OLE control.
        self.fOCX = rawValue.readBit()
        
        /// N - fStream (1 bit): If fOCX is zero, then this bit MUST be zero. If fOCX is 1, then fStream is a bit that specifies whether this OLE control stores
        /// its data in a single stream instead of a storage. If fStream is 1, then the data for the OLE control is in a stream called "\003OCXDATA"
        /// where \003 is the character with value 0x0003, not the string literal "\003".
        self.fStream = rawValue.readBit()
        
        /// O - reserved7 (1 bit): Undefined and MUST be ignored.
        self.reserved7 = rawValue.readBit()

        /// P - fViewObject (1 bit): A bit that specifies whether this OLE object supports the IViewObject interface.
        self.fViewObject = rawValue.readBit()
    }
}
