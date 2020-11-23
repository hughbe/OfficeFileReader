//
//  DopBase.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.2 DopBase
/// The DopBase structure contains document and compatibility settings that are common to all versions of the binary document. These settings influence
/// the appearance and behavior of the current document and store document-level state.
public struct DopBase {
    public let fFacingPages: Bool
    public let unused1: Bool
    public let fPMHMainDoc: Bool
    public let unused2: UInt8
    public let fbc: Fbc
    public let unused3: Bool
    public let unused4: UInt8
    public let rncFtn: RncFtn
    public let nFtn: UInt16
    public let unused5: Bool
    public let unused6: Bool
    public let unused7: Bool
    public let unused8: Bool
    public let unused9: Bool
    public let unused10: Bool
    public let fSplAllDone: Bool
    public let fSplAllClean: Bool
    public let fSplHideErrors: Bool
    public let fGramHideErrors: Bool
    public let fLabelDoc: Bool
    public let fHyphCapitals: Bool
    public let fAutoHyphen: Bool
    public let fFormNoFields: Bool
    public let fLinkStyles: Bool
    public let fRevMarking: Bool
    public let unused11: Bool
    public let fExactCWords: Bool
    public let fPagHidden: Bool
    public let fPagResults: Bool
    public let fLockAtn: Bool
    public let fMirrorMargins: Bool
    public let fWord97Compat: Bool
    public let unused12: Bool
    public let unused13: Bool
    public let fProtEnabled: Bool
    public let fDispFormFldSel: Bool
    public let fRMView: Bool
    public let fRMPrint: Bool
    public let fLockVbaProj: Bool
    public let fLockRev: Bool
    public let fEmbedFonts: Bool
    public let copts60: Copts60
    public let dxaTab: UInt16
    public let cpgWebOpt: UInt16
    public let dxaHotZ: UInt16
    public let cConsecHypLim: UInt16
    public let wSpare2: UInt16
    public let dttmCreated: DTTM
    public let dttmRevised: DTTM
    public let dttmLastPrint: DTTM
    public let nRevision: Int16
    public let tmEdited: Int32
    public let cWords: Int32
    public let cCh: Int32
    public let cPg: Int16
    public let cParas: Int32
    public let rncEdn: RncEdn
    public let nEdn: UInt16
    public let epc: Epc
    public let unused14: UInt8
    public let unused15: UInt8
    public let fPrintFormData: Bool
    public let fSaveFormData: Bool
    public let fShadeFormData: Bool
    public let fShadeMergeFields: Bool
    public let reserved2: Bool
    public let fIncludeSubdocsInStats: Bool
    public let cLines: Int32
    public let cWordsWithSubdocs: Int32
    public let cChWithSubdocs: Int32
    public let cPgWithSubdocs: Int16
    public let cParasWithSubdocs: Int32
    public let cLinesWithSubdocs: Int32
    public let lKeyProtDoc: Int32
    public let wvkoSaved: ViewingMode
    public let pctWwdSaved: UInt16
    public let zkSaved: ZoomType
    public let unused16: Bool
    public let iGutterPos: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags1: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fFacingPages (1 bit): A bit that specifies whether even and odd pages have different headers and footers as specified in [ECMA-376]
        /// Part4, Section 2.10.1 evenAndOddHeaders, where titlePg corresponds to the section property sprmSFTitlePage.
        self.fFacingPages = flags1.readBit()
        
        /// B - unused1 (1 bit): This value is undefined and MUST be ignored.
        self.unused1 = flags1.readBit()
        
        /// C - fPMHMainDoc (1 bit): A bit that specifies whether this document is a mail merge main document.
        self.fPMHMainDoc = flags1.readBit()
        
        /// D - unused2 (2 bits): This value is undefined and MUST be ignored.
        self.unused2 = UInt8(flags1.readBits(count: 2))
        
        /// fpc (2 bits): Specifies where footnotes are placed on the page when they are referenced by text in the current document for documents that
        /// have an nFib value that is less than or equal to 0x00D9. This MUST be one of the following values
        let fbcRaw = UInt8(flags1.readBits(count: 2))
        guard let fbc = Fbc(rawValue: fbcRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.fbc = fbc
        
        /// E - unused3 (1 bit): This value is undefined and MUST be ignored.
        self.unused3 = flags1.readBit()
        
        /// unused4 (8 bits): This value is undefined and MUST be ignored.
        self.unused4 = UInt8(flags1.readRemainingBits())
        
        var flags2: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// F - rncFtn (2 bits): Specifies when all automatic numbering for the footnote reference marks is restarted for documents that have an nFib value
        /// that is less than or equal to 0x00D9. For those documents that rely on rncFtn, when restarted, the next automatically numbered footnote in the
        /// document restarts to the specified nFtn value. This MUST be one of the following values.
        let rncFtnRaw = UInt8(flags2.readBits(count: 2))
        guard let rncFtn = RncFtn(rawValue: rncFtnRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.rncFtn = rncFtn
        
        /// nFtn (14 bits): For those documents that have an nFib value that is less than or equal to 0x00D9, this element specifies the starting number for
        /// the first automatically numbered footnotes in the document, and the first automatically numbered footnotes after each restart point that is specified
        /// by the rncFtn element.
        self.nFtn = flags2.readRemainingBits()
        
        var flags3: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// G - unused5 (1 bit): This value is undefined and MUST be ignored.
        self.unused5 = flags3.readBit()
        
        /// H - unused6 (1 bit): This value is undefined and MUST be ignored.
        self.unused6 = flags3.readBit()
        
        /// I - unused7 (1 bit): This value is undefined and MUST be ignored.
        self.unused7 = flags3.readBit()
        
        /// J - unused8 (1 bit): This value is undefined and MUST be ignored.
        self.unused8 = flags3.readBit()
        
        /// K - unused9 (1 bit): This value is undefined and MUST be ignored.
        self.unused9 = flags3.readBit()
        
        /// L - unused10 (1 bit): This value is undefined and MUST be ignored.
        self.unused10 = flags3.readBit()
        
        /// M - fSplAllDone (1 bit): Specifies whether all content in this document was already checked by the spelling checker.
        self.fSplAllDone = flags3.readBit()
        
        /// N - fSplAllClean (1 bit): Specifies whether all content in this document can be considered to be spelled correctly.
        self.fSplAllClean = flags3.readBit()
        
        /// O - fSplHideErrors (1 bit): Specifies whether visual cues are not displayed around content contained in a document which is flagged as a
        /// possible spelling error.
        self.fSplHideErrors = flags3.readBit()
        
        /// P - fGramHideErrors (1 bit): Specifies whether visual cues are not displayed around content that is contained in a document and flagged as a
        /// possible grammar error.
        self.fGramHideErrors = flags3.readBit()
        
        /// Q - fLabelDoc (1 bit): Specifies whether the document is a mail merge labels document. When the value is 1, the document was created as a
        /// labels document.
        self.fLabelDoc = flags3.readBit()
        
        /// R - fHyphCapitals (1 bit): Specifies whether words that are composed of all capital letters are hyphenated in a given document when fAutoHyphen
        /// is set to 1.
        self.fHyphCapitals = flags3.readBit()
        
        /// S - fAutoHyphen (1 bit): Specifies whether text is hyphenated automatically, as needed, when displayed as specified in [ECMA-376] Part4,
        /// section 2.15.1.10 autoHyphenation.
        self.fAutoHyphen = flags3.readBit()
        
        /// T - fFormNoFields (1 bit): Specifies that there are no editable regions in a document that is currently protected for form field fill-in (fProtEnabled
        /// is 1). This value MUST be 0 if fProtEnabled is 0.
        self.fFormNoFields = flags3.readBit()
        
        /// U - fLinkStyles (1 bit): Specifies whether the styles of the document are updated to match those of the attached template as specified in
        /// [ECMA-376] Part4, Section 2.15.1.55 linkStyles, where the attachedTemplate value refers to entry 0x01 in SttbfAssoc.
        self.fLinkStyles = flags3.readBit()
        
        /// V - fRevMarking (1 bit): Specifies whether edits are tracked as revisions. If the value of fLockRev is set to 1, the value of fRevMarking MUST also
        /// be set to 1, as specified in [ECMA-376] Part4, Section 2.15.1.90 trackRevisions.
        self.fRevMarking = flags3.readBit()
        
        var flags4: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// W - unused11 (1 bit): This value is undefined and MUST be ignored.
        self.unused11 = flags4.readBit()
        
        /// X - fExactCWords (1 bit): In conjunction with fIncludeSubdocsInStats, this bit specifies whether the values stored in cCh, cChWS, cWords,
        /// cParas, cLines, cDBC, cChWithSubdocs, cChWSWithSubdocs, cWordsWithSubdocs, cParasWithSubdocs, cLinesWithSubdocs, or
        /// cDBCWithSubdocs accurately reflect the current state of the document. When the value of fExactCWords is 0, none of the mentioned fields
        /// contain accurate values. When the value of fExactCWords is 1, the value of fIncludeSubdocsInStats determines which set of fields contains
        /// accurate values.
        self.fExactCWords = flags4.readBit()
        
        /// Y - fPagHidden (1 bit): This value is undefined and MUST be ignored.
        self.fPagHidden = flags4.readBit()
        
        /// Z - fPagResults (1 bit): This value is undefined and MUST be ignored.
        self.fPagResults = flags4.readBit()
        
        /// a - fLockAtn (1 bit): Specifies whether protection for comments was applied to the document or, if Dop2003.fTreatLockAtnAsReadOnly has a
        /// value of 1, whether read-only protection was applied to the document. These restrictions are used to prevent unintentional changes to all or
        /// part of a document. Because this protection does not encrypt the document, malicious applications can circumvent its use. This protection is
        /// not intended as a security feature and can be ignored. When fLockAtn is 1, fLockRev MUST be 0 and fProtEnabled SHOULD<165> be 0.
        /// fLockAtn can be one of the following.
        /// Value Meaning
        /// 0 Specifies that the edits made to this document are restricted to the following:
        ///  The insertion and deletion of comments within the document.
        ///  The editing of the regions that are delimited by range permissions matching the editing rights of the user account that is being used to perform
        /// the editing.
        /// 1 Specifies that the edits made to this document are restricted to the following:
        ///  The editing of the regions that are delimited by range permissions matching the editing rights of the user account that is being used to perform
        /// the editing.
        self.fLockAtn = flags4.readBit()
        
        /// b - fMirrorMargins (1 bit): Specifies that the left and right margins that are defined in the section properties are swapped on facing pages.
        self.fMirrorMargins = flags4.readBit()
        
        /// c - fWord97Compat (1 bit): Specifies that this document was in Word97 compatibility mode when last saved.
        self.fWord97Compat = flags4.readBit()
        
        /// d - unused12 (1 bit): This value is undefined and MUST be ignored.
        self.unused12 = flags4.readBit()
        
        /// e - unused13 (1 bit): This value is undefined and MUST be ignored.
        self.unused13 = flags4.readBit()
        
        /// f - fProtEnabled (1 bit): Specifies that the edits that are made to this document are restricted to the editing of form fields in sections that are
        /// protected (see sprmSFProtected). All other sections have no editing restrictions resulting from this setting. When fProtEnabled is 1, both fLockAtn
        /// and fLockRev SHOULD<166> be 0.
        self.fProtEnabled = flags4.readBit()
        
        /// g - fDispFormFldSel (1 bit): If the document is currently protected for form field fill-in (fProtEnabled is 1), this bit specifies that the selection was
        /// within a display form field (check box or list box) the last time that the document was saved.
        self.fDispFormFldSel = flags4.readBit()
        
        /// h - fRMView (1 bit): Specifies whether to show any revision markup that is present in this document.
        self.fRMView = flags4.readBit()
        
        /// i - fRMPrint (1 bit): Specifies whether to print any revision markup that is present in the document. SHOULD<167> be the same value as fRMView.
        self.fRMPrint = flags4.readBit()
        
        /// j - fLockVbaProj (1 bit): Specifies whether the Microsoft Visual Basic project is locked from editing and viewing.
        self.fLockVbaProj = flags4.readBit()
        
        /// k - fLockRev (1 bit): Specifies whether to track all edits made to this document as revisions. Additionally specifies that fRevMarking MUST be 1
        /// for the duration that fLockRev is 1. When fLockRev is 1, fLockAtn MUST be 0 and fProtEnabled SHOULD<168> be 0.
        self.fLockRev = flags4.readBit()
        
        /// l - fEmbedFonts (1 bit): Specifies that TrueType fonts are embedded in the document when the document is saved as specified in [ECMA-376]
        /// Part4, Section 2.8.2.8 embedTrueTypeFonts.
        self.fEmbedFonts = flags4.readBit()
        
        /// copts60 (2 bytes): A copts60 that specifies compatibility options.
        self.copts60 = try Copts60(dataStream: &dataStream)
        
        /// dxaTab (2 bytes): Specifies the default tab stop interval, in twips, to use when generating automatic tab stops as specified in [ECMA-376]
        /// Part4, Section 2.15.1.24 defaultTabStop.
        self.dxaTab = try dataStream.read(endianess: .littleEndian)
        
        /// cpgWebOpt (2 bytes): Specifies the code page to use when saving to HTML.
        self.cpgWebOpt = try dataStream.read(endianess: .littleEndian)
        
        /// dxaHotZ (2 bytes): Specifies the maximum amount of white space, in twips, allowed at the end of the line before attempting to hyphenate the
        /// next word as specified in [ECMA-376] Part4, Section 2.15.1.53 hyphenationZone.
        self.dxaHotZ = try dataStream.read(endianess: .littleEndian)
        
        /// cConsecHypLim (2 bytes): Specifies the maximum number of consecutive lines that can end in a hyphenated word before ignoring automatic
        /// hyphenation rules for one line as specified in [ECMA376] Part4, Section 2.15.1.21 consecutiveHyphenLimit.
        self.cConsecHypLim = try dataStream.read(endianess: .littleEndian)
        
        /// wSpare2 (2 bytes): This value MUST be zero, and MUST be ignored.
        self.wSpare2 = try dataStream.read(endianess: .littleEndian)
        
        /// dttmCreated (4 bytes): A DTTM that MAY<169> specify the date and time at which the document was created.
        self.dttmCreated = try DTTM(dataStream: &dataStream)
        
        /// dttmRevised (4 bytes): A DTTM that specifies the date and time at which the document was last saved.
        self.dttmRevised = try DTTM(dataStream: &dataStream)
        
        /// dttmLastPrint (4 bytes): A DTTM that MAY<170> specify the date and time at which the document was last printed.
        self.dttmLastPrint = try DTTM(dataStream: &dataStream)
        
        /// nRevision (2 bytes): A signed integer that MAY<171> specify the number of times that this document was resaved.
        /// This MUST be a value between 0 and 0x7FFF.
        let nRevision: Int16 = try dataStream.read(endianess: .littleEndian)
        if nRevision < 0 || nRevision > 0x7FFF {
            throw OfficeFileError.corrupted
        }
        
        self.nRevision = nRevision
        
        /// tmEdited (4 bytes): A signed integer value that MAY<172> specify the time it took, in minutes, for the document to be opened for editing
        /// and then subsequently saved.
        self.tmEdited = try dataStream.read(endianess: .littleEndian)
        
        /// cWords (4 bytes): A signed integer value that specifies the last calculated or the estimated count of words in the main document, depending
        /// on fExactCWords and fIncludeSubdocsInStats.
        self.cWords = try dataStream.read(endianess: .littleEndian)

        /// cCh (4 bytes): A signed integer value that specifies the last calculated or estimated count of characters in the main document, depending on
        /// the values of fExactCWords and fIncludeSubdocsInStats. The character count excludes whitespace.
        self.cCh = try dataStream.read(endianess: .littleEndian)
        
        /// cPg (2 bytes): A signed integer value that specifies the last calculated or estimated count of pages in the main document, depending on the
        /// values of fExactCWords and fIncludeSubdocsInStats.
        self.cPg = try dataStream.read(endianess: .littleEndian)

        /// cParas (4 bytes): A signed integer value that specifies the last calculated or estimated count of paragraphs in the main document, depending
        /// on the values of fExactCWords and fIncludeSubdocsInStats.
        self.cParas = try dataStream.read(endianess: .littleEndian)
        
        var flags5: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)

        /// m - rncEdn (2 bits): Specifies when automatic numbering for the endnote reference marks is reset to the beginning number for documents that
        /// have an nFib value that is less than or equal to 0x00D9. For those documents that rely on rncEdn, when restarted, the next automatically
        /// numbered endnote in the document is reset to the specified nEdn value. This value MUST be one of the following.
        let rncEdnRaw = UInt8(flags5.readBits(count: 2))
        guard let rncEdn = RncEdn(rawValue: rncEdnRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.rncEdn = rncEdn
        
        /// nEdn (14 bits): For those documents that have an nFib value that is less than or equal to 0x00D9, this element specifies the starting number
        /// for the first automatically numbered endnote in the document, and the first automatically numbered endnote after each restart point that is
        /// specified by the rncEdn element.
        self.nEdn = flags5.readRemainingBits()
        
        var flags6: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// epc (2 bits): Specifies where endnotes are placed on the page when they are referenced by text in the current document. This value MUST
        /// be one of the following.
        let epcRaw = UInt8(flags6.readBits(count: 2))
        guard let epc = Epc(rawValue: epcRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.epc = epc
        
        /// n - unused14 (4 bits): This value is undefined and MUST be ignored.
        self.unused14 = UInt8(flags6.readBits(count: 4))
        
        /// o - unused15 (4 bits): This value is undefined and MUST be ignored.
        self.unused15 = UInt8(flags6.readBits(count: 4))
        
        /// p - fPrintFormData (1 bit): Specifies whether to print only form field results, as specified in [ECMA376] Part4, Section 2.15.1.61 printFormsData.
        self.fPrintFormData = flags6.readBit()
        
        /// q - fSaveFormData (1 bit): Specifies whether the application SHOULD<173> only save form field contents into a comma-delimited text file
        /// and ignore all other content in the document as specified in [ECMA-376] Part4, Section 2.15.1.73 saveFormsData.
        self.fSaveFormData = flags6.readBit()
        
        /// r - fShadeFormData (1 bit): Specifies whether to display visual cues around form fields as specified in [ECMA-376] Part4, Section 2.15.1.38
        /// doNotShadeFormData, where the meaning of the doNotShadeFormData element is the opposite of fShadeFormData.
        self.fShadeFormData = flags6.readBit()
        
        /// s - fShadeMergeFields (1 bit): Specifies whether to display visual cues around mail merge fields.
        self.fShadeMergeFields = flags6.readBit()
        
        /// t - reserved2 (1 bit): This value MUST be zero, and MUST be ignored.
        self.reserved2 = flags6.readBit()
        
        /// u - fIncludeSubdocsInStats (1 bit): Specifies whether cCh, cChWS, cWords, cParas, cLines, cDBC, cChWithSubdocs, cChWSWithSubdocs,
        /// cWordsWithSubdocs, cParasWithSubdocs, cLinesWithSubdocs, or cDBCWithSubdocs are calculated and displayed, or estimated.
        self.fIncludeSubdocsInStats = flags6.readBit()
        
        /// cLines (4 bytes): A signed integer that specifies the last calculated or estimated count of lines in the main document, depending on the values
        /// of fExactCWords and fIncludeSubdocsInStats.
        self.cLines = try dataStream.read(endianess: .littleEndian)
        
        /// cWordsWithSubdocs (4 bytes): A signed integer that specifies the last calculated or estimated count of words in the main document, footnotes,
        /// endnotes, and text boxes in the main document, depending on the values of fExactCWords and fIncludeSubdocsInStats.
        self.cWordsWithSubdocs = try dataStream.read(endianess: .littleEndian)
        
        /// cChWithSubdocs (4 bytes): A signed integer that specifies the last calculated or estimated count of characters, excluding whitespace, in the
        /// main document, footnotes, endnotes, and text boxes in the main document, depending on the values of fExactCWords and
        /// fIncludeSubdocsInStats.
        self.cChWithSubdocs = try dataStream.read(endianess: .littleEndian)
        
        /// cPgWithSubdocs (2 bytes): A signed integer that specifies the last calculated or estimated count of pages in the main document, footnotes,
        /// endnotes, and text boxes that are anchored in the main document, depending on the values of fExactCWords and fIncludeSubdocsInStats.
        self.cPgWithSubdocs = try dataStream.read(endianess: .littleEndian)
        
        /// cParasWithSubdocs (4 bytes): A signed integer that specifies the last calculated or estimated count of paragraphs in the main document,
        /// footnotes, endnotes, and text boxes that are anchored in the main document, depending on the values of fExactCWords and
        /// fIncludeSubdocsInStats.
        self.cParasWithSubdocs = try dataStream.read(endianess: .littleEndian)
        
        /// cLinesWithSubdocs (4 bytes): A signed integer that specifies the last calculated or estimated count of lines in the main document, footnotes,
        /// endnotes, and text boxes that are anchored in the main document, depending on the values of fExactCWords and fIncludeSubdocsInStats.
        self.cLinesWithSubdocs = try dataStream.read(endianess: .littleEndian)
        
        /// lKeyProtDoc (4 bytes): A signed integer that specifies the hash of the password that is used with document protection (fLockRev, fProtEnabled,
        /// fLockAtn and fRevMarking), as specified in [ECMA-376] Part4, Section 2.15.1.28 documentProtection.
        self.lKeyProtDoc = try dataStream.read(endianess: .littleEndian)
        
        var flags7: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// v - wvkoSaved (3 bits): Specifies the viewing mode that was in use when the document was last saved. If the viewing mode that was in use
        /// cannot be represented by a valid value, an alternate view mode is specified. See [ECMA-376] Part4, section 2.15.1.93 view; the values are
        /// mapped as follows.
        let wvkoSavedRaw = UInt8(flags7.readBits(count: 3))
        guard let wvkoSaved = ViewingMode(rawValue: wvkoSavedRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.wvkoSaved = wvkoSaved
        
        /// pctWwdSaved (9 bits): Specifies the zoom percentage that was in use when the document was saved. A value of 0 specifies the default zoom
        /// percentage of the application. This value MUST be 0 or a value between 10 and 500.
        let pctWwdSaved = flags7.readBits(count: 9)
        if pctWwdSaved != 0 && (pctWwdSaved < 10 || pctWwdSaved > 500) {
            throw OfficeFileError.corrupted
        }
        
        self.pctWwdSaved = pctWwdSaved
        
        /// w - zkSaved (2 bits): Specifies the zoom type that was in use when the document was saved. See [ECMA-376] Part4, Section 2.18.116
        /// ST_Zoom; the values are mapped as follows.
        let zkSavedRaw = UInt8(flags7.readBits(count: 2))
        guard let zkSaved = ZoomType(rawValue: zkSavedRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.zkSaved = zkSaved
        
        /// x - unused16 (1 bit): This value is undefined and MUST be ignored.
        self.unused16 = flags7.readBit()
        
        /// y - iGutterPos (1 bit): Specifies whether the document gutter shall be positioned at the top of the pages of the document when the document
        /// is displayed. See [ECMA-376] Part4, Section 2.15.1.49 gutterAtTop, where mirrorMargins corresponds to fMirrorMargins, bookFoldPrinting
        /// corresponds to Dop2002.fFolioPrint, bookFoldRevPrinting corresponds to Dop2002.fReverseFolio and printTwoOnOne corresponds to
        /// DopTypography.f2on1.
        self.iGutterPos = flags7.readBit()
    }
    
    /// fpc (2 bits): Specifies where footnotes are placed on the page when they are referenced by text in the current document for documents that
    /// have an nFib value that is less than or equal to 0x00D9. This MUST be one of the following values
    public enum Fbc: UInt8 {
        /// 0 Specifies that all footnotes are placed at the end of the section in which they are referenced.
        case endOfSection = 0
        
        /// 1 Specifies that footnotes are displayed at the bottom margin of the page on which the note reference mark appears.
        case bottomMarginOfPage = 1
        
        /// 2 Specifies that footnotes are displayed immediately following the last line of text on the page on which the note reference mark appears.
        case immediatelyFollowingLastLine = 2
    }
    
    /// F - rncFtn (2 bits): Specifies when all automatic numbering for the footnote reference marks is restarted for documents that have an nFib value
    /// that is less than or equal to 0x00D9. For those documents that rely on rncFtn, when restarted, the next automatically numbered footnote in the
    /// document restarts to the specified nFtn value. This MUST be one of the following values.
    public enum RncFtn: UInt8 {
        /// 0 Specifies that the numbering of footnotes continues from the previous section in the document.
        case continuesFromPreviousSection = 0
        
        /// 1 Specifies that the numbering of footnotes is reset to the starting value for each unique section in the document.
        case resetToStartingValueForEachUniqueSection = 1
        
        /// 2 Specifies that the numbering of footnotes is reset to the starting value for each unique page in the document.
        case resetToStartingValueForEachUniquePage = 2
    }
    
    /// m - rncEdn (2 bits): Specifies when automatic numbering for the endnote reference marks is reset to the beginning number for documents that
    /// have an nFib value that is less than or equal to 0x00D9. For those documents that rely on rncEdn, when restarted, the next automatically
    /// numbered endnote in the document is reset to the specified nEdn value. This value MUST be one of the following.
    public enum RncEdn: UInt8 {
        /// 0 Specifies that the numbering of endnotes continues from the previous section in the document.
        case continuesFromPreviousSection = 0
        
        /// 1 Specifies that the numbering of endnotes is reset to its starting value for each unique section in the document.
        case resetToStartingValueForEachUniqueSection = 1
        
        /// 2 Specifies that the numbering of endnotes is reset to its starting value for each unique page in the document.
        case resetToStartingValueForEachUniquePage = 2
    }

    /// epc (2 bits): Specifies where endnotes are placed on the page when they are referenced by text in the current document. This value MUST
    /// be one of the following.
    public enum Epc: UInt8 {
        /// 0 Specifies that endnotes are placed at the end of the section in which they are referenced.
        case placedAtEndOfSection = 0
        
        /// 3 Specifies that all endnotes are placed at the end of the current document, regardless of the section within which they are referenced.
        case placedAtEndOfCurrentDocument = 3
    }
    
    /// v - wvkoSaved (3 bits): Specifies the viewing mode that was in use when the document was last saved. If the viewing mode that was in use cannot
    /// be represented by a valid value, an alternate view mode is specified. See [ECMA-376] Part4, section 2.15.1.93 view; the values are mapped as
    /// follows.
    /// A value of 0 specifies the default view mode of the application.
    public enum ViewingMode: UInt8 {
        // 0 none
        case none = 0
        
        /// 1 print
        case print = 1
        
        /// 2 outline
        case outline = 2
        
        /// 3 masterPages
        case masterPages = 3
        
        /// 4 normal
        case normal = 4
        
        /// 5 web
        case web = 5
    }
    
    /// w - zkSaved (2 bits): Specifies the zoom type that was in use when the document was saved. See [ECMA-376] Part4, Section 2.18.116
    /// ST_Zoom; the values are mapped as follows.
    public enum ZoomType: UInt8 {
        /// 0 none
        case none = 0
        
        /// 1 fullPage
        case fullPage = 1
        
        /// 2 bestFit
        case bestFit = 2
        
        /// 3 textFit
        case textFit = 3
    }
}
