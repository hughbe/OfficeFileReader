//
//  ExOleObjTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

/// [MS-PPT] 2.13.12 ExOleObjTypeEnum
/// Referenced by: ExOleObjAtom
/// An enumeration that specifies the type of an OLE object.
public enum ExOleObjTypeEnum: UInt32 {
    /// ExOle_Embedded 0x00000000 An embedded OLE object; the object is serialized and saved within the file.
    case embedded = 0x00000000
    
    /// ExOle_Link 0x00000001 A linked OLE object; the object is saved outside of the file.
    case link = 0x00000001
    
    /// ExOle_Control 0x00000002 The OLE object is an ActiveX control.
    case control = 0x00000002
}
