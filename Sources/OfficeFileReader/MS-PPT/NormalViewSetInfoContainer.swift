//
//  NormalViewSetInfoContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.2 NormalViewSetInfoContainer
/// Referenced by: DocInfoListSubContainerOrAtom
/// A container record that specifies display preferences for when a user interface shows the presentation in a manner optimized for the simultaneous
/// display of all presentation slides, a specific presentation slide, and the text of the notes slide associated with that specific presentation slide.
public struct NormalViewSetInfoContainer {
    public let rh: RecordHeader
    public let normalViewSetInfoAtom: NormalViewSetInfoAtom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be RT_NormalViewSetInfo9 (section 2.13.24).
        /// rh.Len MUST be 0x0000001C.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .normalViewSetInfo9 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000001C else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// normalViewSetInfoAtom (28 bytes): A NormalViewSetInfoAtom record that specifies the display preferences.
        self.normalViewSetInfoAtom = try NormalViewSetInfoAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
