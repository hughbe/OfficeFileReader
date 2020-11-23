//
//  Dop2003.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.7 Dop2003
/// The Dop2003 structure contains document and compatibility settings. These settings influence the appearance and behavior of the current document
/// and store document-level state.
public struct Dop2003 {
    public let dop2002: Dop2002
    public let fTreatLockAtnAsReadOnly: Bool
    public let fStyleLock: Bool
    public let fAutoFmtOverride: Bool
    public let fRemoveWordML: Bool
    public let fApplyCustomXForm: Bool
    public let fStyleLockEnforced: Bool
    public let fFakeLockAtn: Bool
    public let fIgnoreMixedContent: Bool
    public let fShowPlaceholderText: Bool
    public let unused: Bool
    public let fWord97Doc: Bool
    public let fStyleLockTheme: Bool
    public let fStyleLockQFSet: Bool
    public let empty1: UInt32
    public let fReadingModeInkLockDown: Bool
    public let fAcetateShowInkAtn: Bool
    public let fFilterDttm: Bool
    public let fEnforceDocProt: Bool
    public let iDocProtCur: DocumentProtectionMode
    public let fDispBkSpSaved: Bool
    public let empty2: UInt8
    public let dxaPageLock: UInt32
    public let dyaPageLock: UInt32
    public let pctFontLock: UInt32
    public let grfitbid: ToolbarShownBecauseOfDocumentState
    public let empty3: UInt8
    public let ilfoMacAtCleanup: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// dop2002 (594 bytes): A Dop2002 that specifies document and compatibility settings.
        self.dop2002 = try Dop2002(dataStream: &dataStream)
        
        var flags1: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fTreatLockAtnAsReadOnly (1 bit): Specifies whether DopBase.fLockAtn means read-only protection instead of protect for comments.
        /// By default, this value is 0.
        self.fTreatLockAtnAsReadOnly = flags1.readBit()
        
        /// B - fStyleLock (1 bit): Specifies whether the styles available to use in the document are restricted to those styles with
        /// STD.Stdf.StdfBase.GRFSTD.fLocked set to 1 when style lock is enforced (fStyleLockEnforced is 1). By default, this value is 0.
        self.fStyleLock = flags1.readBit()
        
        /// C - fAutoFmtOverride (1 bit): Specifies whether to allow automatic formatting to override the fStyleLock setting as specified in [ECMA-376]
        /// Part 4, Section 2.15.1.9 autoFormatOverride. By default, this value is 0.
        self.fAutoFmtOverride = flags1.readBit()
        
        /// D - fRemoveWordML (1 bit): Specifies whether to save only custom XML markup when saving to XML as specified in [ECMA-376] Part 4,
        /// Section 2.15.1.77 saveXmlDataOnly. By default, this value is 0.
        self.fRemoveWordML = flags1.readBit()
        
        /// E - fApplyCustomXForm (1 bit): Specifies whether to save the document through the custom XML transform specified via
        /// FibRgFcLcb2003.fcCustomXForm and FibRgFcLcb2003.lcbCustomXForm when saving to XML as specified in [ECMA-376] Part 4, Section
        /// 2.15.1.92 useXSLTWhenSaving. By default, this value is 0.
        self.fApplyCustomXForm = flags1.readBit()
        
        /// F - fStyleLockEnforced (1 bit): Specifies whether to actively enforce the style restriction as specified by fStyleLock. If fStyleLockEnforced is 1,
        /// fStyleLock MUST be 1. By default, this value is 0.
        self.fStyleLockEnforced = flags1.readBit()
        
        /// G - fFakeLockAtn (1 bit): Specifies that the DopBase.fLockAtn setting is to be honored only if the application does not support fStyleLock.
        /// By default, this value is 0.
        self.fFakeLockAtn = flags1.readBit()
        
        /// H - fIgnoreMixedContent (1 bit): Specifies whether to ignore all text not in leaf nodes of the custom XML when validating custom XML markup
        /// as specified in [ECMA-376] Part 4, Section 2.15.1.54 ignoreMixedContent. By default, this value is 0.
        self.fIgnoreMixedContent = flags1.readBit()
        
        /// I - fShowPlaceholderText (1 bit): Specifies whether to show some form of in-document placeholder text when custom XML markup contains
        /// no content and the custom XML tags are not being displayed as specified in [ECMA-376] Part 4, Section 2.15.1.4 alwaysShowPlaceholderText.
        /// By default, this value is 0.
        self.fShowPlaceholderText = flags1.readBit()
        
        /// J - unused (1 bit): This value is undefined and MUST be ignored.
        self.unused = flags1.readBit()
        
        /// K - fWord97Doc (1 bit): Specifies whether to disable UI for features incompatible with the Word Binary File Format as specified in [ECMA-376]
        /// Part 4, Section 2.15.3.54 uiCompat97To2003. By default, this value is 0.
        self.fWord97Doc = flags1.readBit()
        
        /// L - fStyleLockTheme (1 bit): Specifies whether to prevent modification of the document theme information as specified in [ECMA-376] Part 4,
        /// Section 2.15.1.85 styleLockTheme. By default, this value is 0.
        self.fStyleLockTheme = flags1.readBit()
        
        /// M - fStyleLockQFSet (1 bit): Specifies whether to prevent the replacement of style sets as specified in [ECMA-376] Part 4, Section 2.15.1.84
        /// styleLockQFSet. By default, this value is 0.
        self.fStyleLockQFSet = flags1.readBit()
        
        /// N - empty1 (19 bits): This value MUST be zero, and MUST be ignored.
        self.empty1 = flags1.readRemainingBits()
        
        var flags2: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)

        /// O - fReadingModeInkLockDown (1 bit): Specifies whether to permanently set the layout to the specific set of page and text-sizing parameters
        /// specified by dxaPageLock, dyaPageLock and pctFontLock as specified in [ECMA-376] Part 4, Section 2.15.1.66 readModeInkLockDown. By
        /// default, this value is 0.
        self.fReadingModeInkLockDown = flags2.readBit()
        
        /// P - fAcetateShowInkAtn (1 bit): Specifies whether to include ink annotations when the contents of this document are displayed. By default, this
        /// value is 1.
        self.fAcetateShowInkAtn = flags2.readBit()
        
        /// Q - fFilterDttm (1 bit): Specifies whether to remove date and time information from annotations as specified in [ECMA-376] Part 4, Section
        /// 2.15.1.67 removeDateAndTime. By default, this value is 0.
        self.fFilterDttm = flags2.readBit()
        
        /// R - fEnforceDocProt (1 bit): Specifies whether to enforce the document protection mode that is specified by iDocProtCur. By default, this value is 0.
        self.fEnforceDocProt = flags2.readBit()
        
        /// S - iDocProtCur (3 bits): Specifies the document protection mode that is in effect when fEnforceDocProt is set to 1. This MUST be set to one of
        /// the following values.
        let iDocProtCurRaw: UInt8 = UInt8(flags2.readBits(count: 3))
        guard let iDocProtCur = DocumentProtectionMode(rawValue: iDocProtCurRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iDocProtCur = iDocProtCur
        
        /// T - fDispBkSpSaved (1 bit): Specifies whether to display background objects when displaying the document in print layout view as specified in
        /// [ECMA-376] Part 4, Section 2.15.1.25 displayBackgroundShape. By default, this value is 0.
        self.fDispBkSpSaved = flags2.readBit()
        
        /// empty2 (8 bits): This value MUST be zero, and MUST be ignored.
        self.empty2 = UInt8(flags2.readRemainingBits())
        
        /// dxaPageLock (4 bytes): Specifies the width, in twips, of the virtual pages that are used in this document when fReadingModeInkLockDown is 1.
        /// By default, this value is 0.
        self.dxaPageLock = try dataStream.read(endianess: .littleEndian)
        
        /// dyaPageLock (4 bytes): Specifies the height, in twips, of the virtual pages that are used in this document when fReadingModeInkLockDown is 1.
        /// By default, this value is 0.
        self.dyaPageLock = try dataStream.read(endianess: .littleEndian)
        
        /// pctFontLock (4 bytes): Specifies the percentage to which text in the document is scaled before it is displayed on a virtual page when
        /// fReadingModeInkLockDown is 1. By default, this value is 0.
        self.pctFontLock = try dataStream.read(endianess: .littleEndian)
        
        /// grfitbid (1 byte): A bit field that specifies what toolbars were shown because of document state rather than explicit user action at the moment of
        /// saving. This value MUST be composed of the following bit values.
        self.grfitbid = ToolbarShownBecauseOfDocumentState(rawValue: try dataStream.read())
        
        /// empty3 (1 byte): This value MUST be zero, and MUST be ignored.
        self.empty3 = try dataStream.read()
        
        /// ilfoMacAtCleanup (2 bytes): Specifies the largest ilfo value (index into PlfLfo) such that all PlfLfo entries from 0 to ilfoMacAtCleanup are searched
        /// for unused values to be pruned as specified in [ECMA-376] Part 4, Section 2.9.20 numIdMacAtCleanup. By default, this value is 0.
        self.ilfoMacAtCleanup = try dataStream.read(endianess: .littleEndian)
    }
    
    /// S - iDocProtCur (3 bits): Specifies the document protection mode that is in effect when fEnforceDocProt is set to 1. This MUST be set to one of
    /// the following values.
    public enum DocumentProtectionMode: UInt8 {
        /// 0 Track all edits that are made to the document as revisions.
        case trackAllEdits = 0
        
        /// 1 Comments are permitted to be inserted or deleted, and regions that are delimited by range permissions can be edited if they match the
        /// editing rights of the user account which is performing the editing. See PRTI.
        case commentsPermittedToBeInserted = 1
        
        /// 2 Edits are restricted to the editing of form fields in sections where sprmSFProtected results in a value of "true". Edits are not restricted in
        /// sections where sprmSFProtected is not present or has a value of "false".
        case editsRestrictedToFormFieldsInSFProtectedSections = 2
        
        /// 3 (Default) Edits are restricted to regions delimited by range permissions which match the editing rights of the user account which is performing
        /// the editing. See PRTI.
        case editsRestrictedToRegionsDelimitedByRangePermisions = 3
        
        /// 7 There are no editing restrictions.
        case noEditingRestrictions = 7
    }
    
    /// grfitbid (1 byte): A bit field that specifies what toolbars were shown because of document state rather than explicit user action at the moment of saving.
    /// This value MUST be composed of the following bit values.
    public struct ToolbarShownBecauseOfDocumentState: OptionSet {
        public let rawValue: UInt8
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
        
        /// 0x00 (default) No toolbar was shown because of document state.
        public static let noToolbarShown = ToolbarShownBecauseOfDocumentState([])
        
        /// 0x01 The reviewing toolbar was shown.
        public static let reviewingToolbarShown = ToolbarShownBecauseOfDocumentState(rawValue: 0x01)
        
        /// 0x02 The Web toolbar was shown.
        public static let webToolbarShown = ToolbarShownBecauseOfDocumentState(rawValue: 0x02)
        
        /// 0x04 The mail merge toolbar was shown.
        public static let mailMergeToolbarShown = ToolbarShownBecauseOfDocumentState(rawValue: 0x04)
        
        public static let all: ToolbarShownBecauseOfDocumentState = [.noToolbarShown, .reviewingToolbarShown, .webToolbarShown, .mailMergeToolbarShown]
    }
}
