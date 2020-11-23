//
//  SlideSchemeColorSchemeAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.14 SlideSchemeColorSchemeAtom
/// Referenced by: HandoutContainer, MainMasterContainer, NotesContainer, SlideContainer
/// A container record that specifies the color scheme used by a slide.
public struct SlideSchemeColorSchemeAtom {
    public let rh: RecordHeader
    public let rgSchemeColor: [ColorStruct]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be RT_ColorSchemeAtom.
        /// rh.recLen MUST be 0x00000020.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .colorSchemeAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000020 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgSchemeColor (32 bytes): An array of ColorStruct structures that specifies a list of colors in the color scheme. The count of items in this
        /// array MUST be 8.
        var rgSchemeColor: [ColorStruct] = []
        rgSchemeColor.reserveCapacity(8)
        for _ in 0..<8 {
            rgSchemeColor.append(try ColorStruct(dataStream: &dataStream))
        }
        
        self.rgSchemeColor = rgSchemeColor
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
