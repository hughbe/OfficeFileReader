//
//  ItemMoniker.swift
//  
//
//  Created by Hugh Bellamy on 10/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.7.5 ItemMoniker
/// Referenced by: HyperlinkMoniker
/// This structure specifies an item moniker. Item monikers are used to identify objects within containers, such as a portion of a document, an embedded
/// object within a compound document, or a range of cells within a spreadsheet. For more information about item monikers, see [MSDN-IMCOM].
public struct ItemMoniker {
    public let delimiterLength: UInt32
    public let delimiterAnsi: String
    public let delimiterUnicode: String
    public let itemLength: UInt32
    public let itemAnsi: String
    public let itemUnicode: String
    
    public init(dataStream: inout DataStream) throws {
        /// delimiterLength (4 bytes): An unsigned integer that specifies the sum of the count of bytes in the delimiterAnsi and delimiterUnicode fields.
        self.delimiterLength = try dataStream.read(endianess: .littleEndian)
        
        let startPosition1 = dataStream.position
        
        /// delimiterAnsi (variable): A null-terminated array of ANSI characters that specifies a delimiter for this moniker. Delimiters are used to separate
        /// monikers that are part of a collection of monikers in a composite moniker. The number of characters in the array is determined by the
        /// position of the terminating NULL character.
        self.delimiterAnsi = try dataStream.readAsciiString()!
        
        /// delimiterUnicode (variable): An optional array of Unicode characters that specifies a delimiter for this moniker if the delimiter cannot be
        /// completely specified in ANSI characters. This field MUST exist if and only if delimiterLength is greater than the size of delimiterAnsi in
        /// bytes. The number of characters in the array is determined by (delimiterLength - (size of delimiterAnsi in bytes)) / 2.
        let sizeOfDelimiterAnsi = dataStream.position - startPosition1
        self.delimiterUnicode = try dataStream.readString(count: Int(self.delimiterLength) - sizeOfDelimiterAnsi, encoding: .utf16LittleEndian)!
        
        if dataStream.position - startPosition1 != self.delimiterLength {
            throw OfficeFileError.corrupted
        }
        
        /// itemLength (4 bytes): An unsigned integer that specifies the count of bytes in the itemAnsi and itemUnicode fields.
        self.itemLength = try dataStream.read(endianess: .littleEndian)
        
        let startPosition2 = dataStream.position
        
        /// itemAnsi (variable): A null-terminated array of ANSI characters that specifies the string used to identify this item in a collection of items.
        /// The number of characters in this array is specified by itemLength.
        self.itemAnsi = try dataStream.readAsciiString()!
        
        /// itemUnicode (variable): An optional array of Unicode characters that specifies the string used to identify this item in a collection of items,
        /// if the string cannot be completely specified in ANSI characters. This field MUST exist if and only if itemLength is greater than the size of
        /// itemAnsi in bytes. The number of characters in the array is determined by (itemLength – (size of itemAnsi field in bytes)) / 2.
        let sizeOfItemAnsi = dataStream.position - startPosition1
        self.itemUnicode = try dataStream.readString(count: Int(self.itemLength) - sizeOfItemAnsi, encoding: .utf16LittleEndian)!
        
        if dataStream.position - startPosition2 != self.itemLength {
            throw OfficeFileError.corrupted
        }
    }
}
