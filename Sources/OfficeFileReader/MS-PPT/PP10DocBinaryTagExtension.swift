//
//  PP10DocBinaryTagExtension.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.23.6 PP10DocBinaryTagExtension
/// Referenced by: DocProgBinaryTagSubContainerOrAtom
/// A pair of atom records that specifies a programmable tag with additional document data.
public struct PP10DocBinaryTagExtension {
    public let rh: RecordHeader
    public let tagName: PrintableUnicodeString
    public let rhData: RecordHeader
    public let fontCollectionContainer: FontCollection10Container?
    public let rgTextMasterStyle10: [TextMasterStyle10Atom]
    public let textDefaultsAtom: TextDefaults10Atom?
    public let gridSpacingAtom: GridSpacing10Atom?
    public let rgCommentIndex10: [CommentIndex10Container]
    public let fontEmbedFlagsAtom: FontEmbedFlags10Atom?
    public let copyrightAtom: CopyrightAtom?
    public let keywordsAtom: KeywordsAtom?
    public let filterPrivacyFlagsAtom: FilterPrivacyFlags10Atom?
    public let outlineTextPropsContainer: OutlineTextProps10Container?
    public let docToolbarStatesAtom: DocToolbarStates10Atom?
    public let slideListTableContainer: SlideListTable10Container?
    public let rgDiffTree10Container: [DiffTree10Container]
    public let modifyPasswordAtom: ModifyPasswordAtom?
    public let photoAlbumInfoAtom: PhotoAlbumInfo10Atom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_CString (section 2.13.24).
        /// rh.recLen MUST be 0x00000010.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition1 = dataStream.position

        /// tagName (16 bytes): A PrintableUnicodeString (section 2.2.23) that specifies the programmable tag name. It MUST be "___PPT10".
        self.tagName = try PrintableUnicodeString(dataStream: &dataStream, byteCount: 16)
        if self.tagName != "___PPT10" {
            throw OfficeFileError.corrupted
        }
        
        if dataStream.position - startPosition1 != self.rh.recLen {
            throw OfficeFileError.corrupted
        }
        
        /// rhData (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for the second record. Sub-fields are further specified in
        /// the following table:
        /// Field Meaning
        /// rhData.recVer MUST be 0x0.
        /// rhData.recInstance MUST be 0x000.
        /// rhData.recType MUST be RT_BinaryTagDataBlob.
        self.rhData = try RecordHeader(dataStream: &dataStream)
        guard self.rhData.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rhData.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rhData.recType == .binaryTagDataBlob else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition2 = dataStream.position
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.fontCollectionContainer = nil
            self.rgTextMasterStyle10 = []
            self.textDefaultsAtom = nil
            self.gridSpacingAtom = nil
            self.rgCommentIndex10 = []
            self.fontEmbedFlagsAtom = nil
            self.copyrightAtom = nil
            self.keywordsAtom = nil
            self.filterPrivacyFlagsAtom = nil
            self.outlineTextPropsContainer = nil
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// fontCollectionContainer (variable): An optional FontCollection10Container record (section 2.9.11) that specifies information about additional
        /// fonts in the presentation.
        if try dataStream.peekRecordHeader().recType == .fontCollection10 {
            self.fontCollectionContainer = try FontCollection10Container(dataStream: &dataStream)
        } else {
            self.fontCollectionContainer = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.rgTextMasterStyle10 = []
            self.textDefaultsAtom = nil
            self.gridSpacingAtom = nil
            self.rgCommentIndex10 = []
            self.fontEmbedFlagsAtom = nil
            self.copyrightAtom = nil
            self.keywordsAtom = nil
            self.filterPrivacyFlagsAtom = nil
            self.outlineTextPropsContainer = nil
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// rgTextMasterStyle10 (variable): An array of TextMasterStyle10Atom records that specifies additional character-level and paragraph-level
        /// formatting of main master slides. The array continues while rh.recType of the TextMasterStyle10Atom record is equal to
        /// RT_TextMasterStyle10Atom.
        var rgTextMasterStyle10: [TextMasterStyle10Atom] = []
        while dataStream.position - startPosition2 < self.rhData.recLen {
            guard try dataStream.peekRecordHeader().recType == .textMasterStyle10Atom else {
                break
            }
            
            rgTextMasterStyle10.append(try TextMasterStyle10Atom(dataStream: &dataStream))
        }
        
        self.rgTextMasterStyle10 = rgTextMasterStyle10
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.textDefaultsAtom = nil
            self.gridSpacingAtom = nil
            self.rgCommentIndex10 = []
            self.fontEmbedFlagsAtom = nil
            self.copyrightAtom = nil
            self.keywordsAtom = nil
            self.filterPrivacyFlagsAtom = nil
            self.outlineTextPropsContainer = nil
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// textDefaultsAtom (variable): An optional TextDefaults10Atom record that specifies additional default character-level formatting.
        if try dataStream.peekRecordHeader().recType == .textDefaults10Atom {
            self.textDefaultsAtom = try TextDefaults10Atom(dataStream: &dataStream)
        } else {
            self.textDefaultsAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.gridSpacingAtom = nil
            self.rgCommentIndex10 = []
            self.fontEmbedFlagsAtom = nil
            self.copyrightAtom = nil
            self.keywordsAtom = nil
            self.filterPrivacyFlagsAtom = nil
            self.outlineTextPropsContainer = nil
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// gridSpacingAtom (16 bytes): A GridSpacing10Atom record that specifies spacing for a grid that can be used to align objects on a slide and
        /// to display positioning cues.
        if try dataStream.peekRecordHeader().recType == .gridSpacing10Atom {
            self.gridSpacingAtom = try GridSpacing10Atom(dataStream: &dataStream)
        } else {
            self.gridSpacingAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.rgCommentIndex10 = []
            self.fontEmbedFlagsAtom = nil
            self.copyrightAtom = nil
            self.keywordsAtom = nil
            self.filterPrivacyFlagsAtom = nil
            self.outlineTextPropsContainer = nil
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }

        /// rgCommentIndex10 (variable): An array of CommentIndex10Container records that specifies information for presentation comments in the
        /// document. The array continues while rh.recType of the CommentIndex10Container item is equal to RT_CommentIndex10.
        var rgCommentIndex10: [CommentIndex10Container] = []
        while dataStream.position - startPosition2 < self.rhData.recLen {
            guard try dataStream.peekRecordHeader().recType == .commentIndex10 else {
                break
            }
            
            rgCommentIndex10.append(try CommentIndex10Container(dataStream: &dataStream))
        }
        
        self.rgCommentIndex10 = rgCommentIndex10
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.fontEmbedFlagsAtom = nil
            self.copyrightAtom = nil
            self.keywordsAtom = nil
            self.filterPrivacyFlagsAtom = nil
            self.outlineTextPropsContainer = nil
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// fontEmbedFlagsAtom (12 bytes): An optional FontEmbedFlags10Atom record that specifies how font data is embedded.
        if try dataStream.peekRecordHeader().recType == .fontEmbedFlags10Atom {
            self.fontEmbedFlagsAtom = try FontEmbedFlags10Atom(dataStream: &dataStream)
        } else {
            self.fontEmbedFlagsAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.copyrightAtom = nil
            self.keywordsAtom = nil
            self.filterPrivacyFlagsAtom = nil
            self.outlineTextPropsContainer = nil
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// copyrightAtom (variable): An optional CopyrightAtom record that specifies copyright information.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .fontEmbedFlags10Atom && nextAtom1.recInstance == 0x001 {
            self.copyrightAtom = try CopyrightAtom(dataStream: &dataStream)
        } else {
            self.copyrightAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.keywordsAtom = nil
            self.filterPrivacyFlagsAtom = nil
            self.outlineTextPropsContainer = nil
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// keywordsAtom (variable): An optional KeywordsAtom record that specifies keyword information.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .fontEmbedFlags10Atom && nextAtom2.recInstance == 0x002 {
            self.keywordsAtom = try KeywordsAtom(dataStream: &dataStream)
        } else {
            self.keywordsAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.filterPrivacyFlagsAtom = nil
            self.outlineTextPropsContainer = nil
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// filterPrivacyFlagsAtom (12 bytes): An optional FilterPrivacyFlags10Atom record that specifies privacy settings.
        if try dataStream.peekRecordHeader().recType == .filterPrivacyFlags10Atom {
            self.filterPrivacyFlagsAtom = try FilterPrivacyFlags10Atom(dataStream: &dataStream)
        } else {
            self.filterPrivacyFlagsAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.outlineTextPropsContainer = nil
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// outlineTextPropsContainer (variable): An optional OutlineTextProps10Container record that specifies additional text properties for outline text.
        if try dataStream.peekRecordHeader().recType == .outlineTextProps10 {
            self.outlineTextPropsContainer = try OutlineTextProps10Container(dataStream: &dataStream)
        } else {
            self.outlineTextPropsContainer = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.docToolbarStatesAtom = nil
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// docToolbarStatesAtom (9 bytes): An optional DocToolbarStates10Atom record that specifies display options for toolbars. It SHOULD<24>
        /// be ignored and SHOULD<25> be omitted.
        if try dataStream.peekRecordHeader().recType == .docToolbarStates10Atom {
            self.docToolbarStatesAtom = try DocToolbarStates10Atom(dataStream: &dataStream)
        } else {
            self.docToolbarStatesAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.slideListTableContainer = nil
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// slideListTableContainer (variable): An optional SlideListTable10Container record that specifies additional data about slides in the document.
        /// It SHOULD<26> be ignored and SHOULD<27> be omitted.
        if try dataStream.peekRecordHeader().recType == .slideListTable10 {
            self.slideListTableContainer = try SlideListTable10Container(dataStream: &dataStream)
        } else {
            self.slideListTableContainer = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.rgDiffTree10Container = []
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// rgDiffTree10Container (variable): An optional array of DiffTree10Container. The array continues while rh.recType of the DiffTree10Container
        /// item is equal to RT_DiffTree10. The array specifies the names of reviewers and how to display the changes of the document made by those
        /// reviewers. It SHOULD<28> be ignored and SHOULD<29> be omitted.
        var rgDiffTree10Container: [DiffTree10Container] = []
        while dataStream.position - startPosition2 < self.rhData.recLen {
            guard try dataStream.peekRecordHeader().recType == .diffTree10 else {
                break
            }
             
            rgDiffTree10Container.append(try DiffTree10Container(dataStream: &dataStream))
        }
        
        self.rgDiffTree10Container = rgDiffTree10Container
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.modifyPasswordAtom = nil
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// modifyPasswordAtom (variable): An optional ModifyPasswordAtom record that specifies a password used to modify the document.
        if try dataStream.peekRecordHeader().recType == .cString {
            self.modifyPasswordAtom = try ModifyPasswordAtom(dataStream: &dataStream)
        } else {
            self.modifyPasswordAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.photoAlbumInfoAtom = nil
            return
        }
        
        /// photoAlbumInfoAtom (14 bytes): An optional PhotoAlbumInfo10Atom record that specifies user preferences for how to display a
        /// presentation as a photo album.
        if try dataStream.peekRecordHeader().recType == .photoAlbumInfo10Atom {
            self.photoAlbumInfoAtom = try PhotoAlbumInfo10Atom(dataStream: &dataStream)
        } else {
            self.photoAlbumInfoAtom = nil
        }
        
        guard dataStream.position - startPosition2 == self.rhData.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
