//
//  ExControlContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.10 ExControlContainer
/// Referenced by: ExObjListSubContainer
/// A container record that specifies information about an ActiveX control.
public struct ExControlContainer {
    public let rh: RecordHeader
    public let exControlAtom: ExControlAtom
    public let exOleObjAtom: ExOleObjAtom
    public let menuNameAtom: MenuNameAtom?
    public let progIdAtom: ProgIDAtom?
    public let clipboardNameAtom: ClipboardNameAtom?
    public let metafile: MetafileBlob?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalOleControl.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalOleControl else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exControlAtom (12 bytes): An ExControlAtom record that specifies the identifying information for this ActiveX control.
        self.exControlAtom = try ExControlAtom(dataStream: &dataStream)
        
        /// exOleObjAtom (32 bytes): An ExOleObjAtom record (section 2.10.12) that specifies information about this ActiveX control as an OLE object.
        self.exOleObjAtom = try ExOleObjAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.menuNameAtom = nil
            self.progIdAtom = nil
            self.clipboardNameAtom = nil
            self.metafile = nil
            return
        }
        
        /// menuNameAtom (variable): An optional MenuNameAtom record that specifies the name to use in the user interface.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .cString && nextAtom1.recInstance == 0x001 {
            self.menuNameAtom = try MenuNameAtom(dataStream: &dataStream)
        } else {
            self.menuNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.progIdAtom = nil
            self.clipboardNameAtom = nil
            self.metafile = nil
            return
        }
        
        /// progIdAtom (variable): An optional ProgIDAtom record that specifies the ProgID (described in [MSDN-COM]) of the ActiveX control.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .cString && nextAtom2.recInstance == 0x002 {
            self.progIdAtom = try ProgIDAtom(dataStream: &dataStream)
        } else {
            self.progIdAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.clipboardNameAtom = nil
            self.metafile = nil
            return
        }
        
        /// clipboardNameAtom (variable): An optional ClipboardNameAtom record that specifies the name used by the user interface during copy and
        /// paste operations.
        let nextAtom3 = try dataStream.peekRecordHeader()
        if nextAtom3.recType == .cString && nextAtom3.recInstance == 0x003 {
            self.clipboardNameAtom = try ClipboardNameAtom(dataStream: &dataStream)
        } else {
            self.clipboardNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.metafile = nil
            return
        }
        
        /// metafile (variable): An optional MetafileBlob record that specifies the icon for the ActiveX control.
        self.metafile = try MetafileBlob(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
