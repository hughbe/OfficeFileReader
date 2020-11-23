//
//  OfficeArtContent.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.171 OfficeArtContent
/// The OfficeArtContent structure specifies information about a drawing in the document. The delay stream that is referenced in [MS-ODRAW] is the
/// WordDocument stream.
public struct OfficeArtContent {
    public let drawingGroupData: OfficeArtDggContainer
    public let drawings: [OfficeArtWordDrawing]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        /// DrawingGroupData (variable): An OfficeArtDggContainer element, as specified in [MS-ODRAW] section 2.2.12, that contains the drawing group
        /// information for the document.
        self.drawingGroupData = try OfficeArtDggContainer(dataStream: &dataStream)
        
        /// Drawings (variable): An array of OfficeArtWordDrawing elements that specifies information about the drawings in the document. Drawings for the
        /// Main Document are located at index 0 of this array. Drawings for the Header Document are located at index 1 of this array.
        var drawings: [OfficeArtWordDrawing] = []
        while dataStream.position - startPosition < size {
            drawings.append(try OfficeArtWordDrawing(dataStream: &dataStream))
        }
        
        self.drawings = drawings
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
