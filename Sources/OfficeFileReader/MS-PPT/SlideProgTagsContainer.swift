//
//  SlideProgTagsContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.19 SlideProgTagsContainer
/// Referenced by: HandoutContainer, MainMasterContainer, NotesContainer, SlideContainer
/// A container record that specifies programmable tags with additional slide data.
public struct SlideProgTagsContainer {
    public let rh: RecordHeader
    public let rgChildRec: [SlideProgTagsSubContainerOrAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_ProgTags (section 2.13.24).
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .progTags else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgChildRec (variable): An array of SlideProgTagsSubContainerOrAtom records that specifies additional slide data. The size, in bytes, of
        /// the array is specified by rh.recLen. The array MUST NOT contain more than one of each of the following records:
        /// PP9SlideBinaryTagExtension, PP10SlideBinaryTagExtension, or PP12SlideBinaryTagExtension.
        var rgChildRec: [SlideProgTagsSubContainerOrAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgChildRec.append(try SlideProgTagsSubContainerOrAtom(dataStream: &dataStream))
        }
        
        self.rgChildRec = rgChildRec

        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
