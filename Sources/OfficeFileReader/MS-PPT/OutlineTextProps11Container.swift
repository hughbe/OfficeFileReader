//
//  OutlineTextProps11Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.65 OutlineTextProps11Container
/// Referenced by: PP11DocBinaryTagExtension
/// A container record that specifies additional text properties for outline text.
public struct OutlineTextProps11Container {
    public let rh: RecordHeader
    public let rgOutlineTextProps11Entry: [OutlineTextProps11Entry]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_OutlineTextProps11.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .outlineTextProps11 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgOutlineTextProps11Entry (variable): An array of OutlineTextProps11Entry structures that specifies the text properties. The size, in bytes,
        /// of the array is specified by rh.recLen.
        var rgOutlineTextProps11Entry: [OutlineTextProps11Entry] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgOutlineTextProps11Entry.append(try OutlineTextProps11Entry(dataStream: &dataStream))
        }
        
        self.rgOutlineTextProps11Entry = rgOutlineTextProps11Entry
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
