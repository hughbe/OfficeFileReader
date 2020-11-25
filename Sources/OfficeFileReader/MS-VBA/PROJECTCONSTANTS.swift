//
//  PROJECTCONSTANTS.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1.11 PROJECTCONSTANTS Record
/// Specifies the compilation constants for the VBA project
public struct PROJECTCONSTANTS {
    public let id: UInt16
    public let sizeOfConstants: UInt32
    public let constants: String
    public let reserved: UInt16
    public let sizeOfConstantsUnicode: UInt32
    public let constantsUnicode: String
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x000C.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x000C else {
            throw OfficeFileError.corrupted
        }
        
        /// SizeOfConstants (4 bytes): An unsigned integer that specifies the size in bytes of Constants. MUST be less than or equal to 1015.
        self.sizeOfConstants = try dataStream.read(endianess: .littleEndian)
        guard self.sizeOfConstants <= 1015 else {
            throw OfficeFileError.corrupted
        }
        
        /// Constants (variable): An array of SizeOfConstants bytes that specifies the compilation constants for the VBA project. MUST contain
        /// MBCS characters encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4). MUST NOT contain null characters.
        /// MUST conform to the following ABNF grammar:
        /// Constants = Constant *( " : " Constant )
        /// Constant = ConstantName " = " ConstantValue
        /// ConstantName = VbaIdentifier
        /// ConstantValue = ["-"] 1*5DIGIT
        /// <ConstantName>: Specifies a unique VBA identifier for the constant.
        /// <ConstantValue>: Specifies the numeric value for the constant. SHOULD be between −9999 and 32767. MAY be between −32768
        /// and 32767 on read.<7>
        self.constants = try dataStream.readString(count: Int(self.sizeOfConstants), encoding: .ascii)!
        
        /// Reserved (2 bytes): MUST be 0x003C. MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        /// SizeOfConstantsUnicode (4 bytes): An unsigned integer that specifies the size in bytes of ConstantsUnicode. MUST be even.
        self.sizeOfConstantsUnicode = try dataStream.read(endianess: .littleEndian)
        guard (self.sizeOfConstantsUnicode % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        /// ConstantsUnicode (variable): An array of SizeOfConstantsUnicode bytes that specifies the compilation constants for the VBA project.
        /// MUST contain UTF-16 characters. MUST NOT contain null characters. MUST contain the UTF-16 encoding of Constants.
        self.constantsUnicode = try dataStream.readString(count: Int(self.sizeOfConstantsUnicode), encoding: .utf16LittleEndian)!
    }
}
