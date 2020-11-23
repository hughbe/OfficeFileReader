//
//  Comment10Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.25 Comment10Container
/// Referenced by: PP10SlideBinaryTagExtension
/// A container record that specifies a presentation comment.
public struct Comment10Container {
    public let rh: RecordHeader
    public let commentAuthorAtom: Comment10AuthorAtom?
    public let commentTextAtom: Comment10TextAtom?
    public let commentAuthorInitialsAtom: Comment10AuthorInitialAtom?
    public let commentAtom: Comment10Atom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_Comment10.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .comment10 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// commentAuthorAtom (variable): An optional Comment10AuthorAtom record that specifies the name of the author of the presentation
        /// comment.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .cString && nextAtom1.recInstance == 0x000 {
            self.commentAuthorAtom = try Comment10AuthorAtom(dataStream: &dataStream)
        } else {
            self.commentAuthorAtom = nil
        }
        
        /// commentTextAtom (variable): An optional Comment10TextAtom record that specifies the text of the presentation comment.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .cString && nextAtom2.recInstance == 0x001 {
            self.commentTextAtom = try Comment10TextAtom(dataStream: &dataStream)
        } else {
            self.commentTextAtom = nil
        }
        
        /// commentAuthorInitialsAtom (variable): An optional Comment10AuthorInitialAtom record that specifies the initials of the author of the
        /// presentation comment.
        let nextAtom3 = try dataStream.peekRecordHeader()
        if nextAtom3.recType == .cString && nextAtom3.recInstance == 0x002 {
            self.commentAuthorInitialsAtom = try Comment10AuthorInitialAtom(dataStream: &dataStream)
        } else {
            self.commentAuthorInitialsAtom = nil
        }
        
        /// commentAtom (36 bytes): A Comment10Atom record that specifies the settings for displaying the presentation comment.
        self.commentAtom = try Comment10Atom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
