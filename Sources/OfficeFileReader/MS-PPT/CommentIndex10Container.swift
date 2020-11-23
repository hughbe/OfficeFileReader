//
//  CommentIndex10Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.19.1 CommentIndex10Container
/// Referenced by: PP10DocBinaryTagExtension
/// A container record that specifies information for an author who creates a presentation comment.
public struct CommentIndex10Container {
    public let rh: RecordHeader
    public let authorNameAtom: AuthorNameAtom?
    public let authorIndexAtom: CommentIndex10Atom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_CommentIndex10.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .commentIndex10 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.authorNameAtom = nil
            self.authorIndexAtom = nil
            return
        }
        
        /// authorNameAtom (variable): An optional AuthorNameAtom record that specifies the name of the author.
        if try dataStream.peekRecordHeader().recType == .cString {
            self.authorNameAtom = try AuthorNameAtom(dataStream: &dataStream)
        } else {
            self.authorNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.authorIndexAtom = nil
            return
        }
        
        /// authorIndexAtom (16 bytes): An optional CommentIndex10Atom record that specifies an index for deriving a color for the author’s
        /// presentation comments and an index for the last presentation comment created by the author.
        if try dataStream.peekRecordHeader().recType == .commentIndex10Atom {
            self.authorIndexAtom = try CommentIndex10Atom(dataStream: &dataStream)
        } else {
            self.authorIndexAtom = nil
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
