//
//  MouseOverTextInteractiveInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.58 MouseOverTextInteractiveInfoAtom
/// Referenced by: TextInteractiveInfoInstance
/// An atom record that specifies a text range that anchors the preceding MouseOverInteractiveInfoContainer record in the containing OfficeArtClientTextbox
/// record or SlideListWithTextContainer record (section 2.4.14.3).
/// Let the corresponding text be specified by the TextHeaderAtom record that most closely precedes this MouseOverTextInteractiveInfoAtom record.
public struct MouseOverTextInteractiveInfoAtom {
    public let rh: RecordHeader
    public let range: TextRange
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be an RT_TextInteractiveInfoAtom.
        /// rh.recLen MUST be 0x00000008
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textInteractiveInfoAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// range (8 bytes): A TextRange structure that specifies the anchor in the corresponding text.
        self.range = try TextRange(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
