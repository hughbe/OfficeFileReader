//
//  DiffTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

/// [MS-PPT] 2.13.8 DiffTypeEnum
/// Referenced by: DiffRecordHeaders
/// An enumeration that specifies different types of document changes made by a reviewer
public enum DiffTypeEnum: UInt32 {
    /// Diff_DocDiff 0x00000000 Document level change.
    case docDiff = 0x00000000

    /// Diff_SlideDiff 0x00000002 Slide change.
    case slideDiff = 0x00000002

    /// Diff_MainMasterDiff 0x00000003 Main master change.
    case mainMasterDiff = 0x00000003

    /// Diff_SlideListDiff 0x00000004 Slide list change.
    case slideListDiff = 0x00000004

    /// Diff_MasterListDiff 0x00000005 Master list change.
    case masterListDiff = 0x00000005

    /// Diff_ShapeListDiff 0x00000006 Shape list change.
    case shapeListDiff = 0x00000006

    /// Diff_ShapeDiff 0x00000007 Shape change.
    case shapeDiff = 0x00000007

    /// Diff_TextDiff 0x00000009 Text change.
    case textDiff = 0x00000009

    /// Diff_NotesDiff 0x0000000A Notes change.
    case notesDiff = 0x0000000A

    /// Diff_SlideShowDiff 0x0000000B Slide show change.
    case slideShowDiff = 0x0000000B

    /// Diff_HeaderFooterDiff 0x0000000C Header footer change.
    case headerFooterDiff = 0x0000000C

    /// Diff_NamedShowDiff 0x0000000E Named show change.
    case namedShowDiff = 0x0000000E

    /// Diff_NamedShowListDiff 0x0000000F Named show list change.
    case namedShowListDiff = 0x0000000F

    /// Diff_RecolorInfoDiff 0x00000012 Recolor info change.
    case recolorInfoDiff = 0x00000012

    /// Diff_ExternalObjectDiff 0x00000013 External object change.
    case externalObjectDiff = 0x00000013

    /// Diff_TableListDiff 0x00000015 Table list change.
    case tableListDiff = 0x00000015

    /// Diff_TableDiff 0x00000016 Table change.
    case tableDiff = 0x00000016

    /// Diff_InteractiveInfoDiff 0x00000017 Interactive information change.
    case interactiveInfoDiff = 0x00000017
}
