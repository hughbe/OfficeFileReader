//
//  ShapeProgTagsContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.14 ShapeProgTagsContainer
/// Referenced by: ShapeClientRoundtripDataSubContainerOrAtom
/// A container record that specifies programmable tags with additional shape data.
public struct ShapeProgTagsContainer {
    public let rh: RecordHeader
    public let rgChildRec: [ShapeProgTagsSubContainerOrAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance SHOULD<99> be 0x000.
        /// rh.recType MUST be RT_ProgTags (section 2.13.24).
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .progTags else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgChildRec (variable): An array of ShapeProgTagsSubContainerOrAtom records that specifies the programmable tags. The size, in bytes, of the
        /// array is specified by rh.recLen. The array MUST NOT contain more than one of each of the following records: PP9ShapeBinaryTagExtension,
        /// PP10ShapeBinaryTagExtension, or PP11ShapeBinaryTagExtension.
        var rgChildRec: [ShapeProgTagsSubContainerOrAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgChildRec.append(try ShapeProgTagsSubContainerOrAtom(dataStream: &dataStream))
        }
        
        self.rgChildRec = rgChildRec
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
