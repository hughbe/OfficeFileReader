//
//  OutlineViewInfoContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.6 OutlineViewInfoContainer
/// Referenced by: DocInfoListSubContainerOrAtom
/// A container record that specifies display preferences for when a user interface shows the presentation in a manner optimized for the display of the
/// text on the presentation slides.
public struct OutlineViewInfoContainer {
    public let rh: RecordHeader
    public let noZoomViewInfo: NoZoomViewInfoAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be RT_OutlineViewInfo (section 2.13.24).
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        // Note: spec requires 0x001 but seen 0x000
        guard rh.recInstance == 0x001 || rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .outlineViewInfo else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.noZoomViewInfo = nil
            return
        }
        
        /// noZoomViewInfo (60 bytes): An optional NoZoomViewInfoAtom record that specifies origin and scaling information.
        self.noZoomViewInfo = try NoZoomViewInfoAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
