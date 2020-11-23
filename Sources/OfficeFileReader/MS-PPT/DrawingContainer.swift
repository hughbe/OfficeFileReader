//
//  DrawingContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.13 DrawingContainer
/// Referenced by: HandoutContainer, MainMasterContainer, NotesContainer, SlideContainer
/// A container record that specifies drawing information for a slide.
public struct DrawingContainer {
    public let rh: RecordHeader
    public let officeArtDg: OfficeArtDgContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_Drawing.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .drawing else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// OfficeArtDg (variable): An OfficeArtDgContainer ([MS-ODRAW] section 2.2.13) that specifies drawing information for a slide.
        self.officeArtDg = try OfficeArtDgContainer(dataStream: &dataStream)

        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
