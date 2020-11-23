//
//  PropertyBagStore.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.4.1 PropertyBagStore
/// This structure specifies the shared data for the smart tags embedded in the document.
public struct PropertyBagStore {
    public let cFactoidType: UInt32
    public let factoidTypes: [FactoidType]
    public let cbHdr: UInt16
    public let sVer: UInt16
    public let cfactoid: UInt32
    public let cste: UInt32
    public let stringTable: [PBString]
    
    public init(dataStream: inout DataStream) throws {
        /// cFactoidType (4 bytes): Unsigned integer specifying the count of elements in the factoidTypes member.
        self.cFactoidType = try dataStream.read(endianess: .littleEndian)
        
        /// factoidTypes (variable): An array of FactoidType (section 2.3.4.2). Specifies the list of smart tag types.
        var factoidTypes: [FactoidType] = []
        factoidTypes.reserveCapacity(Int(self.cFactoidType))
        for _ in 0..<self.cFactoidType {
            factoidTypes.append(try FactoidType(dataStream: &dataStream))
        }
        
        self.factoidTypes = factoidTypes
        
        /// cbHdr (2 bytes): Unsigned integer specifying the size in bytes of the cbHdr, sVer, cfactoid, and cste fields. MUST be 0xC.
        self.cbHdr = try dataStream.read(endianess: .littleEndian)
        if self.cbHdr != 0x0C {
            throw OfficeFileError.corrupted
        }
        
        /// sVer (2 bytes): Unsigned integer specifying the version number of the structure. The high-order byte specifies the major version number.
        /// The low-order byte specifies the minor version number. MUST be 0x0100.
        self.sVer = try dataStream.read(endianess: .littleEndian)
        if self.sVer != 0x0100 {
            throw OfficeFileError.corrupted
        }
        
        /// cfactoid (4 bytes): Unsigned integer reserved for future use. MUST be ignored.
        self.cfactoid = try dataStream.read(endianess: .littleEndian)
        
        /// cste (4 bytes): Unsigned integer specifying the count of elements in the stringTable field.
        self.cste = try dataStream.read(endianess: .littleEndian)
        
        /// stringTable (variable): An array of PBString (section 2.3.4.5). Specifies the list of strings. Elements of this table are referenced by their
        /// indices to form key/value pairs by the keyIndex and valueIndex fields in Property (section 2.3.4.4), which is in the properties field of
        /// PropertyBag (section 2.3.4.3).
        var stringTable: [PBString] = []
        stringTable.reserveCapacity(Int(self.cste))
        for _ in 0..<self.cste {
            stringTable.append(try PBString(dataStream: &dataStream))
        }
        
        self.stringTable = stringTable
    }
}
