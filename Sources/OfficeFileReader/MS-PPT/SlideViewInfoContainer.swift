//
//  SlideViewInfoContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.9 SlideViewInfoContainer
/// Referenced by: SlideViewInfoInstance
/// A container record that specifies display preferences for when a user interface shows the presentation in a manner optimized for the display of
/// presentation slides.
public struct SlideViewInfoContainer {
    public let rh: RecordHeader
    public let slideViewInfoAtom: SlideViewInfoAtom
    public let zoomViewInfoAtom: ZoomViewInfoAtom?
    public let rgGuideAtom: [GuideAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlideViewInfo (section 2.13.24).
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideViewInfo else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// slideViewInfoAtom (11 bytes): A SlideViewInfoAtom record that specifies editing preferences for content positioning.
        self.slideViewInfoAtom = try SlideViewInfoAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.zoomViewInfoAtom = nil
            self.rgGuideAtom = []
            return
        }
        
        /// zoomViewInfoAtom (60 bytes): An optional ZoomViewInfoAtom record that specifies origin and scaling information.
        if try dataStream.peekRecordHeader().recType == .viewInfoAtom {
            self.zoomViewInfoAtom = try ZoomViewInfoAtom(dataStream: &dataStream)
        } else {
            self.zoomViewInfoAtom = nil
        }
        
        /// rgGuideAtom (variable): An array of GuideAtom records that specifies guides for the slide view. It MUST NOT contain more than eight
        /// GuideAtom records with type equal to 0x00000000 (horizontal) and MUST NOT contain more than eight GuideAtom records with type
        /// equal to 0x00000001 (vertical). The array continues while rh.recType of the GuideAtom record is equal to RT_GuideAtom.
        var rgGuideAtom: [GuideAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            guard try dataStream.peekRecordHeader().recType == .guideAtom else {
                break
            }
            
            rgGuideAtom.append(try GuideAtom(dataStream: &dataStream))
        }
        
        self.rgGuideAtom = rgGuideAtom
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
