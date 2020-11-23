//
//  DocRoutingSlipString.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.2 DocRoutingSlipString
/// Referenced by: DocRoutingSlipAtom
/// A structure that specifies information about a string in a document routing slip
public struct DocRoutingSlipString {
    public let stringType: StringType
    public let stringLength: UInt16
    public let string: PrintableAnsiString
    
    public init(dataStream: inout DataStream) throws {
        /// stringType (2 bytes): An unsigned integer that specifies the type of a string. It MUST be a value from the following table.
        let stringTypeRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let stringType = StringType(rawValue: stringTypeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.stringType = stringType
        
        /// stringLength (2 bytes): An unsigned integer that specifies the number of bytes supplied for the string, minus 1. If stringType is equal to 0x0001
        /// or 0x0002, this value MUST be greater than 0x0000.
        let stringLength: UInt16 = try dataStream.read(endianess: .littleEndian)
        if (stringType == .originator || stringType == .recipient) && stringLength == 0 {
            throw OfficeFileError.corrupted
        }
        
        self.stringLength = stringLength
        
        /// string (variable): A PrintableAnsiString (section 2.2.22) that specifies the characters of the string. The length, in bytes, of the string is specified
        /// by stringLength plus 1. If stringType is equal to 0x0001 or 0x0002, the byte at index stringLength minus 1 MUST be equal to 0x00 and the byte
        /// at index stringLength MUST be ignored. If stringType is equal to 0x0003 or 0x0004, the byte at index stringLength MUST be equal to 0x00.
        self.string = try PrintableAnsiString(dataStream: &dataStream, byteCount: Int(stringLength + 1))
    }
    
    /// stringType (2 bytes): An unsigned integer that specifies the type of a string. It MUST be a value from the following table.
    public enum StringType: UInt16 {
        /// 0x0001 The originator of a document routing slip.
        case originator = 0x0001
        
        /// 0x0002 A recipient of a document routing slip.
        case recipient = 0x0002
        
        /// 0x0003 The subject of a document routing slip.
        case subject = 0x0003
        
        /// 0x0004 The message body of a document routing slip.
        case messageBody = 0x0004
    }
}
