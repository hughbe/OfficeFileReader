//
//  OLEVerbEnum.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.13.17 OLEVerbEnum
/// Referenced by: AnimationInfoAtom, InteractiveInfoAtom
/// An enumeration that specifies the identifier of an OLE verb. Because this enumeration refers to values defined by the OLE object that it is linked
/// to, the sample values listed in the table are placeholders that specify which command to run. The actual number of verbs depends on the OLE
/// object itself.
public enum OLEVerbEnum: UInt8 {
    /// OV_Primary 0x00 The primary verb is to be used.
    case primary = 0x00
    
    /// OV_Secondary 0x01 The secondary verb is to be used.
    case secondary = 0x01
    
    /// OV_Tertiary 0x02 The tertiary verb is to be used.
    case tertiary = 0x02
}
