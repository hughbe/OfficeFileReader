//
//  SorterViewInfoContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.13 SorterViewInfoContainer
/// Referenced by: DocInfoListSubContainerOrAtom
/// A container record that specifies display preferences for when a user interface shows the presentation in a manner optimized for the simultaneous
/// display of multiple presentation slides.
public struct SorterViewInfoContainer {
    public let rh: RecordHeader
    public let viewInfo: NoZoomViewInfoAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be RT_SorterViewInfo (section 2.13.24).
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .sorterViewInfo else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.viewInfo = nil
            return
        }
        
        /// viewInfo (60 bytes): An optional NoZoomViewInfoAtom record that specifies origin and scaling information.
        self.viewInfo = try NoZoomViewInfoAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
