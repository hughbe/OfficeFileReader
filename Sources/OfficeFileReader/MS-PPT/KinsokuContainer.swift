//
//  KinsokuContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.2 KinsokuContainer
/// Referenced by: DocumentTextInfoContainer
/// A container record that specifies user preferences for East Asian text line breaking settings.
public struct KinsokuContainer {
    public let rh: RecordHeader
    public let kinsokuAtom: KinsokuAtom
    public let kinsokuLeadingAtom: KinsokuLeadingAtom?
    public let kinsokuFollowingAtom: KinsokuFollowingAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x002.
        /// rh.recType MUST be an RT_Kinsoku.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x002 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .kinsoku else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// kinsokuAtom (12 bytes): A KinsokuAtom record that specifies the type of East Asian text line breaking settings.
        self.kinsokuAtom = try KinsokuAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.kinsokuLeadingAtom = nil
            self.kinsokuFollowingAtom = nil
            return
        }
        
        /// kinsokuLeadingAtom (variable): An optional KinsokuLeadingAtom record that specifies a list of characters that cannot appear immediately
        /// after a line break of East Asian text. It MUST exist if and only if kinsokuAtom.level is 0x00000002. If this field exists and the document
        /// contains a Kinsoku9Container record (section 2.9.6), the Kinsoku9Container record MUST NOT contain a kinsokuLeadingAtom field.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .cString && nextAtom1.recInstance == 0x000 {
            self.kinsokuLeadingAtom = try KinsokuLeadingAtom(dataStream: &dataStream)
        } else {
            self.kinsokuLeadingAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.kinsokuFollowingAtom = nil
            return
        }
        
        /// kinsokuFollowingAtom (variable): An optional KinsokuFollowingAtom record that specifies a list of characters that cannot appear immediately
        /// before a line break of East Asian text. It MUST exist if and only if kinsokuAtom.level is 0x00000002. If this field exists and the document
        /// contains a Kinsoku9Container record, the Kinsoku9Container record MUST NOT contain a kinsokuFollowingAtom field.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .cString && nextAtom2.recInstance == 0x001 {
            self.kinsokuFollowingAtom = try KinsokuFollowingAtom(dataStream: &dataStream)
        } else {
            self.kinsokuFollowingAtom = nil
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
