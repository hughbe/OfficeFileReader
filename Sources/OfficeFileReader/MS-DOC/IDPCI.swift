//
//  IDPCI.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.120 IDPCI
/// The IDPCI structure specifies the kind of formatting that the format consistency checker flagged within a region of text in the document.
/// The possible values are showing following.
public enum IDPCI: UInt32 {
    /// idpciFmt 0x00000000 Character formatting in the region is inconsistent with formatting in the rest of the document.
    case fmt = 0x00000000
    
    /// idpciStyChar 0x00000001 Character style in the region is identical to a character style elsewhere in the document.
    case styChar = 0x00000001
    
    /// idpciPapc 0x00000002 Paragraph formatting in the region is inconsistent with formatting in the rest of the document.
    case papc = 0x00000002
    
    /// idpciStyPara 0x00000003 Paragraph style in the region is identical to a paragraph style elsewhere in the document.
    case styPara = 0x00000003
    
    /// idpciLvl 0x00000004 Formatting of items in a numbered or bulleted list in the region is inconsistent with formatting in the rest of the document.
    case lvl = 0x00000004
    
    /// idpciStyList 0x00000005 Bulleted or numbered list style in the region is identical to a bulleted or numbered list style elsewhere in the document.
    case styList = 0x00000005
    
    /// idpciStyTable 0x00000006 Table style in the region is identical to a table style elsewhere in the document.
    case styTable = 0x00000006
    
    /// idpciRevChar 0x00000007 (Revised Character) Characters in the region were changed while revision marking was on.
    case revChar = 0x00000007
    
    /// idpciRevPara 0x00000008 (Revised Paragraph) Paragraphs in the region were changed while revision marking was on.
    case revPara = 0x00000008
    
    /// idpciRevTable 0x00000009 (Revised Table) Tables in the region were changed while revision marking was on.
    case revTable = 0x00000009
    
    /// idpciRevSect 0x0000000A (Revised Section) Sections in the region were changed while revision marking was on.
    case revSect = 0x0000000A
    
    /// idpciImage 0x0000000B A picture defined inline in the region has been combined, to save space, with an identical picture defined elsewhere in the
    /// document.
    case image = 0x0000000B
}
