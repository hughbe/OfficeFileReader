//
//  OutlineTextProps9Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.60 OutlineTextProps9Container
/// Referenced by: PP9DocBinaryTagExtension
/// A container record that specifies additional text properties for outline text.
public struct OutlineTextProps9Container {
    public let rh: RecordHeader
    public let rgOutlineTextProps9Entry: [OutlineTextProps9Entry]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_OutlineTextProps9.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .outlineTextProps9 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgOutlineTextProps9Entry (variable): An array of OutlineTextProps9Entry structures that specifies the text properties. The size, in bytes, of
        /// the array is specified by rh.recLen.
        var rgOutlineTextProps9Entry: [OutlineTextProps9Entry] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgOutlineTextProps9Entry.append(try OutlineTextProps9Entry(dataStream: &dataStream))
        }
        
        self.rgOutlineTextProps9Entry = rgOutlineTextProps9Entry
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
