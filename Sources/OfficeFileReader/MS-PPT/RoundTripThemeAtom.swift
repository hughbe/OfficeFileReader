//
//  RoundTripThemeAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.27 RoundTripThemeAtom
/// Referenced by: HandoutRoundTripAtom, NotesRoundTripAtom, RoundTripMainMasterRecord, RoundTripSlideRecord
/// An atom record that specifies the theme of the main master slide.
public struct RoundTripThemeAtom {
    public let rh: RecordHeader
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripTheme12Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripTheme12Atom else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// data (variable): An ECMA-376 document that specifies theme information. The package contains XML in the DrawingML Theme part
        /// containing a theme element that conforms to the schema specified by CT_OfficeStyleSheet as specified in [ECMA-376] Part 4:
        /// Markup Language Reference, section 5.1.8.9, or XML in the DrawingML Theme Override part containing a themeOverride element that
        /// conforms to the schema specified by CT_BaseStylesOverride as specified in [ECMA-376] Part 4: Markup Language Reference, section
        /// 5.1.8.12.
        self.data = try dataStream.readBytes(count: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
