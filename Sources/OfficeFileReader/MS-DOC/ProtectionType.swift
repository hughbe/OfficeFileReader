//
//  ProtectionType.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-DOC] 2.9.219 ProtectionType
/// The ProtectionType enumeration identifies common types of editing protection for ranges of text in a document.
public enum ProtectionType: UInt16 {
    /// iProtNone 0x0000 Allow all changes.
    case none = 0x0000
    
    /// iProtReadWrite 0x0001 Allow the editing of the regions that are marked as editable in forms.
    case readWrite = 0x0001
    
    /// iProtRevision 0x0002 Allow the creation, deletion, and editing of annotations. For all other changes: Allow them, but track them with revision marks.
    case revision = 0x0002
    
    /// iProtComment 0x0003 Allow the creation, deletion, and editing of annotations, but allow no other changes.
    case comment = 0x0003
    
    /// iProtRead 0x0004 Allow no changes.
    case read = 0x0004
}
