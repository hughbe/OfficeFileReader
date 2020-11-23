//
//  ExHyperlinkAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.17 ExHyperlinkAtom
/// Referenced by: ExHyperlinkContainer
/// An atom record that specifies the value needed to look up a hyperlink within the collection of external objects as specified by the ExObjListContainer
/// record (section 2.10.1).
public struct ExHyperlinkAtom {
    public let rh: RecordHeader
    public let exHyperlinkId: ExHyperlinkId
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalHyperlinkAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalHyperlinkAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exHyperlinkId (4 bytes): An ExHyperlinkId (section 2.2.5) that specifies the identifier of this hyperlink.
        self.exHyperlinkId = try ExHyperlinkId(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
