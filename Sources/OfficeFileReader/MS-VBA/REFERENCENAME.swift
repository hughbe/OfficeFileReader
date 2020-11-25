//
//  REFERENCENAME.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.2.2 REFERENCENAME Record
/// Specifies the name of a referenced VBA project or Automation type library.
public struct REFERENCENAME {
    public let id: UInt16
    public let sizeOfName: UInt32
    public let name: String
    public let reserved: UInt16
    public let sizeOfNameUnicode: UInt32
    public let nameUnicode: String
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0016.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0016 else {
            throw OfficeFileError.corrupted
        }
        
        /// SizeOfName (4 bytes): An unsigned integer that specifies the size in bytes of Name.
        self.sizeOfName = try dataStream.read(endianess: .littleEndian)
        
        /// Name (variable): An array of SizeOfName bytes that specifies the name of the referenced VBA project or Automation type library. MUST
        /// contain MBCS characters encoded using the code page specified in PROJECTCODEPAGE Record (section 2.3.4.2.1.4). MUST NOT
        /// contain null characters. MUST conform to the following ABNF grammar:
        /// ReferenceName = RefProjectName / RefLibraryName
        /// RefProjectName = VbaIdentifier
        /// RefLibraryName = Identifier
        /// <RefProjectName>: The name of a referenced project. <ReferenceName> MUST use the
        /// <RefProjectName> rule when the ReferenceRecord of the parent REFERENCE (section 2.3.4.2.2.1) is a REFERENCEPROJECT
        /// (section 2.3.4.2.2.6).
        /// <RefLibraryName>: The name of a referenced Automation type library. <ReferenceName> MUST use the <RefLibraryName> rule
        /// when the ReferenceRecord of the parent REFERENCE (section 2.3.4.2.2.1) is a REFERENCECONTROL (section 2.3.4.2.2.3) or
        /// REFERENCEREGISTERED (section 2.3.4.2.2.5). <Identifier> is defined in [C706].
        self.name = try dataStream.readString(count: Int(self.sizeOfName), encoding: .ascii)!
        
        /// Reserved (2 bytes): MUST be 0x003E. MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        /// SizeOfNameUnicode (4 bytes): An unsigned integer that specifies the size in bytes of NameUnicode.
        self.sizeOfNameUnicode = try dataStream.read(endianess: .littleEndian)
        guard (self.sizeOfNameUnicode % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        /// NameUnicode (variable): An array of SizeOfNameUnicode bytes that specifies the name of the referenced VBA project or Automation type
        /// library. MUST contain UTF-16 characters. MUST NOT contain null characters. MUST contain the UTF-16 encoding of Name.
        self.nameUnicode = try dataStream.readString(count: Int(self.sizeOfNameUnicode), encoding: .utf16LittleEndian)!
    }
}
