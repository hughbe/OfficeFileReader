//
//  DrawingGroupContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.3 DrawingGroupContainer
/// Referenced by: DocumentContainer
/// A container record that specifies drawing information for the document.
public struct DrawingGroupContainer {
    public let rh: RecordHeader
    public let officeArtDgg: OfficeArtDggContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_DrawingGroup (section 2.13.24).
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .drawingGroup else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// officeArtDgg (variable): An OfficeArtDggContainer ([MS-ODRAW] section 2.2.12) that specifies drawing information for the document.
        self.officeArtDgg = try OfficeArtDggContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
