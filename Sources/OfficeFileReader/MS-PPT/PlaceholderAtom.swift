//
//  PlaceholderAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.8 PlaceholderAtom
/// Referenced by: OfficeArtClientData
/// An atom record that specifies whether a shape is a placeholder shape. The number, position, and type of placeholder shapes are determined by the slide
/// layout as specified in the SlideAtom record.
/// Let the corresponding shape be specified by the OfficeArtSpContainer record ([MS-ODRAW] section 2.2.14) that contains this PlaceholderAtom record.
/// Let the corresponding slide be specified by the MainMasterContainer record (section 2.5.3), HandoutContainer record (section 2.5.8), SlideContainer
/// record (section 2.5.1), or NotesContainer record (section 2.5.6) that contains this PlaceholderAtom record.
public struct PlaceholderAtom {
    public let rh: RecordHeader
    public let position: Int32
    public let placementId: PlaceholderEnum
    public let size: PlaceholderSize
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_PlaceholderAtom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .placeholderAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// position (4 bytes): A signed integer that specifies an identifier for the placeholder shape. It SHOULD be unique among all PlaceholderAtom
        /// records contained in the corresponding slide. The value 0xFFFFFFFF specifies that the corresponding shape is not a placeholder shape.
        self.position = try dataStream.read(endianess: .littleEndian)
        
        /// placementId (1 byte): A PlaceholderEnum enumeration that specifies the type of the placeholder shape. The value MUST conform to the
        /// constraints as specified in the following table.
        /// PT_None MUST NOT be used for this field.
        /// PT_MasterTitle The corresponding shape contains the master title text. The corresponding slide MUST be a main master slide.
        /// PT_MasterBody The corresponding shape contains the master body text. The corresponding slide MUST be a main master slide.
        /// PT_MasterCenterTitle The corresponding shape contains the master center title text. The corresponding slide MUST be a title master slide.
        /// PT_MasterSubTitle The corresponding shape contains the master subtitle text. The corresponding slide MUST be a title master slide.
        /// PT_MasterNotesSlideImage The corresponding shape contains the shared properties for slide image shapes. The corresponding slide MUST be
        /// a notes master slide.
        /// PT_MasterNotesBody The corresponding shape contains the master body text. The corresponding slide MUST be a notes master slide.
        /// PT_MasterDate The corresponding shape contains the date text field. The corresponding slide MUST be a main master slide, title master slide,
        /// notes master slide, or handout master slide.
        /// PT_MasterSlideNumber The corresponding shape contains a slide number text field. The corresponding slide MUST be a main master slide,
        /// title master slide, notes master slide, or handout master slide.
        /// PT_MasterFooter The corresponding shape contains a footer text field. The corresponding slide MUST be a main master slide, title master slide,
        /// notes master slide, or handout master slide.
        /// PT_MasterHeader The corresponding shape contains a header text field. The corresponding slide MUST be a notes master slide or handout
        /// master slide.
        /// PT_NotesSlideImage The corresponding shape contains a presentation slide image. The corresponding slide MUST be a notes slide.
        /// PT_NotesBody The corresponding shape contains the notes text. The corresponding slide MUST be a notes slide.
        /// PT_Title The corresponding shape contains the title text. The corresponding slide MUST be a presentation slide.
        /// PT_Body The corresponding shape contains the body text. The corresponding slide MUST be a presentation slide.
        /// PT_CenterTitle The corresponding shape contains the center title text. The corresponding slide MUST be a presentation slide.
        /// PT_SubTitle The corresponding shape contains the sub-title text. The corresponding slide MUST be a presentation slide.
        /// PT_VerticalTitle The corresponding shape contains the title text with vertical text flow. The corresponding slide MUST be a presentation slide.
        /// PT_VerticalBody The corresponding shape contains the body text with vertical text flow. The corresponding slide  MUST be a presentation slide.
        /// PT_Object The corresponding shape contains a generic object. The corresponding slide MUST be a presentation slide.
        /// PT_Graph The corresponding shape contains a chart object. The corresponding slide MUST be a presentation slide.
        /// PT_Table The corresponding shape contains a table object. The corresponding slide MUST be a presentation slide.
        /// PT_ClipArt The corresponding shape contains a clipart object. The corresponding slide MUST be a presentation slide.
        /// PT_OrgChart The corresponding shape contains an organization chart object. The corresponding slide MUST be a presentation slide.
        /// PT_Media The corresponding shape contains a media object. The corresponding slide MUST be a presentation slide.
        /// PT_VerticalObject The corresponding shape contains a generic object with vertical text flow. The corresponding slide MUST be a presentation slide.
        /// PT_Picture The corresponding shape contains a picture object. The corresponding slide MUST be a presentation slide.
        let placementIdRaw: UInt8 = try dataStream.read()
        guard let placementId = PlaceholderEnum(rawValue: placementIdRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.placementId = placementId

        /// size (1 byte): A PlaceholderSize enumeration that specifies the preferred size of the placeholder shape.
        let sizeRaw: UInt8 = try dataStream.read()
        guard let size = PlaceholderSize(rawValue: sizeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.size = size
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
