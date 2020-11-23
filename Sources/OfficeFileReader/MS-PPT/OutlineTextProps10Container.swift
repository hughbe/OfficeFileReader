//
//  OutlineTextProps10Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.63 OutlineTextProps10Container
/// Referenced by: PP10DocBinaryTagExtension
/// A container record that specifies additional text properties for outline text.
public struct OutlineTextProps10Container {
    public let rh: RecordHeader
    public let rgOutlineTextProps10Entry: [OutlineTextProps10Entry]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_OutlineTextProps10.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .outlineTextProps10 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgOutlineTextProps10Entry (variable): An array of OutlineTextProps10Entry structures that specifies the text properties. The size, in bytes,
        /// of the array is specified by rh.recLen.
        var rgOutlineTextProps10Entry: [OutlineTextProps10Entry] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgOutlineTextProps10Entry.append(try OutlineTextProps10Entry(dataStream: &dataStream))
        }
        
        self.rgOutlineTextProps10Entry = rgOutlineTextProps10Entry
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
