//
//  ExOleObjSubTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

/// [MS-PPT] 2.13.11 ExOleObjSubTypeEnum
/// Referenced by: ExOleObjAtom
/// An enumeration that specifies the subtype of an OLE object based on its ProgID (described in [MSDN-COM]).
public enum ExOleObjSubTypeEnum: UInt32 {
    /// ExOleSub_Default 0x00000000 Used when none of the following apply.
    case `default` = 0x00000000
    
    /// ExOleSub_Clipart 0x00000001 MS_ClipArt_Gallery
    case clipart = 0x00000001
    
    /// ExOleSub_WordDoc 0x00000002 Word.Document or Word.DocumentMacroEnabled
    case wordDoc = 0x00000002
    
    /// ExOleSub_Excel 0x00000003 Excel.Sheet, Excel.SheetMacroEnabled or SheetBinaryMacroEnabled
    case excel = 0x00000003
    
    /// ExOleSub_Graph 0x00000004 MSGraph.Chart or MSGraph
    case graph = 0x00000004
    
    /// ExOleSub_OrgChart 0x00000005 OrgChart, MSOrgChart or OrgPlusWOPX
    case orgChart = 0x00000005
    
    /// ExOleSub_Equation 0x00000006 Equations or Equation
    case equation = 0x00000006
    
    /// ExOleSub_WordArt 0x00000007 MSWordArt
    case wordArt = 0x00000007
    
    /// ExOleSub_Sound 0x00000008 SoundRec
    case sound = 0x00000008
    
    /// ExOleSub_Project 0x0000000C MSProject
    case project = 0x0000000C
    
    /// ExOleSub_NoteIt 0x0000000D Note-It
    case noteIt = 0x0000000D
    
    /// ExOleSub_ExcelChart 0x0000000E Excel.Chart
    case excelChart = 0x0000000E
    
    /// ExOleSub_MediaPlayer 0x0000000F MPlayer, MIDFile or AVIFile
    case mediaPlayer = 0x0000000F
    
    /// ExOleSub_WordPad 0x00000010 WordPad.Document
    case wordPad = 0x00000010
    
    /// ExOleSub_Visio 0x00000011 Visio.Drawing<113>
    case visio = 0x00000011
    
    /// ExOleSub_WordODF 0x00000012 Word.OpenDocumentText<114>
    case wordODF = 0x00000012
    
    /// ExOleSub_ExcelODF 0x00000013 Excel.OpenDocumentSpreadsheet<115>
    case excelODF = 0x00000013
    
    /// ExOleSub_PPTODF 0x00000014 PowerPoint.OpenDocumentPresentation<116>
    case pptODF = 0x00000014
}
