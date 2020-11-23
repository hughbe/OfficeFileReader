//
//  RecipientDataItem.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.224 RecipientDataItem
/// The RecipientDataItem structure specifies information about a mail merge recipient. All the RecipientDataItem elements that pertain to a particular
/// recipient are grouped together. The presence of a RecipientTerminator indicates that there is no further data about this recipient. RecipientDataItem
/// elements that follow a RecipientTerminator relate to subsequent recipients.
public struct RecipientDataItem {
    public let recipientDataId: UInt16
    public let cbRecipientData: UInt16
    public let data: Data
    
    public init(dataStream: inout DataStream) throws {
        /// RecipientDataId (2 bytes): An unsigned integer value that specifies the type of a RecipientDataItem. This value MUST be 0x0001,
        /// 0x0002, 0x0003, or 0x0004.
        let recipientDataId: UInt16 = try dataStream.read(endianess: .littleEndian)
        if recipientDataId != 0x0001 &&
            recipientDataId != 0x0002 &&
            recipientDataId != 0x0003 &&
            recipientDataId != 0x0004 {
            throw OfficeFileError.corrupted
        }

        self.recipientDataId = recipientDataId
        
        /// cbRecipientData (2 bytes): An unsigned integer that specifies the size, in bytes, of the following Data element.
        self.cbRecipientData = try dataStream.read(endianess: .littleEndian)
        
        /// Data (variable): Contains the actual data for this RecipientDataItem. The meaning of the data depends on the preceding RecipientDataId
        /// and is described following.
        /// 0x0001 An unsigned integer that specifies the status (included or excluded) of a recipient record. This value MUST be zero (excluded) or
        /// 1 (included). If not present, this value defaults to 1.
        /// 0x0002 An unsigned integer that specifies the zero-based index of the data source column that uniquely identifies a recipient.
        /// 0x0003 An unsigned integer that specifies a hashed DWORD that uniquely identifies a recipient if there is no unique column in the data source.
        /// The hash value for a data source record is generated as follows:
        /// FUNCTION GetHash
        ///  SET hashValue to 0x00000000
        ///  FOR each column in the data source
        ///  SET strColumn to the string value in the column
        ///  SET hashValue to CALL AddStringToHash hashValue strColumn
        ///  END FOR
        ///  RETURN hashValue
        /// END FUNCTION
        /// FUNCTION AddStringToHash hashValue, unicodeString
        ///  FOR each character in the unicodeString
        ///  SET hashValue to CALL AddCharacterToHash hashValue character
        ///  END FOR
        /// END FUNCTION
        /// FUNCTION AddCharacterToHash hashValue, unicodeCharacter
        ///  SET tempCalc to 131 times hashValue plus unicodeCharacter
        ///  IF tempCalc >= 4294967291
        ///  SET tempCalc to tempCalc minus 4294967291
        ///  END IF
        ///  RETURN tempCalc
        /// END FUNCTION
        /// If the data source is Microsoft Outlook, the last column in the data source SHOULD NOT<233> be used in the preceding function GetHash.
        /// 0x0004 A Unicode string that specifies the contents of the data source column that uniquely identifies a recipient. The string is not
        /// null-terminated.
        let startPosition = dataStream.position
        if recipientDataId == 0x0001 {
            let data: UInt32 = try dataStream.read(endianess: .littleEndian)
            guard let status = RecipientStatus(rawValue: data) else {
                throw OfficeFileError.corrupted
            }

            self.data = .status(data: status)
        } else if recipientDataId == 0x0002 {
            let data: UInt32 = try dataStream.read(endianess: .littleEndian)
            self.data = .dataSourceColumnIndex(data: data)
        } else if recipientDataId == 0x0003 {
            let data: UInt32 = try dataStream.read(endianess: .littleEndian)
            self.data = .hashedIdentifier(data: data)
        } else if recipientDataId == 0x0003 {
            let data = try dataStream.readString(count: Int(self.cbRecipientData), encoding: .utf16LittleEndian)!
            self.data = .dataSourceColumnContents(data: data)
        } else {
            throw OfficeFileError.corrupted
        }
        
        if dataStream.position - startPosition != self.cbRecipientData {
            throw OfficeFileError.corrupted
        }
    }
    
    /// Data (variable): Contains the actual data for this RecipientDataItem. The meaning of the data depends on the preceding RecipientDataId
    /// and is described following.
    public enum Data {
        /// 0x0001 An unsigned integer that specifies the status (included or excluded) of a recipient record. This value MUST be zero (excluded) or
        /// 1 (included). If not present, this value defaults to 1.
        case status(data: RecipientStatus)
        
        /// 0x0002 An unsigned integer that specifies the zero-based index of the data source column that uniquely identifies a recipient.
        case dataSourceColumnIndex(data: UInt32)
        
        /// 0x0003 An unsigned integer that specifies a hashed DWORD that uniquely identifies a recipient if there is no unique column
        /// in the data source.
        /// The hash value for a data source record is generated as follows:
        /// FUNCTION GetHash
        ///  SET hashValue to 0x00000000
        ///  FOR each column in the data source
        ///  SET strColumn to the string value in the column
        ///  SET hashValue to CALL AddStringToHash hashValue strColumn
        ///  END FOR
        ///  RETURN hashValue
        /// END FUNCTION
        /// FUNCTION AddStringToHash hashValue, unicodeString
        ///  FOR each character in the unicodeString
        ///  SET hashValue to CALL AddCharacterToHash hashValue character
        ///  END FOR
        /// END FUNCTION
        /// FUNCTION AddCharacterToHash hashValue, unicodeCharacter
        ///  SET tempCalc to 131 times hashValue plus unicodeCharacter
        ///  IF tempCalc >= 4294967291
        ///  SET tempCalc to tempCalc minus 4294967291
        ///  END IF
        ///  RETURN tempCalc
        /// END FUNCTION
        /// If the data source is Microsoft Outlook, the last column in the data source SHOULD NOT<233> be used in the preceding function GetHash.
        case hashedIdentifier(data: UInt32)

        /// 0x0004 A Unicode string that specifies the contents of the data source column that uniquely identifies a recipient. The string is not
        /// null-terminated.
        case dataSourceColumnContents(data: String)
    }
    
    /// An unsigned integer that specifies the status (included or excluded) of a recipient record. This value MUST be zero (excluded) or 1 (included).
    /// If not present, this value defaults to 1.
    public enum RecipientStatus: UInt32 {
        case excluded = 0

        case included = 1
    }
}
