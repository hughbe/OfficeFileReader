//
//  RoundTripColorMappingAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.9 RoundTripColorMappingAtom
/// Referenced by: HandoutRoundTripAtom, NotesRoundTripAtom, RoundTripMainMasterRecord, RoundTripSlideRecord
/// An atom record that specifies the color mapping for a slide.
public struct RoundTripColorMappingAtom {
    public let rh: RecordHeader
    public let colorMapping: Utf8UnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripColorMapping12Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripColorMapping12Atom else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// colorMapping (variable): A Utf8UnicodeString that specifies the color mapping. Either the XML in this string contains a clrMap element that
        /// conforms to the schema specified by CT_ColorMapping as specified in [ECMA-376] Part 4: Markup Language Reference, section
        /// 4.4.1.6, or the XML contains a clrMapOverride element that conforms to the schema specified by CT_ColorMappingOverride as specified in
        /// [ECMA-376] Part 4: Markup Language Reference, section 4.4.1.7.
        self.colorMapping = try Utf8UnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
