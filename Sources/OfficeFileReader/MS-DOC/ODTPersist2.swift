//
//  ODTPersist2.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.167 ODTPersist2
/// The ODTPersist2 structure is a collection of bits that specify information about an OLE object.
public struct ODTPersist2 {
    public let fEMF: Bool
    public let reserved1: Bool
    public let fQueriedEMF: Bool
    public let fStoredAsEMF: Bool
    public let reserved2: Bool
    public let reserved3: Bool
    public let reserved4: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var rawValue: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fEMF (1 bit): A bit that specifies that the presentation of this OLE object in the document is in the Enhanced Metafile format. This is
        /// different from fStoredAsEMF in the case of an object being represented as an icon. For icons, the icon can be an Enhanced Metafile even
        /// if the OLE object does not support the Enhanced Metafile format.
        self.fEMF = rawValue.readBit()
        
        /// B - reserved1 (1 bit): MUST be zero and MUST be ignored.
        self.reserved1 = rawValue.readBit()
        
        /// C - fQueriedEMF (1 bit): A bit that specifies whether the application that saved this Word Binary file had queried this OLE object to
        /// determine whether it supported the Enhanced Metafile format.
        self.fQueriedEMF = rawValue.readBit()
        
        /// D - fStoredAsEMF (1 bit): A bit that specifies that this OLE object supports the Enhanced Metafile format.
        self.fStoredAsEMF = rawValue.readBit()
        
        /// E - reserved2 (1 bit): Undefined and MUST be ignored.
        self.reserved2 = rawValue.readBit()
        
        /// F - reserved3 (1 bit): Undefined and MUST be ignored.
        self.reserved3 = rawValue.readBit()
        
        /// reserved4 (10 bits): Undefined and MUST be ignored.
        self.reserved4 = rawValue.readRemainingBits()
    }
}
