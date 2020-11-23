//
//  RTFDateTimeMCAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.52 RTFDateTimeMCAtom
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// An atom record that specifies a Rich Text Format (RTF) datetime metacharacter. RTF format is specified by [MSFT-RTF].
/// The metacharacter is replaced by the datetime, using the format specified in the format string in this metacharacter.
/// Let the corresponding text be specified by the TextHeaderAtom record that most closely precedes this RTFDateTimeMCAtom record.
public struct RTFDateTimeMCAtom {
    public let rh: RecordHeader
    public let position: TextPosition
    public let format: String
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RtfDateTimeMetaCharAtom.
        /// rh.recLen MUST be 0x00000084.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .rtfDateTimeMetaCharAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000084 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// position (4 bytes): A TextPosition that specifies the position of the metacharacter in the corresponding text.
        self.position = try TextPosition(dataStream: &dataStream)
        
        /// format (128 bytes): A char2 that specifies the date and time format in RTF.
        self.format = try dataStream.readString(count: 12, encoding: .utf16LittleEndian)!
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
