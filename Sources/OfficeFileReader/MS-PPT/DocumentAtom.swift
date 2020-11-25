//
//  DocumentAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.2 DocumentAtom
/// Referenced by: DocumentContainer
/// An atom record that specifies information about the entire document
public struct DocumentAtom {
    public let rh: RecordHeader
    public let slideSize: PointStruct
    public let notesSize: PointStruct
    public let serverZoom: RatioStruct
    public let notesMasterPersistIdRef: PersistIdRef
    public let handoutMasterPersistIdRef: PersistIdRef
    public let firstSlideNumber: UInt16
    public let slideSizeType: SlideSizeEnum
    public let fSaveWithFonts: bool1
    public let fOmitTitlePlace: bool1
    public let fRightToLeft: bool1
    public let fShowComments: bool1
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x1.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_DocumentAtom (section 2.13.24).
        /// rh.recLen MUST be 0x00000028.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x1 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .documentAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000028 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// slideSize (8 bytes): A PointStruct structure (section 2.12.5) that specifies the dimensions of the presentation slides in master units. Sub-fields
        /// are further specified in the following table.
        /// Field Meaning
        /// slideSize.x Specifies the width. It MUST be greater than or equal to 0x00000240 and less than or equal to 0x00007E00.
        /// slideSize.y Specifies the height. It MUST be greater than or equal to 0x00000240 and less than or equal to 0x00007E00.
        let slideSize = try PointStruct(dataStream: &dataStream)
        guard slideSize.x >= 0x00000240 && slideSize.x <= 0x00007E00 else {
            throw OfficeFileError.corrupted
        }
        guard slideSize.y >= 0x00000240 && slideSize.y <= 0x00007E00 else {
            throw OfficeFileError.corrupted
        }
        
        self.slideSize = slideSize
        
        /// notesSize (8 bytes): A PointStruct structure that specifies the dimensions of the notes slides and handout slides in master units. Sub-fields
        /// are further specified in the following table.
        /// Field Meaning
        /// notesSize.x Specifies the width. It MUST be greater than or equal to 0x00000240 and less than or equal to 0x00007E00.
        /// notesSize.y Specifies the height. It MUST be greater than or equal to 0x00000240 and less than or equal to 0x00007E00.
        let notesSize = try PointStruct(dataStream: &dataStream)
        guard notesSize.x >= 0x00000240 && notesSize.x <= 0x00007E00 else {
            throw OfficeFileError.corrupted
        }
        guard notesSize.y >= 0x00000240 && notesSize.y <= 0x00007E00 else {
            throw OfficeFileError.corrupted
        }
        
        self.notesSize = notesSize
        
        /// serverZoom (8 bytes): A RatioStruct structure (section 2.12.6) that specifies a zoom level for visual representations of the document in Object
        /// Linking and Embedding (OLE) scenarios. The ratio specified by this field MUST be greater than zero.
        self.serverZoom = try RatioStruct(dataStream: &dataStream)
        guard self.serverZoom.ratio > 0 else {
            throw OfficeFileError.corrupted
        }
        
        /// notesMasterPersistIdRef (4 bytes): A PersistIdRef (section 2.2.21) that specifies the value to look up in the persist object directory to find the
        /// offset of a NotesContainer record (section 2.5.6) that specifies the notes master slide.
        self.notesMasterPersistIdRef = try PersistIdRef(dataStream: &dataStream)
        
        /// handoutMasterPersistIdRef (4 bytes): A PersistIdRef that specifies the value to look up in the persist object directory to find the offset of a
        /// HandoutContainer record (section 2.5.8) that specifies the handout master slide.
        self.handoutMasterPersistIdRef = try PersistIdRef(dataStream: &dataStream)
        
        /// firstSlideNumber (2 bytes): An unsigned integer that specifies the starting number for numbering slides. It MUST be less than 10000.
        self.firstSlideNumber = try dataStream.read(endianess: .littleEndian)
        
        /// slideSizeType (2 bytes): A SlideSizeEnum enumeration (section 2.13.26) that specifies the type of a presentation slide size.
        guard let slideSizeType = SlideSizeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.slideSizeType = slideSizeType
        
        /// fSaveWithFonts (1 byte): A bool1 (section 2.2.2) that specifies whether fonts are embedded in the document.
        self.fSaveWithFonts = try bool1(dataStream: &dataStream)
        
        /// fOmitTitlePlace (1 byte): A bool1 that specifies whether placeholder shapes on the title slide are not displayed.
        self.fOmitTitlePlace = try bool1(dataStream: &dataStream)
        
        /// fRightToLeft (1 byte): A bool1 that specifies whether the user interface displays the document optimized for right-to-left languages.
        self.fRightToLeft = try bool1(dataStream: &dataStream)
        
        /// fShowComments (1 byte): A bool1 that specifies whether presentation comments are displayed.
        self.fShowComments = try bool1(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
