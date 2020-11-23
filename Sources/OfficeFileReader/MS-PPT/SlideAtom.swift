//
//  SlideAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.10 SlideAtom
/// Referenced by: MainMasterContainer, SlideContainer
/// An atom record that specifies information about a slide.
/// Let the corresponding slide be specified by the SlideContainer record (section 2.5.1) or MainMasterContainer record (section 2.5.3) that contains this
/// SlideAtom record.
public struct SlideAtom {
    public let rh: RecordHeader
    public let geom: SlideLayoutType
    public let rgPlaceholderTypes: [PlaceholderEnum]
    public let masterIdRef: MasterIdRef
    public let notesIdRef: NotesIdRef
    public let slideFlags: SlideFlags
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x2.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlideAtom.
        /// rh.recLen MUST be 0x00000018.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x2 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000018 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// geom (4 bytes): A SlideLayoutType enumeration that specifies a hint to the user interface which slide layout exists on the corresponding slide.
        /// A slide layout specifies the type and number of placeholder shapes on a slide. A placeholder shape is specified as an OfficeArtSpContainer
        /// ([MS-ODRAW] section 2.2.14) that contains a PlaceholderAtom record with a pos field not equal to 0xFFFFFFFF. The placementId field of
        /// the PlaceholderAtom record specifies the placeholder shape type. Additional constraints on the type and number of placeholder shapes are
        /// specified in the following table.
        /// Value Placeholder shapes
        /// SL_TitleSlide The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with a
        /// placementId equal to PT_CenterTitle, and at most one PlaceholderAtom record with a placementId equal to PT_SubTitle, and MUST NOT
        /// contain any other PlaceholderAtom record with a placementId unequal to 0xFFFFFFFF.
        /// SL_TitleBody If the corresponding slide is a main master slide it MUST contain one PlaceholderAtom record with a placementId equal to
        /// PT_MasterTitle, one PlaceholderAtom record with a placementId equal to PT_MasterBody, one PlaceholderAtom record with a placementId
        /// equal to PT_MasterDate, one PlaceholderAtom record with a placementId equal to PT_MasterFooter, and one PlaceholderAtom record with
        /// a placementId equal to PT_MasterSlideNumber, and MUST NOT contain any other PlaceholderAtom record with a placementId unequal to
        /// 0xFFFFFFFF.
        /// If the corresponding slide is a presentation slide it MUST contain at most one PlaceholderAtom record with placementId equal to PT_Title
        /// and at most one PlaceholderAtom record with placementId equal to PT_Body, PT_Table, PT_OrgChart, PT_Graph, PT_Object or
        /// PT_VerticalBody, and MUST NOT contain any other PlaceholderAtom record with a placementId unequal to 0xFFFFFFFF.
        /// SL_MasterTitle The corresponding slide MUST be a title master slide and MUST contain one PlaceholderAtom record with a placementId
        /// equal to PT_MasterCenterTitle, one PlaceholderAtom record with a placementId equal to PT_MasterSubTitle, at most one PlaceholderAtom
        /// record with a placementId equal to PT_MasterDate, at most one PlaceholderAtom record with a placementId equal to PT_MasterFooter and
        /// at most one PlaceholderAtom record with a placementId equal to PT_MasterSlideNumber, and MUST NOT contain any other PlaceholderAtom
        /// record with a placementId unequal to 0xFFFFFFFF.
        /// SL_TitleOnly The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with a
        /// placementId equal to PT_Title, and MUST NOT contain any other PlaceholderAtom record with a placementId unequal 0xFFFFFFFF.
        /// SL_TwoColumns The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with a
        /// placementId equal to PT_Title, and any combination of zero, one, or two PlaceholderAtom records with placementId fields. The following
        /// list shows the possible combinations:
        ///  PT_Body and PT_Body
        ///  PT_Body and PT_Graph
        ///  PT_Graph and PT_Body
        ///  PT_Body and PT_ClipArt
        ///  PT_ClipArt and PT_Body
        ///  PT_Body and PT_Object
        ///  PT_Object and PT_Body
        ///  PT_Body and PT_Media
        ///  PT_Media and PT_Body
        ///  PT_ClipArt and PT_VerticalBody
        ///  PT_Object and PT_Object
        ///  PT_Body
        ///  PT_Graph
        ///  PT_ClipArt
        ///  PT_Object
        ///  PT_Media
        ///  PT_VerticalBody
        /// It MUST NOT contain any other PlaceholderAtom record with a placementId unequal to 0xFFFFFFFF.
        /// SL_TwoRows The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with a
        /// placementId equal to PT_Title, at most one PlaceholderAtom record with a placementId equal to PT_Body, at most one PlaceholderAtom
        /// record with a placementId equal to PT_Object, and MUST NOT contain any other PlaceholderAtom record with a placementId unequal to
        /// 0xFFFFFFFF.
        /// SL_ColumnTwoRows The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with
        /// a placementId equal to PT_Title, at most one PlaceholderAtom record with a placementId equal to PT_Body or PT_Object, at most two
        /// additional PlaceholderAtom records with placementId fields equal to PT_Object, and MUST NOT contain any other PlaceholderAtom record
        /// with a placementId unequal to 0xFFFFFFFF.
        /// SL_TwoRowsColumn The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with
        /// a placementId equal to PT_Title, at most two PlaceholderAtom records with placementId fields equal to PT_Object, at most one additional
        /// PlaceholderAtom record with a placementId equal to PT_Body or PT_Object, and MUST NOT contain any other PlaceholderAtom record
        /// with a placementId unequal to 0xFFFFFFFF.
        /// SL_TwoColumnsRow The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with
        /// a placementId equal to PT_Title, at most two PlaceholderAtom records with placementId fields equal to PT_Object, at most one
        /// PlaceholderAtom record with a placementId equal to PT_Body, and MUST NOT contain any other PlaceholderAtom record with a
        /// placementId unequal to 0xFFFFFFFF.
        /// SL_FourObjects The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with a
        /// placementId equal to PT_Title, at most four PlaceholderAtom records with placementId fields equal to PT_Object, and MUST NOT contain
        /// any other PlaceholderAtom record with a placementId unequal to 0xFFFFFFFF.
        /// SL_BigObject The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with a
        /// placementId equal to PT_Object, and MUST NOT contain any other PlaceholderAtom record with a placementId unequal to 0xFFFFFFFF.
        /// SL_Blank The corresponding slide MUST be a presentation slide. There are five layouts supported with this value:
        /// Layout 1: The corresponding slide MUST NOT contain any PlaceholderAtom records with a placementId unequal to 0xFFFFFFFF.
        /// Layout 2: The corresponding slide MUST contain at most one PlaceholderAtom record with a placementId equal to PT_Title, at most one
        /// PlaceholderAtom record with a placementId equal to PT_Body, and MUST NOT contain any other PlaceholderAtom record with a
        /// placementId unequal to 0xFFFFFFFF.
        /// Layout 3: The corresponding slide MUST contain at most one PlaceholderAtom record with a placementId equal to PT_Title, at most two
        /// PlaceholderAtom records with a placementId equal to PT_Body, at most one PlaceholderAtom record with a placementId equal to
        /// PT_Object, and MUST NOT contain any other PlaceholderAtom record with a placementId unequal to 0xFFFFFFFF.
        /// Layout 4: The corresponding slide MUST contain at most one PlaceholderAtom record with a placementId equal to PT_Title, at most one
        /// PlaceholderAtom record with a placementId equal to PT_Object, at most one PlaceholderAtom record with a placementId equal to PT_Body,
        /// and MUST NOT contain any other PlaceholderAtom record with a placementId unequal to 0xFFFFFFFF.
        /// Layout 5: The corresponding slide MUST contain at most one PlaceholderAtom record with a placementId equal to PT_Title, at most one
        /// PlaceholderAtom record with a placementId equal to PT_Picture, at most one PlaceholderAtom record with a placementId equal to PT_Body,
        /// and MUST NOT contain any other PlaceholderAtom record with a placementId unequal to 0xFFFFFFFF.
        /// SL_VerticalTitleBody The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with
        /// placementId equal to PT_VerticalTitle, at most one PlaceholderAtom record with placementId equal to PT_VerticalBody, and MUST NOT
        /// contain any other PlaceholderAtom record with a placementId unequal to 0xFFFFFFFF.
        /// SL_VerticalTwoRows The corresponding slide MUST be a presentation slide and MUST contain at most one PlaceholderAtom record with
        /// placementId equal to PT_VerticalTitle, at most one PlaceholderAtom record with placementId equal to PT_VerticalBody, at most one
        /// PlaceholderAtom record with placementId equal to PT_Graph, and MUST NOT contain any other PlaceholderAtom record with a placementId
        /// unequal to 0xFFFFFFFF.
        guard let geom = SlideLayoutType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }

        self.geom = geom
        
        /// rgPlaceholderTypes (8 bytes): An array of PlaceholderEnum (section 2.13.21) enumeration values that specifies a hint to the user interface
        /// which placeholder shapes exist on the corresponding slide. The count of items in the array MUST be 8. The sequence of array items
        /// MUST be a valid PlaceholderList as specified by the ABNF (specified in [RFC5234]) grammars in the following table.
        /// Value of geom. Value of rgPlaceholderTypes
        /// SL_TitleSlide
        /// PlaceholderList = ( Variant1 / Variant2 )6PT_None
        /// Variant1 = PT_CenterTitle PT_SubTitle
        /// Variant2 = PT_Title PT_Body
        /// The Variant2 rule SHOULD NOT be used.
        /// SL_TitleBody
        /// PlaceholderList = MasterVariant / SlideVariant
        /// MasterVariant = PT_MasterTitle PT_MasterBody PT_MasterDate
        /// PT_MasterFooter PT_MasterSlideNumber 3PT_None
        /// SlideVariant = PT_Title ( PT_Body / PT_Table / PT_OrgChart
        /// / PT_Graph / PT_Object / PT_VerticalBody )6PT_None
        /// SL_MasterTitle
        /// PlaceholderList = PT_MasterCenterTitle PT_MasterSubTitle (
        /// Variant1 / Variant2 )
        /// Variant1 = PT_MasterDate PT_MasterFooter
        /// PT_MasterSlideNumber 3PT_None
        /// Variant2 = 6PT_None
        /// The Variant2 rule SHOULD NOT be used.
        /// SL_TitleOnly
        /// PlaceholderList = PT_Title 7PT_None
        /// SL_TwoColumns
        /// PlaceholderList = PT_Title ( BodyBody / BodyGraph / GraphBody / BodyClipart / ClipartBody / BodyObject / ObjectBody /
        /// BodyMedia / MediaBody / ClipartVBody / ObjectObject )
        /// 5PT_None
        /// BodyBody = PT_Body PT_Body
        /// BodyGraph = PT_Body PT_Graph
        /// GraphBody = PT_Graph PT_Body
        /// BodyClipart = PT_Body PT_ClipArt
        /// ClipartBody = PT_ClipArt PT_Body
        /// BodyObject = PT_Body PT_Object
        /// ObjectBody = PT_Object PT_Body
        /// BodyMedia = PT_Body PT_Media
        /// MediaBody = PT_Media PT_Body
        /// ClipartVBody = PT_ClipArt PT_VerticalBody
        /// ObjectObject = PT_Object PT_Object
        /// SL_TwoRows
        /// PlaceholderList = PT_Title ( BodyObject / ObjectBody )
        /// 5PT_None
        /// BodyObject = PT_Body PT_Object
        /// ObjectBody = PT_Object PT_Body
        /// SL_ColumnTwoRows
        /// PlaceholderList = PT_Title ( PT_Body / PT_Object ) 2PT_Object
        /// 4PT_None
        /// SL_TwoRowsColumn
        /// PlaceholderList = PT_Title 2PT_Object ( PT_Body / PT_Object )
        /// 4PT_None
        /// SL_TwoColumnsRow
        /// PlaceholderList = PT_Title 2PT_Object PT_Body 4PT_None
        /// SL_FourObjects
        /// PlaceholderList = PT_Title 4PT_Object 3PT_None
        /// SL_BigObject
        /// PlaceholderList = PT_Object 7PT_None
        /// SL_Blank
        /// PlaceholderList = AllBlank / BlankVariants
        /// AllBlank = 8PT_None
        /// BlankVariants = PT_Title ( Variant1 / Variant2 / Variant3 / Variant4 ) 3PT_None
        /// Variant1 = PT_Body 3PT_None
        /// Variant2 = PT_Body PT_Object PT_Body PT_Object
        /// Variant3 = PT_Object PT_Body 2PT_None
        /// Variant4 = PT_Picture PT_Body 2PT_None
        /// The BlankVariants, Variant1, Variant2, Variant3, and Variant4 rules SHOULD NOT be used.
        /// SL_VerticalTitleBody
        /// PlaceholderList = PT_VerticalTitle PT_VerticalBody 6PT_None
        /// SL_VerticalTwoRows
        /// PlaceholderList = PT_VerticalTitle PT_VerticalBody PT_Graph 5PT_None
        var rgPlaceholderTypes: [PlaceholderEnum] = []
        rgPlaceholderTypes.reserveCapacity(8)
        for _ in 0..<8 {
            guard let value = PlaceholderEnum(rawValue: try dataStream.read()) else {
                throw OfficeFileError.corrupted
            }

            rgPlaceholderTypes.append(value)
        }
        
        self.rgPlaceholderTypes = rgPlaceholderTypes
        
        /// masterIdRef (4 bytes): A MasterIdRef that specifies the identifier for the main master slide or title master slide that the corresponding slide
        /// follows. The value 0x00000000 specifies that the corresponding slide does not follow a main master slide or a title master slide. It MUST
        /// NOT be 0x00000000 if the record that contains this SlideAtom record is a SlideContainer section. It MUST be 0x00000000 if the record
        /// that contains this SlideAtom record is a MainMasterContainer record.
        self.masterIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// notesIdRef (4 bytes): A NotesIdRef that specifies the identifier for the notes slide of the corresponding slide. The value 0x00000000 specifies
        /// that no notes slide exists. It MUST be 0x00000000 if the record that contains this SlideAtom record is a MainMasterContainer record.
        self.notesIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// slideFlags (2 bytes): A SlideFlags structure that specifies which content the corresponding slide follows from its main master slide.
        self.slideFlags = try SlideFlags(dataStream: &dataStream)
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
