//
//  RecordType.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.13.24 RecordType
/// Referenced by: RecordHeader
/// An enumeration that specifies the record type of an atom record or a container record.
public enum RecordType: UInt16 {
    /// RT_Document 0x03E8 Specifies a DocumentContainer (section 2.4.1).
    case document = 0x03E8
    
    /// RT_DocumentAtom 0x03E9 Specifies a DocumentAtom (section 2.4.2).
    case documentAtom = 0x03E9

    /// RT_EndDocumentAtom 0x03E A Specifies a EndDocumentAtom record (section 2.4.13).
    case endDocumentAtom = 0x03EA

    /// RT_Slide 0x03EE Specifies a SlideContainer (section 2.5.1).
    case slide = 0x03EE

    /// RT_SlideAtom 0x03EF Specifies a SlideAtom.
    case slideAtom = 0x03EF

    /// RT_Notes 0x03F0 Specifies a NotesContainer (section 2.5.6).
    case notes = 0x03F0

    /// RT_NotesAtom 0x03F1 Specifies a NotesAtom.
    case notesAtom = 0x03F1

    /// RT_Environment 0x03F2 Specifies a DocumentTextInfoContainer record (section 2.9.1).
    case environment = 0x03F2

    /// RT_SlidePersistAtom 0x03F3 Specifies a MasterPersistAtom (section 2.4.14.2), SlidePersistAtom (section 2.4.14.5), or NotesPersistAtom (section 2.4.14.7).
    case slidePersistAtom = 0x03F3

    /// RT_MainMaster 0x03F8 Specifies a MainMasterContainer (section 2.5.3).
    case mainMaster = 0x03F8

    /// RT_SlideShowSlideInfoAtom 0x03F9 Specifies a SlideShowSlideInfoAtom.
    case slideShowSlideInfoAtom = 0x03F9

    /// RT_SlideViewInfo 0x03FA Specifies a SlideViewInfoContainer (section 2.4.21.9) or NotesViewInfoContainer (section 2.4.21.12).
    case slideViewInfo = 0x03FA

    /// RT_GuideAtom 0x03FB Specifies a GuideAtom.
    case guideAtom = 0x03FB

    /// RT_ViewInfoAtom 0x03FD Specifies a ZoomViewInfoAtom or NoZoomViewInfoAtom.
    case viewInfoAtom = 0x03FD

    /// RT_SlideViewInfoAtom 0x03FE Specifies a SlideViewInfoAtom.
    case slideViewInfoAtom = 0x03FE

    /// RT_VbaInfo 0x03FF Specifies a VBAInfoContainer (section 2.4.10).
    case vbaInfo = 0x03FF

    /// RT_VbaInfoAtom 0x0400 Specifies a VBAInfoAtom.
    case vbaInfoAtom = 0x0400

    /// RT_SlideShowDocInfoAtom 0x0401 Specifies a SlideShowDocInfoAtom record (section 2.6.1).
    case slideShowDocInfoAtom = 0x0401

    /// RT_Summary 0x0402 Specifies a SummaryContainer record (section 2.4.22.3).
    case summary = 0x0402

    /// RT_DocRoutingSlipAtom 0x0406 Specifies a DocRoutingSlipAtom record (section 2.11.1).
    case docRoutingSlipAtom = 0x0406

    /// RT_OutlineViewInfo 0x0407 Specifies an OutlineViewInfoContainer (section 2.4.21.6).
    case outlineViewInfo = 0x0407

    /// RT_SorterViewInfo 0x0408 Specifies a SorterViewInfoContainer record (section 2.4.21.13).
    case sorterViewInfo = 0x0408

    /// RT_ExternalObjectList 0x0409 Specifies an ExObjListContainer (section 2.10.1)
    case externalObjectList = 0x0409

    /// RT_ExternalObjectListAtom 0x040 A Specifies an ExObjListAtom.
    case externalObjectListAtom = 0x040A

    /// RT_DrawingGroup 0x040B Specifies a DrawingGroupContainer (section 2.4.3).
    case drawingGroup = 0x040B

    /// RT_Drawing 0x040C Specifies a DrawingContainer (section 2.5.13).
    case drawing = 0x040C

    /// RT_GridSpacing10Atom 0x040D Specifies a GridSpacing10Atom.
    case gridSpacing10Atom = 0x040D

    /// RT_RoundTripTheme12Atom 0x040E Specifies a RoundTripThemeAtom.
    case roundTripTheme12Atom = 0x040E

    /// RT_RoundTripColorMapping12Atom 0x040F Specifies a RoundTripColorMappingAtom.
    case roundTripColorMapping12Atom = 0x040F

    /// RT_NamedShows 0x0410 Specifies a NamedShowsContainer (section 2.6.2).
    case namedShows = 0x0410

    /// RT_NamedShow 0x0411 Specifies a NamedShowContainer.
    case namedShow = 0x0411

    /// RT_NamedShowSlidesAtom 0x0412 Specifies a NamedShowSlidesAtom.
    case namedShowSlidesAtom = 0x0412

    /// RT_NotesTextViewInfo9 0x0413 Specifies a NotesTextViewInfoContainer (section 2.4.21.4).
    case notesTextViewInfo9 = 0x0413

    /// RT_NormalViewSetInfo9 0x0414 Specifies a NormalViewSetInfoContainer (section 2.4.21.2).
    case normalViewSetInfo9 = 0x0414

    /// RT_NormalViewSetInfo9Atom 0x0415 Specifies a NormalViewSetInfoAtom.
    case normalViewSetInfo9Atom = 0x0415

    /// RT_RoundTripOriginalMainMasterId12Atom 0x041C Specifies a RoundTripOriginalMainMasterId12Atom.
    case roundTripOriginalMainMasterId12Atom = 0x041C

    /// RT_RoundTripCompositeMasterId12Atom 0x041D Specifies a RoundTripCompositeMasterId12Atom.
    case roundTripCompositeMasterId12Atom = 0x041D

    /// RT_RoundTripContentMasterInfo12Atom 0x041E Specifies a RoundTripContentMasterInfo12Atom.
    case roundTripContentMasterInfo12Atom = 0x041E

    /// RT_RoundTripShapeId12Atom 0x041F Specifies a RoundTripShapeId12Atom.
    case roundTripShapeId12Atom = 0x041F

    /// RT_RoundTripHFPlaceholder12Atom 0x0420 Specifies a RoundTripHFPlaceholder12Atom.
    case roundTripHFPlaceholder12Atom = 0x0420

    /// RT_RoundTripContentMasterId12Atom 0x0422 Specifies a RoundTripContentMasterId12Atom.
    case roundTripContentMasterId12Atom = 0x0422

    /// RT_RoundTripOArtTextStyles12Atom 0x0423 Specifies a RoundTripOArtTextStyles12Atom.
    case roundTripOArtTextStyles12Atom = 0x0423

    /// RT_RoundTripHeaderFooterDefaults12Atom 0x0424 Specifies a RoundTripHeaderFooterDefaults12Atom.
    case roundTripHeaderFooterDefaults12Atom = 0x0424

    /// RT_RoundTripDocFlags12Atom 0x0425 Specifies a RoundTripDocFlags12Atom.
    case roundTripDocFlags12Atom = 0x0425

    /// RT_RoundTripShapeCheckSumForCL12Atom 0x0426 Specifies a RoundTripShapeCheckSumForCustomLayouts12AtomAtom.
    case roundTripShapeCheckSumForCL12Atom = 0x0426

    /// RT_RoundTripNotesMasterTextStyles12Atom 0x0427 Specifies a RoundTripNotesMasterTextStyles12Atom.
    case roundTripNotesMasterTextStyles12Atom = 0x0427

    /// RT_RoundTripCustomTableStyles12Atom 0x0428 Specifies a RoundTripCustomTableStyles12Atom record (section 2.11.13).
    case roundTripCustomTableStyles12Atom = 0x0428

    /// RT_List 0x07D0 Specifies a DocInfoListContainer (section 2.4.4).
    case list = 0x07D0

    /// RT_FontCollection 0x07D5 Specifies a FontCollectionContainer (section 2.9.8).
    case fontCollection = 0x07D5

    /// RT_FontCollection10 0x07D6 Specifies a FontCollection10Container (section 2.9.11).
    case fontCollection10 = 0x07D6

    /// RT_BookmarkCollection 0x07E3 Specifies a BookmarkCollectionContainer.
    case bookmarkCollection = 0x07E3

    /// RT_SoundCollection 0x07E4 Specifies a SoundCollectionContainer record(section 2.4.16.1).
    case soundCollection = 0x07E4

    /// RT_SoundCollectionAtom 0x07E5 Specifies a SoundCollectionAtom.
    case soundCollectionAtom = 0x07E5

    /// RT_Sound 0x07E6 Specifies a SoundContainer (section 2.4.16.3).
    case sound = 0x07E6

    /// RT_SoundDataBlob 0x07E7 Specifies a SoundDataBlob.
    case soundDataBlob = 0x07E7

    /// RT_BookmarkSeedAtom 0x07E9 Specifies a BookmarkSeedAtom.
    case bookmarkSeedAtom = 0x07E9

    /// RT_ColorSchemeAtom 0x07F0 Specifies a SlideSchemeColorSchemeAtom orSchemeListElementColorSchemeAtom.
    case colorSchemeAtom = 0x07F0

    /// RT_BlipCollection9 0x07F8 Specifies a BlipCollection9Container (section 2.9.72).
    case blipCollection9 = 0x07F8

    /// RT_BlipEntity9Atom 0x07F9 Specifies a BlipEntityAtom.
    case blipEntity9Atom = 0x07F9

    /// RT_ExternalObjectRefAtom 0x0BC1 Specifies an ExObjRefAtom.
    case externalObjectRefAtom = 0x0BC1

    /// RT_PlaceholderAtom 0x0BC3 Specifies a PlaceholderAtom.
    case placeholderAtom = 0x0BC3

    /// RT_ShapeAtom 0x0BDB Specifies a ShapeFlagsAtom.
    case shapeAtom = 0x0BDB

    /// RT_ShapeFlags10Atom 0x0BDC Specifies a ShapeFlags10Atom.
    case shapeFlags10Atom = 0x0BDC

    /// RT_RoundTripNewPlaceholderId12Atom 0x0BDD Specifies a RoundTripNewPlaceholderId12Atom.
    case roundTripNewPlaceholderId12Atom = 0x0BDD

    /// RT_OutlineTextRefAtom 0x0F9E Specifies an OutlineTextRefAtom.
    case outlineTextRefAtom = 0x0F9E

    /// RT_TextHeaderAtom 0x0F9F Specifies a TextHeaderAtom.
    case textHeaderAtom = 0x0F9F

    /// RT_TextCharsAtom 0x0FA0 Specifies a TextCharsAtom.
    case textCharsAtom = 0x0FA0

    /// RT_StyleTextPropAtom 0x0FA1 Specifies a StyleTextPropAtom.
    case styleTextPropAtom = 0x0FA1

    /// RT_MasterTextPropAtom 0x0FA2 Specifies a MasterTextPropAtom.
    case masterTextPropAtom = 0x0FA2

    /// RT_TextMasterStyleAtom 0x0FA3 Specifies a TextMasterStyleAtom.
    case textMasterStyleAtom = 0x0FA3

    /// RT_TextCharFormatExceptionAtom 0x0FA4 Specifies a TextCFExceptionAtom.
    case textCharFormatExceptionAtom = 0x0FA4

    /// RT_TextParagraphFormatExceptionAtom 0x0FA5 Specifies a TextPFExceptionAtom.
    case textParagraphFormatExceptionAtom = 0x0FA5

    /// RT_TextRulerAtom 0x0FA6 Specifies a TextRulerAtom.
    case textRulerAtom = 0x0FA6

    /// RT_TextBookmarkAtom 0x0FA7 Specifies a TextBookmarkAtom.
    case textBookmarkAtom = 0x0FA7

    /// RT_TextBytesAtom 0x0FA8 Specifies a TextBytesAtom.
    case textBytesAtom = 0x0FA8

    /// RT_TextSpecialInfoDefaultAtom 0x0FA9 Specifies a TextSIExceptionAtom.
    case textSpecialInfoDefaultAtom = 0x0FA9

    /// RT_TextSpecialInfoAtom 0x0FAA Specifies a TextSpecialInfoAtom.
    case textSpecialInfoAtom = 0x0FAA

    /// RT_DefaultRulerAtom 0x0FAB Specifies a DefaultRulerAtom.
    case defaultRulerAtom = 0x0FAB

    /// RT_StyleTextProp9Atom 0x0FAC Specifies a StyleTextProp9Atom.
    case styleTextProp9Atom = 0x0FAC

    /// RT_TextMasterStyle9Atom 0x0FAD Specifies a TextMasterStyle9Atom.
    case textMasterStyle9Atom = 0x0FAD

    /// RT_OutlineTextProps9 0x0FAE Specifies an OutlineTextProps9Container.
    case outlineTextProps9 = 0x0FAE

    /// RT_OutlineTextPropsHeader9Atom 0x0FAF Specifies an OutlineTextPropsHeaderExAtom.
    case outlineTextPropsHeader9Atom = 0x0FAF

    /// RT_TextDefaults9Atom 0x0FB0 Specifies a TextDefaults9Atom.
    case textDefaults9Atom = 0x0FB0

    /// RT_StyleTextProp10Atom 0x0FB1 Specifies a StyleTextProp10Atom.
    case styleTextProp10Atom = 0x0FB1

    /// RT_TextMasterStyle10Atom 0x0FB2 Specifies a TextMasterStyle10Atom.
    case textMasterStyle10Atom = 0x0FB2

    /// RT_OutlineTextProps10 0x0FB3 Specifies an OutlineTextProps10Container.
    case outlineTextProps10 = 0x0FB3

    /// RT_TextDefaults10Atom 0x0FB4 Specifies a TextDefaults10Atom.
    case textDefaults10Atom = 0x0FB4

    /// RT_OutlineTextProps11 0x0FB5 Specifies an OutlineTextProps11Container.
    case outlineTextProps11 = 0x0FB5

    /// RT_StyleTextProp11Atom 0x0FB6 Specifies a StyleTextProp11Atom.
    case styleTextProp11Atom = 0x0FB6

    /// RT_FontEntityAtom 0x0FB7 Specifies a FontEntityAtom.
    case fontEntityAtom = 0x0FB7

    /// RT_FontEmbedDataBlob 0x0FB8 Specifies a FontEmbedDataBlob.
    case fontEmbedDataBlob = 0x0FB8

    /// RT_CString 0x0FBA A Specifies a KinsokuLeadingAtom, KinsokuFollowingAtom, NamedShowNameAtom, MacroNameAtom, UncOrLocalPathAtom, MenuNameAtom, ProgIDAtom, ClipboardNameAtom, FriendlyNameAtom, TargetAtom, LocationAtom, ScreenTipAtom, PP9ShapeBinaryTagExtension, PP10ShapeBinaryTagExtension, PP11ShapeBinaryTagExtension, SlideNameAtom, TemplateNameAtom, PP9SlideBinaryTagExtension, PP10SlideBinaryTagExtension, Comment10AuthorAtom, Comment10TextAtom, Comment10AuthorInitialAtom, PP12SlideBinaryTagExtension, SoundNameAtom, PP9DocBinaryTagExtension, FileNameAtom, NamedShowAtom, BCTitleAtom, BCDescriptionAtom, BCSpeakerAtom, BCContactAtom, BCRexServerNameAtom, BCEmailAddressAtom, BCEmailNameAtom, BCChatUrlAtom, BCArchiveDirAtom, BCNetShowFilesBaseDirAtom, BCNetShowFilesDirAtom, BCNetShowServerNameAtom, BCPptFilesBaseDirAtom, BCPptFilesDirAtom, BCPptFilesBaseUrlAtom, BCBroadcastDateTimeAtom, BCPresentationNameAtom, BCAsdFileNameAtom, BCEntryIDAtom, PP10DocBinaryTagExtension, AuthorNameAtom, CopyrightAtom, KeywordsAtom, ModifyPasswordAtom, ReviewerNameAtom, PP11DocBinaryTagExtension, PP12DocBinaryTagExtension, UserDateAtom, HeaderAtom, FooterAtom, BookmarkValueAtom, TagNameAtom, TagValueAtom, SoundExtensionAtom, SoundIdAtom, SoundBuiltinIdAtom, BCUserNameAtom, ServerIdAtom, or SlideLibUrlAtom.
    case cString = 0x0FBA

    /// RT_MetaFile 0x0FC1 Specifies a MetafileBlob.
    case metaFile = 0x0FC1

    /// RT_ExternalOleObjectAtom 0x0FC3 Specifies an ExOleObjAtom section 2.10.12).
    case externalOleObjectAtom = 0x0FC3

    /// RT_Kinsoku 0x0FC8 Specifies a KinsokuContainer (section 2.9.2) or Kinsoku9Container (section 2.9.6).
    case kinsoku = 0x0FC8

    /// RT_Handout 0x0FC9 Specifies a HandoutContainer (section 2.5.8).
    case handout = 0x0FC9

    /// RT_ExternalOleEmbed 0x0FCC Specifies an ExOleEmbedContainer (section 2.10.27).
    case externalOleEmbed = 0x0FCC

    /// RT_ExternalOleEmbedAtom 0x0FCD Specifies an ExOleEmbedAtom.
    case externalOleEmbedAtom = 0x0FCD

    /// RT_ExternalOleLink 0x0FCE Specifies an ExOleLinkContainer (section 2.10.29).
    case externalOleLink = 0x0FCE

    /// RT_BookmarkEntityAtom 0x0FD0 Specifies a BookmarkEntityAtom orBookmarkEntityAtomContainer.
    case bookmarkEntityAtom = 0x0FD0

    /// RT_ExternalOleLinkAtom 0x0FD1 Specifies a ExOleLinkAtom.
    case externalOleLinkAtom = 0x0FD1

    /// RT_KinsokuAtom 0x0FD2 Specifies a KinsokuAtom or Kinsoku9Atom.
    case kinsokuAtom = 0x0FD2

    /// RT_ExternalHyperlinkAtom 0x0FD3 Specifies an ExHyperlinkAtom (section 2.10.17) or ExHyperlinkRefAtom.
    case externalHyperlinkAtom = 0x0FD3

    /// RT_ExternalHyperlink 0x0FD7 Specifies an ExHyperlinkContainer.
    case externalHyperlink = 0x0FD7

    /// RT_SlideNumberMetaCharAtom 0x0FD8 Specifies a SlideNumberMCAtom.
    case slideNumberMetaCharAtom = 0x0FD8

    /// RT_HeadersFooters 0x0FD9 Specifies a SlideHeadersFootersContainer (section 2.4.15.1), NotesHeadersFootersContainer (section 2.4.15.6), or PerSlideHeadersFootersContainer.
    case headersFooters = 0x0FD9

    /// RT_HeadersFootersAtom 0x0FDA Specifies a HeadersFootersAtom.
    case headersFootersAtom = 0x0FDA

    /// RT_TextInteractiveInfoAtom 0x0FDF Specifies a MouseClickTextInteractiveInfoAtom or MouseOverTextInteractiveInfoAtom.
    case textInteractiveInfoAtom = 0x0FDF

    /// RT_ExternalHyperlink9 0x0FE4 Specifies an ExHyperlink9Container.
    case externalHyperlink9 = 0x0FE4

    /// RT_RecolorInfoAtom 0x0FE7 Specifies a RecolorInfoAtom.
    case recolorInfoAtom = 0x0FE7

    /// RT_ExternalOleControl 0x0FEE Specifies an ExControlContainer (section 2.10.10).
    case externalOleControl = 0x0FEE

    /// RT_SlideListWithText 0x0FF0 Specifies a MasterListWithTextContainer (section 2.4.14.1), SlideListWithTextContainer (section 2.4.14.3), or NotesListWithTextContainer (section 2.4.14.6).
    case slideListWithText = 0x0FF0

    /// RT_AnimationInfoAtom 0x0FF1 Specifies an AnimationInfoAtom.
    case animationInfoAtom = 0x0FF1

    /// RT_InteractiveInfo 0x0FF2 Specifies a MouseClickInteractiveInfoContainer or MouseOverInteractiveInfoContainer.
    case interactiveInfo = 0x0FF2

    /// RT_InteractiveInfoAtom 0x0FF3 Specifies an InteractiveInfoAtom.
    case interactiveInfoAtom = 0x0FF3

    /// RT_UserEditAtom 0x0FF5 Specifies a UserEditAtom (section 2.3.3).
    case userEditAtom = 0x0FF5

    /// RT_CurrentUserAtom 0x0FF6 Specifies a CurrentUserAtom.
    case currentUserAtom = 0x0FF6

    /// RT_DateTimeMetaCharAtom 0x0FF7 Specifies a DateTimeMCAtom.
    case dateTimeMetaCharAtom = 0x0FF7

    /// RT_GenericDateMetaCharAtom 0x0FF8 Specifies a GenericDateMCAtom.
    case genericDateMetaCharAtom = 0x0FF8

    /// RT_HeaderMetaCharAtom 0x0FF9 Specifies a HeaderMCAtom.
    case headerMetaCharAtom = 0x0FF9

    /// RT_FooterMetaCharAtom 0x0FFA Specifies a FooterMCAtom.
    case footerMetaCharAtom = 0x0FFA

    /// RT_ExternalOleControlAtom 0x0FFB Specifies an ExControlAtom.
    case externalOleControlAtom = 0x0FFB

    /// RT_ExternalMediaAtom 0x1004 Specifies an ExMediaAtom (section 2.10.6).
    case externalMediaAtom = 0x1004

    /// RT_ExternalVideo 0x1005 Specifies an ExVideoContainer.
    case externalVideo = 0x1005

    /// RT_ExternalAviMovie 0x1006 Specifies an ExAviMovieContainer.
    case externalAviMovie = 0x1006

    /// RT_ExternalMciMovie 0x1007 Specifies an ExMCIMovieContainer.
    case externalMciMovie = 0x1007

    /// RT_ExternalMidiAudio 0x100D Specifies an ExMIDIAudioContainer.
    case externalMidiAudio = 0x100D

    /// RT_ExternalCdAudio 0x100E Specifies an ExCDAudioContainer.
    case externalCdAudio = 0x100E

    /// RT_ExternalWavAudioEmbedded 0x100F Specifies an ExWAVAudioEmbeddedContainer.
    case externalWavAudioEmbedded = 0x100F

    /// RT_ExternalWavAudioLink 0x1010 Specifies an ExWAVAudioLinkContainer.
    case externalWavAudioLink = 0x1010

    /// RT_ExternalOleObjectStg 0x1011 Specifies an ExOleObjStgCompressedAtom, ExOleObjStgUncompressedAtom, VbaProjectStgCompressedAtom, VbaProjectStgUncompressedAtom, ExControlStgUncompressedAtom, or ExControlStgCompressedAtom.
    case externalOleObjectStg = 0x1011

    /// RT_ExternalCdAudioAtom 0x1012 Specifies an ExCDAudioAtom.
    case externalCdAudioAtom = 0x1012

    /// RT_ExternalWavAudioEmbeddedAtom 0x1013 Specifies an ExWAVAudioEmbeddedAtom.
    case externalWavAudioEmbeddedAtom = 0x1013

    /// RT_AnimationInfo 0x1014 Specifies an AnimationInfoContainer.
    case animationInfo = 0x1014

    /// RT_RtfDateTimeMetaCharAtom 0x1015 Specifies a RTFDateTimeMCAtom.
    case rtfDateTimeMetaCharAtom = 0x1015

    /// RT_ExternalHyperlinkFlagsAtom 0x1018 Specifies an ExHyperlinkFlagsAtom.
    case externalHyperlinkFlagsAtom = 0x1018

    /// RT_ProgTags 0x1388 Specifies a SlideProgTagsContainer, DocProgTagsContainer (section 2.4.23.1), or ShapeProgTagsContainer.
    case progTags = 0x1388

    /// RT_ProgStringTag 0x1389 Specifies a ProgStringTagContainer.
    case progStringTag = 0x1389

    /// RT_ProgBinaryTag 0x138A Specifies a SlideProgBinaryTagContainer, DocProgBinaryTagContainer, or ShapeProgBinaryTagContainer.
    case progBinaryTag = 0x138A

    /// RT_BinaryTagDataBlob 0x138B Specifies a PP9ShapeBinaryTagExtension, PP10ShapeBinaryTagExtension, PP11ShapeBinaryTagExtension, PP9DocBinaryTagExtension, PP10DocBinaryTagExtension, PP11DocBinaryTagExtension, PP12DocBinaryTagExtension, PP9SlideBinaryTagExtension, PP10SlideBinaryTagExtension, PP12SlideBinaryTagExtension, or BinaryTagDataBlob.
    case binaryTagDataBlob = 0x138B

    /// RT_PrintOptionsAtom 0x1770 Specifies a PrintOptionsAtom record (section 2.4.12).
    case printOptionsAtom = 0x1770

    /// RT_PersistDirectoryAtom 0x1772 Specifies a PersistDirectoryAtom (section 2.3.4).
    case persistDirectoryAtom = 0x1772

    /// RT_PresentationAdvisorFlags9Atom 0x177A Specifies a PresAdvisorFlags9Atom.
    case presentationAdvisorFlags9Atom = 0x177A

    /// RT_HtmlDocInfo9Atom 0x177B Specifies an HTMLDocInfo9Atom.
    case htmlDocInfo9Atom = 0x177B

    /// RT_HtmlPublishInfoAtom 0x177C Specifies an HTMLPublishInfoAtom.
    case htmlPublishInfoAtom = 0x177C

    /// RT_HtmlPublishInfo9 0x177D Specifies an HTMLPublishInfo9Container.
    case htmlPublishInfo9 = 0x177D

    /// RT_BroadcastDocInfo9 0x177E Specifies a BroadcastDocInfo9Container.
    case broadcastDocInfo9 = 0x177E

    /// RT_BroadcastDocInfo9Atom 0x177F Specifies a BroadcastDocInfoAtom.
    case broadcastDocInfo9Atom = 0x177F

    /// RT_EnvelopeFlags9Atom 0x1784 Specifies an EnvelopeFlags9Atom.
    case envelopeFlags9Atom = 0x1784

    /// RT_EnvelopeData9Atom 0x1785 Specifies an EnvelopeData9Atom.
    case envelopeData9Atom = 0x1785

    /// RT_VisualShapeAtom 0x2AFB Specifies a VisualSoundAtom, VisualShapeChartElementAtom, or VisualShapeGeneralAtom.
    case visualShapeAtom = 0x2AFB

    /// RT_HashCodeAtom 0x2B00 Specifies a HashCode10Atom.
    case hashCodeAtom = 0x2B00

    /// RT_VisualPageAtom 0x2B01 Specifies a VisualPageAtom.
    case visualPageAtom = 0x2B01

    /// RT_BuildList 0x2B02 Specifies a BuildListContainer.
    case buildList = 0x2B02

    /// RT_BuildAtom 0x2B03 Specifies a BuildAtom.
    case buildAtom = 0x2B03

    /// RT_ChartBuild 0x2B04 Specifies a ChartBuildContainer.
    case chartBuild = 0x2B04

    /// RT_ChartBuildAtom 0x2B05 Specifies a ChartBuildAtom.
    case chartBuildAtom = 0x2B05

    /// RT_DiagramBuild 0x2B06 Specifies a DiagramBuildContainer.
    case diagramBuild = 0x2B06

    /// RT_DiagramBuildAtom 0x2B07 Specifies a DiagramBuildAtom.
    case diagramBuildAtom = 0x2B07

    /// RT_ParaBuild 0x2B08 Specifies a ParaBuildContainer.
    case paraBuild = 0x2B08

    /// RT_ParaBuildAtom 0x2B09 Specifies a ParaBuildAtom.
    case paraBuildAtom = 0x2B09

    /// RT_LevelInfoAtom 0x2B0A Specifies a LevelInfoAtom.
    case levelInfoAtom = 0x2B0A

    /// RT_RoundTripAnimationAtom12Atom 0x2B0B Specifies a RoundTripAnimationAtom.
    case roundTripAnimationAtom12Atom = 0x2B0B

    /// RT_RoundTripAnimationHashAtom12Atom 0x2B0D Specifies a RoundTripAnimationHashAtom.
    case roundTripAnimationHashAtom12Atom = 0x2B0D

    /// RT_Comment10 0x2EE0 Specifies a Comment10Container.
    case comment10 = 0x2EE0

    /// RT_Comment10Atom 0x2EE1 Specifies a Comment10Atom.
    case comment10Atom = 0x2EE1

    /// RT_CommentIndex10 0x2EE4 Specifies a CommentIndex10Container.
    case commentIndex10 = 0x2EE4

    /// RT_CommentIndex10Atom 0x2EE5 Specifies a CommentIndex10Atom.
    case commentIndex10Atom = 0x2EE5

    /// RT_LinkedShape10Atom 0x2EE6 Specifies a LinkedShape10Atom.
    case linkedShape10Atom = 0x2EE6

    /// RT_LinkedSlide10Atom 0x2EE7 Specifies a LinkedSlide10Atom.
    case linkedSlide10Atom = 0x2EE7

    /// RT_SlideFlags10Atom 0x2EEA Specifies a SlideFlags10Atom.
    case slideFlags10Atom = 0x2EEA

    /// RT_SlideTime10Atom 0x2EEB Specifies a SlideTime10Atom.
    case slideTime10Atom = 0x2EEB

    /// RT_DiffTree10 0x2EEC Specifies a DiffTree10Container.
    case diffTree10 = 0x2EEC

    /// RT_Diff10 0x2EED Specifies a DocDiff10Container, HeaderFooterDiffContainer, NamedShowListDiffContainer, NamedShowDiffContainer, SlideListDiffContainer, MasterListDiffContainer, MainMasterDiffContainer, SlideDiffContainer, ShapeListDiffContainer, ShapeDiffContainer, TextDiffContainer, RecolorInfoDiffContainer, ExternalObjectDiffContainer, InteractiveInfoDiffContainer, TableDiffContainer, SlideShowDiffContainer, NotesDiffContainer, or TableListDiffContainer.
    case diff10 = 0x2EED

    /// RT_Diff10Atom 0x2EEE Specifies a DocDiff10Container, HeaderFooterDiffContainer, NamedShowListDiffContainer, NamedShowDiffContainer, SlideListDiffContainer, MasterListDiffContainer, MainMasterDiffContainer, SlideDiffContainer, ShapeListDiffContainer, ShapeDiffContainer, TextDiffContainer, RecolorInfoDiffContainer, ExternalObjectDiffContainer, InteractiveInfoDiffContainer, TableDiffContainer, SlideShowDiffContainer, NotesDiffContainer, or TableListDiffContainer.
    case diff10Atom = 0x2EEE

    /// RT_SlideListTableSize10Atom 0x2EEF Specifies a SlideListTableSize10Atom.
    case slideListTableSize10Atom = 0x2EEF

    /// RT_SlideListEntry10Atom 0x2EF0 Specifies a SlideListEntry10Atom.
    case slideListEntry10Atom = 0x2EF0

    /// RT_SlideListTable10 0x2EF1 Specifies a SlideListTable10Container.
    case slideListTable10 = 0x2EF1

    /// RT_CryptSession10Container 0x2F14 Specifies a CryptSession10Container (section 2.3.7).
    case cryptSession10Container = 0x2F14

    /// RT_FontEmbedFlags10Atom 0x32C8 Specifies a FontEmbedFlags10Atom.
    case fontEmbedFlags10Atom = 0x32C8

    /// RT_FilterPrivacyFlags10Atom 0x36B0 Specifies a FilterPrivacyFlags10Atom.
    case filterPrivacyFlags10Atom = 0x36B0

    /// RT_DocToolbarStates10Atom 0x36B1 Specifies a DocToolbarStates10Atom.
    case docToolbarStates10Atom = 0x36B1

    /// RT_PhotoAlbumInfo10Atom 0x36B2 Specifies a PhotoAlbumInfo2.4.9Atom.
    case photoAlbumInfo10Atom = 0x36B2

    /// RT_SmartTagStore11Container 0x36B3 Specifies a SmartTagStore11Container (section 2.11.28).
    case smartTagStore11Container = 0x36B3

    /// RT_RoundTripSlideSyncInfo12 0x3714 Specifies a RoundTripSlideSyncInfo12Container.
    case roundTripSlideSyncInfo12 = 0x3714

    /// RT_RoundTripSlideSyncInfoAtom12 0x3715 Specifies a SlideSyncInfoAtom12.
    case roundTripSlideSyncInfoAtom12 = 0x3715

    /// RT_TimeConditionContainer 0xF125 Specifies a TimeConditionContainer (section 2.8.75).
    case timeConditionContainer = 0xF125

    /// RT_TimeNode 0xF127 Specifies a TimeNodeAtom.
    case timeNode = 0xF127

    /// RT_TimeCondition 0xF128 Specifies a TimeConditionAtom.
    case timeCondition = 0xF128

    /// RT_TimeModifier 0xF129 Specifies a TimeModifierAtom.
    case timeModifier = 0xF129

    /// RT_TimeBehaviorContainer 0xF12A Specifies a TimeBehaviorContainer (section 2.8.34).
    case timeBehaviorContainer = 0xF12A

    /// RT_TimeAnimateBehaviorContainer 0xF12B Specifies a TimeAnimateBehaviorContainer (section 2.8.29).
    case timeAnimateBehaviorContainer = 0xF12B

    /// RT_TimeColorBehaviorContainer 0xF12C Specifies a TimeColorBehaviorContainer (section 2.8.52).
    case timeColorBehaviorContainer = 0xF12C

    /// RT_TimeEffectBehaviorContainer 0xF12D Specifies a TimeEffectBehaviorContainer (section 2.8.61).
    case timeEffectBehaviorContainer = 0xF12D

    /// RT_TimeMotionBehaviorContainer 0xF12E Specifies a TimeMotionBehaviorContainer (section 2.8.63).
    case timeMotionBehaviorContainer = 0xF12E

    /// RT_TimeRotationBehaviorContainer 0xF12F Specifies a TimeRotationBehaviorContainer (section 2.8.65).
    case timeRotationBehaviorContainer = 0xF12F

    /// RT_TimeScaleBehaviorContainer 0xF130 Specifies a TimeScaleBehaviorContainer (section 2.8.67).
    case timeScaleBehaviorContainer = 0xF130

    /// RT_TimeSetBehaviorContainer 0xF131 Specifies a TimeSetBehaviorContainer (section 2.8.69).
    case timeSetBehaviorContainer = 0xF131

    /// RT_TimeCommandBehaviorContainer 0xF132 Specifies a TimeCommandBehaviorContainer (section 2.8.71).
    case timeCommandBehaviorContainer = 0xF132

    /// RT_TimeBehavior 0xF133 Specifies a TimeBehaviorAtom.
    case timeBehavior = 0xF133

    /// RT_TimeAnimateBehavior 0xF134 Specifies a TimeAnimateBehaviorAtom.
    case timeAnimateBehavior = 0xF134

    /// RT_TimeColorBehavior 0xF135 Specifies a TimeColorBehaviorAtom.
    case timeColorBehavior = 0xF135

    /// RT_TimeEffectBehavior 0xF136 Specifies a TimeEffectBehaviorAtom.
    case timeEffectBehavior = 0xF136

    /// RT_TimeMotionBehavior 0xF137 Specifies a TimeMotionBehaviorAtom.
    case timeMotionBehavior = 0xF137

    /// RT_TimeRotationBehavior 0xF138 Specifies a TimeRotationBehaviorAtom.
    case timeRotationBehavior = 0xF138

    /// RT_TimeScaleBehavior 0xF139 Specifies a TimeScaleBehaviorAtom.
    case timeScaleBehavior = 0xF139

    /// RT_TimeSetBehavior 0xF13A Specifies a TimeSetBehaviorAtom.
    case timeSetBehavior = 0xF13A

    /// RT_TimeCommandBehavior 0xF13B Specifies a TimeCommandBehaviorAtom.
    case timeCommandBehavior = 0xF13B

    /// RT_TimeClientVisualElement 0xF13C Specifies a ClientVisualElementContainer (section 2.8.44).
    case timeClientVisualElement = 0xF13C

    /// RT_TimePropertyList 0xF13D Specifies a TimePropertyList4TimeNodeContainer (section 2.8.18) or TimePropertyList4TimeBehavior.
    case timePropertyList = 0xF13D

    /// RT_TimeVariantList 0xF13E Specifies a TimeStringListContainer (section 2.8.36).
    case timeVariantList = 0xF13E

    /// RT_TimeAnimationValueList 0xF13F Specifies a TimeAnimationValueListContainer (section 2.8.31).
    case timeAnimationValueList = 0xF13F

    /// RT_TimeIterateData 0xF140 Specifies a TimeIterateDataAtom.
    case timeIterateData = 0xF140

    /// RT_TimeSequenceData 0xF141 Specifies a TimeSequenceDataAtom.
    case timeSequenceData = 0xF141

    /// RT_TimeVariant 0xF142 Specifies a TimeVariantBool, TimeVariantInt, TimeVariantFloat, TimeVariantString, TimeDisplayType, TimeMasterRelType, TimeSubType, TimeEffectID, TimeEffectType, TimeNodeTimeFilter, TimeEventFilter, TimeGroupID, TimeEffectNodeType, TimeColorModel, TimeColorDirection, TimeOverride, TimeRuntimeContext, or TimePointsTypes.
    case timeVariant = 0xF142

    /// RT_TimeAnimationValue 0xF143 Specifies a TimeAnimationValueAtom.
    case timeAnimationValue = 0xF143

    /// RT_TimeExtTimeNodeContainer 0xF144 Specifies an ExtTimeNodeContainer (section 2.8.15).
    case timeExtTimeNodeContainer = 0xF144

    /// RT_TimeSubEffectContainer 0xF145 Specifies a SubEffectContainer.
    case timeSubEffectContainer = 0xF145
    
    case unknown = 0xFFFF
}
