//
//  NotesTextViewInfoContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.4 NotesTextViewInfoContainer
/// Referenced by: DocInfoListSubContainerOrAtom
/// A container record that specifies display preferences for when a user interface shows the presentation in a manner optimized for the display of the
/// text on the notes slides.
public struct NotesTextViewInfoContainer {
    public let rh: RecordHeader
    public let zoomViewInfo: ZoomViewInfoAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be RT_NotesTextViewInfo9 (section 2.13.24).
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .notesTextViewInfo9 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.zoomViewInfo = nil
            return
        }
        
        /// zoomViewInfo (60 bytes): An optional ZoomViewInfoAtom record that specifies origin and scaling information.
        self.zoomViewInfo = try ZoomViewInfoAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
