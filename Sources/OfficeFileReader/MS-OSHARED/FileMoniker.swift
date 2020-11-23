//
//  FileMoniker.swift
//  
//
//  Created by Hugh Bellamy on 10/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.7.8 FileMoniker
/// Referenced by: HyperlinkMoniker
/// This structure specifies a file moniker. For more information about file monikers, see [MSDN-FM].
public struct FileMoniker {
    public let cAnti: UInt16
    public let ansiLength: UInt32
    public let ansiPath: String
    public let endServer: UInt16
    public let versionNumber: UInt16
    public let reserved1: [UInt8]
    public let reserved2: UInt32
    public let cbUnicodePathSize: UInt32
    public let cbUnicodePathBytes: UInt32?
    public let usKeyValue: UInt16?
    public let unicodePath: String?
    
    public init(dataStream: inout DataStream) throws {
        /// cAnti (2 bytes): An unsigned integer that specifies the number of parent directory indicators at the beginning of the ansiPath field.
        self.cAnti = try dataStream.read(endianess: .littleEndian)
        
        /// ansiLength (4 bytes): An unsigned integer that specifies the number of ANSI characters in ansiPath, including the terminating NULL
        /// character. This value MUST be less than or equal to 32767.
        self.ansiLength = try dataStream.read(endianess: .littleEndian)
        if self.ansiLength > 32767 {
            throw OfficeFileError.corrupted
        }
        
        /// ansiPath (variable): A null-terminated array of ANSI characters that specifies the file path. The number of characters in the array is
        /// specified by ansiLength.
        self.ansiPath = try dataStream.readString(count: Int(self.ansiLength) - 1, encoding: .ascii)!
        
        /// endServer (2 bytes): An unsigned integer that specifies the number of Unicode characters used to specify the server portion of the
        /// path if the path is a UNC path (including the leading "\\"). If the path is not a UNC path, this field MUST equal 0xFFFF.
        self.endServer = try dataStream.read(endianess: .littleEndian)
        
        /// versionNumber (2 bytes): An unsigned integer that specifies the version number of this file moniker serialization implementation.
        /// MUST equal 0xDEAD.
        self.versionNumber = try dataStream.read(endianess: .littleEndian)
        if self.versionNumber != 0xDEAD {
            throw OfficeFileError.corrupted
        }
        
        /// reserved1 (16 bytes): MUST be zero and MUST be ignored.
        self.reserved1 = try dataStream.readBytes(count: 16)
        
        /// reserved2 (4 bytes): MUST be zero and MUST be ignored.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
        
        /// cbUnicodePathSize (4 bytes): An unsigned integer that specifies the size, in bytes, of cbUnicodePathBytes, usKeyValue, and
        /// unicodePath.
        /// If the file path specified in ansiPath cannot be completely specified by ANSI characters, the value of this field MUST be equal to the
        /// size, in bytes, of the path as a Unicode string (without a terminating NULL character) + 6. If the path can be fully specified in ANSI
        /// characters then the value of this field MUST be set to zero.
        /// If the value of this field is greater than zero, then the cbUnicodePathBytes, usKeyValue and unicodePath fields MUST exist.
        /// If the value of this field is zero, then the cbUnicodePathBytes, usKeyValue, and unicodePath fields MUST NOT exist.
        self.cbUnicodePathSize = try dataStream.read(endianess: .littleEndian)
        if self.cbUnicodePathSize == 0 {
            self.cbUnicodePathBytes = nil
            self.usKeyValue = nil
            self.unicodePath = nil
            return
        }
        
        let startPosition = dataStream.position
        
        /// cbUnicodePathBytes (4 bytes): An optional unsigned integer that specifies the size, in bytes, of the unicodePath field. This field exists
        /// if and only if cbUnicodePathSize is greater than zero.
        self.cbUnicodePathBytes = try dataStream.read(endianess: .littleEndian)
        
        /// usKeyValue (2 bytes): An optional unsigned integer that MUST be 3 if present. This field exists if and only if cbUnicodePathSize is
        /// greater than zero.
        self.usKeyValue = try dataStream.read(endianess: .littleEndian)
        if self.usKeyValue != 3 {
            throw OfficeFileError.corrupted
        }
        
        /// unicodePath (variable): An optional array of Unicode characters that specifies the complete file path. This path MUST be the complete
        /// Unicode version of the file path specified in ansiPath and MUST include additional Unicode characters that cannot be completely
        /// specified in ANSI characters. The number of characters in this array is specified by cbUnicodePathBytes/2. This array MUST NOT
        /// include a terminating NULL character. This field exists if and only if cbUnicodePathSize is greater than zero.
        self.unicodePath = try dataStream.readString(count: Int(self.cbUnicodePathBytes!), encoding: .utf16LittleEndian)!
        
        if dataStream.position - startPosition != self.cbUnicodePathSize {
            throw OfficeFileError.corrupted
        }
    }
}
