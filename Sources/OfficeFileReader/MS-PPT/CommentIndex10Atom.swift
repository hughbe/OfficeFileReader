//
//  CommentIndex10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.19.3 CommentIndex10Atom
/// Referenced by: CommentIndex10Container
/// An atom record that specifies an index for deriving a color used to display the author’s presentation comments and an index for the last presentation
/// comment created by the author.
public struct CommentIndex10Atom {
    public let rh: RecordHeader
    public let colorIndex: Int32
    public let commentIndexSeed: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_CommentIndex10Atom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .commentIndex10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// colorIndex (4 bytes): A signed integer that specifies a zero-based index into the list of colors defined by the rendering application used for
        /// displaying the presentation comments created by the author. It MUST be greater than or equal to 0x00000000.
        self.colorIndex = try dataStream.read(endianess: .littleEndian)
        guard self.colorIndex >= 0x00000000 else {
            throw OfficeFileError.corrupted
        }
        
        /// commentIndexSeed (4 bytes): A signed integer that specifies a seed for creating a new index for a presentation comment created by the
        /// author. It MUST be greater than or equal to 0x00000000 and MUST be greater than or equal to the value of the commentAtom.index field
        /// of all Comment10Container records, where the author name specified by the commentAuthorAtom field of the Comment10Container
        /// record matches the author name specified by the authorNameAtom field of the CommentIndex10Container record that contains this
        /// CommentIndex10Atom record.
        self.commentIndexSeed = try dataStream.read(endianess: .littleEndian)
        guard self.commentIndexSeed >= 0x00000000 else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
