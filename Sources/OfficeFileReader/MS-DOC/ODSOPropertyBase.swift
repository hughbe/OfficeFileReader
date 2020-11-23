//
//  ODSOPropertyBase.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.162 ODSOPropertyBase
/// The ODSOPropertyBase structure contains an Office Data Source Object property type (id), size (cb), and value (OdsoProp). An Office Data
/// Source Object is used to perform the mail merge.
public struct ODSOPropertyBase {
    public let id: UInt16
    public let cb: UInt16
    public let odsoProp: OdsoProp
    
    public init(dataStream: inout DataStream) throws {
        /// id (2 bytes): An unsigned integer that specifies the type of the Office Data Source Object property (OdsoProp). This MUST be one of the
        /// following values: 0x0000, 0x0001, 0x0002, 0x0010, 0x0011, 0x0012, 0x0013, 0x0014, 0x0015, 0x0016, or 0x0017.
        let id: UInt16 = try dataStream.read(endianess: .littleEndian)
        if id != 0x0000 &&
            id != 0x0001 &&
            id != 0x0002 &&
            id != 0x0010 &&
            id != 0x0011 &&
            id != 0x0012 &&
            id != 0x0013 &&
            id != 0x0014 &&
            id != 0x0015 &&
            id != 0x0016 &&
            id != 0x0017 {
            throw OfficeFileError.corrupted
        }
        
        self.id = id
        
        /// cb (2 bytes): An unsigned integer that specifies the size, in bytes, of the OdsoProp value or, if the size is greater than 0xFFFE, this value
        /// MUST be 0xFFFF.
        self.cb = try dataStream.read(endianess: .littleEndian)
        
        /// OdsoProp (variable): If cb equals 0xFFFF, this contains an object of type ODSOPropertyLarge; otherwise it contains an object of type
        /// ODSOPropertyStandard. The data that is contained in the OdsoProp element is dependent on the id field and is defined following.
        /// id Meaning of data in OdsoProp
        /// 0x0000 A Unicode string, that specifies a Universal Data Link (UDL), that contains a data source connection string. The string is not null
        /// terminated.
        /// 0x0001 A Unicode string that specifies the set of data to be used when a data source includes multiple data sets. The string is not null
        /// terminated.
        /// 0x0002 A Unicode string that specifies the name of the file to be used as a data source. The string is not null terminated.
        /// 0x0010 A 4-byte unsigned integer that specifies the type of data source connection. The value stored in the file is not used by the
        /// application, as it is reset after loading the file, based on the connection information in OdsoProps 0x0000, 0x0001, and 0x0002.
        /// This MUST be a value between 0 and 7.
        /// 0x0011 A 2-byte unsigned integer that specifies a Unicode character used as a column delimiter for a text data source.
        /// 0x0012 A 4-byte unsigned integer that specifies whether the first row is a header row of column names. A value of 0x00000001 specifies
        /// that the first row contains column names; a value of 0x00000000 specifies that it does not.
        /// 0x0013 The property contains an array of FilterDataItem structures that are used to filter the list of recipients.
        /// 0x0014 The property contains up to three SortColumnAndDirection items that are used to sort the list of recipients.
        /// 0x0015 The property contains a RecipientInfo structure.
        /// 0x0016 The property contains a FieldMapInfo structure that specifies which database columns are mapped to each of 30 standard
        /// mail merge address fields. The FieldMapDataItem structures MUST appear in the following order and all items MUST be present:
        /// 1. Unique Identifier
        /// 2. Courtesy Title
        /// 3. First Name
        /// 4. Middle Name
        /// 5. Last Name
        /// 6. Suffix
        /// 7. Nickname
        /// 8. Job Title
        /// 9. Company
        /// 10. Address 1
        /// 11. Address 2
        /// 12. City
        /// 13. State
        /// 14. Postal Code
        /// 15. Country or Region
        /// 16. Business Phone
        /// 17. Business Fax
        /// 18. Home Phone
        /// 19. Home Fax
        /// 20. E-mail Address
        /// 21. Web Page
        /// 22. Spouse Courtesy Title
        /// 23. Spouse First Name
        /// 24. Spouse Middle Name
        /// 25. Spouse Last Name
        /// 26. Spouse Nickname
        /// 27. Phonetic Guide for First Name
        /// 28. Phonetic Guide for Last Name
        /// 29. Address 3
        /// 30. Department
        /// 0x0017 A 2-byte unsigned integer that specifies which step of the mail merge wizard the application last displayed. This MUST be a
        /// value between 1 and 6.
        if self.cb == 0xFFFF {
            self.odsoProp = .large(data: try ODSOPropertyLarge(dataStream: &dataStream))
        } else {
            self.odsoProp = .standard(data: try ODSOPropertyStandard(dataStream: &dataStream, size: self.cb))
        }
    }
    
    public enum OdsoProp {
        case large(data: ODSOPropertyLarge)
        case standard(data: ODSOPropertyStandard)
    }
}
