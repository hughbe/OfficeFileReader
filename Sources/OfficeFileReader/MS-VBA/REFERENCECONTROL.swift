//
//  REFERENCECONTROL.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OVBA] 2.3.4.2.2.3 REFERENCECONTROL Record
/// Specifies a reference to a twiddled type library and its extended type library.
public struct REFERENCECONTROL {
    public let originalRecord: REFERENCEORIGINAL?
    public let id: Int16
    public let sizeTwiddled: UInt32
    public let sizeOfLibidTwiddled: UInt32
    public let libidTwiddled: String
    public let reserved1: UInt32
    public let reserved2: UInt16
    public let nameRecordExtended: REFERENCENAME?
    public let reserved3: UInt16
    public let sizeExtended: UInt32
    public let sizeOfLibidExtended: UInt32
    public let libidExtended: String
    public let reserved4: UInt32
    public let reserved5: UInt16
    public let originalTypeLib: GUID
    public let cookie: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// OriginalRecord (variable): A REFERENCEORIGINAL Record (section 2.3.4.2.2.4) that specifies the Automation type library the
        /// twiddled type library was generated from. This field is optional.
        if try dataStream.peek(endianess: .littleEndian) as UInt16 == 0x0033 {
            self.originalRecord = try REFERENCEORIGINAL(dataStream: &dataStream)
        } else {
            self.originalRecord = nil
        }
        
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x002F.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x002F else {
            throw OfficeFileError.corrupted
        }
        
        /// SizeTwiddled (4 bytes): An unsigned integer that specifies the sum of the size in bytes of SizeOfLibidTwiddled, LibidTwiddled, Reserved1,
        /// and Reserved2. MUST be ignored on read.
        self.sizeTwiddled = try dataStream.read(endianess: .littleEndian)
        
        /// SizeOfLibidTwiddled (4 bytes): An unsigned integer that specifies the size in bytes of LibidTwiddled.
        self.sizeOfLibidTwiddled = try dataStream.read(endianess: .littleEndian)
        
        /// LibidTwiddled (variable): An array of SizeOfLibidTwiddled bytes. SHOULD be "*\G{00000000- 0000-0000-0000-000000000000}#0.0#0##"
        /// (case-sensitive). MAY<8> specify a twiddled type library’s identifier. The identifier MUST conform to the ABNF grammar LibidReference
        /// (section 2.1.1.8). MUST contain MBCS characters encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4).
        /// MUST NOT contain null characters.
        self.libidTwiddled = try dataStream.readString(count: Int(self.sizeOfLibidTwiddled), encoding: .ascii)!
        
        /// Reserved1 (4 bytes): MUST be 0x00000000. MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// Reserved2 (2 bytes): MUST be 0x0000. MUST be ignored.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
        
        /// NameRecordExtended (variable): A REFERENCENAME Record (section 2.3.4.2.2.2) that specifies the name of the extended type library.
        /// This field is optional.
        self.nameRecordExtended = try REFERENCENAME(dataStream: &dataStream)
        
        /// Reserved3 (2 bytes): MUST be 0x0030. MUST be ignored.
        self.reserved3 = try dataStream.read(endianess: .littleEndian)
        
        /// SizeExtended (4 bytes): An unsigned integer that specifies the sum of the size in bytes of SizeOfLibidExtended, LibidExtended, Reserved4, Reserved5,
        /// OriginalTypeLib, and Cookie. MUST be ignored on read.
        self.sizeExtended = try dataStream.read(endianess: .littleEndian)
        
        /// SizeOfLibidExtended (4 bytes): An unsigned integer that specifies the size in bytes of LibidExtended.
        self.sizeOfLibidExtended = try dataStream.read(endianess: .littleEndian)
        
        /// LibidExtended (variable): An array of SizeOfLibidExtended bytes that specifies the extended type library’s identifier. MUST contain MBCS
        /// characters encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4). MUST NOT contain null characters.
        /// MUST conform to the ABNF grammar in LibidReference (section 2.1.1.8).
        self.libidExtended = try dataStream.readString(count: Int(self.sizeOfLibidExtended), encoding: .ascii)!
        
        /// Reserved4 (4 bytes): MUST be 0x00000000. MUST be ignored.
        self.reserved4 = try dataStream.read(endianess: .littleEndian)
        
        /// Reserved5 (2 bytes): MUST be 0x0000. MUST be ignored.
        self.reserved5 = try dataStream.read(endianess: .littleEndian)
        
        /// OriginalTypeLib (16 bytes): A GUID that specifies the Automation type library the extended type library was generated from.
        self.originalTypeLib = try GUID(dataStream: &dataStream)
        
        /// Cookie (4 bytes): An unsigned integer that specifies the extended type library’s cookie. MUST be unique for each REFERENCECONTROL
        /// (section 2.3.4.2.2.3) in the VBA project with the same OriginalTypeLib.
        self.cookie = try dataStream.read(endianess: .littleEndian)
    }
}
