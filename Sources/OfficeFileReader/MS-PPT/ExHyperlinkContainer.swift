//
//  ExHyperlinkContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.16 ExHyperlinkContainer
/// Referenced by: ExObjListSubContainer
/// A container record that specifies information about a hyperlink.
public struct ExHyperlinkContainer {
    public let rh: RecordHeader
    public let exHyperlinkAtom: ExHyperlinkAtom
    public let friendlyNameAtom: FriendlyNameAtom?
    public let targetAtom: TargetAtom?
    public let locationAtom: LocationAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalHyperlink
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalHyperlink else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exHyperlinkAtom (12 bytes): An ExHyperlinkAtom record (section 2.10.17) that specifies information needed to identify this hyperlink.
        self.exHyperlinkAtom = try ExHyperlinkAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.friendlyNameAtom = nil
            self.targetAtom = nil
            self.locationAtom = nil
            return
        }
        
        /// friendlyNameAtom (variable): An optional FriendlyNameAtom record that specifies the userreadable name of this hyperlink.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .cString && nextAtom1.recInstance == 0x000 {
            self.friendlyNameAtom = try FriendlyNameAtom(dataStream: &dataStream)
        } else {
            self.friendlyNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.targetAtom = nil
            self.locationAtom = nil
            return
        }
        
        /// targetAtom (variable): An optional TargetAtom record that specifies the full path of the destination file of this hyperlink.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .cString && nextAtom2.recInstance == 0x001 {
            self.targetAtom = try TargetAtom(dataStream: &dataStream)
        } else {
            self.targetAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.locationAtom = nil
            return
        }
        
        /// locationAtom (variable): An optional LocationAtom record that specifies the location within the destination file of the hyperlink.
        let nextAtom3 = try dataStream.peekRecordHeader()
        if nextAtom3.recType == .cString && nextAtom3.recInstance == 0x003 {
            self.locationAtom = try LocationAtom(dataStream: &dataStream)
        } else {
            self.locationAtom = nil
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
