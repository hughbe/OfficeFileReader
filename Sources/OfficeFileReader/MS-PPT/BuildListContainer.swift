//
//  BuildListContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.4 BuildListContainer
/// Referenced by: PP10SlideBinaryTagExtension
/// A container record that specifies all animation builds for a slide.
public struct BuildListContainer {
    public let rh: RecordHeader
    public let rgChildRec: [BuildListSubContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_BuildList.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .buildList else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// rgChildRec (variable): An array of BuildListSubContainer records that specifies all builds for a slide. Each item specifies build information for
        /// a shape.
        var rgChildRec: [BuildListSubContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgChildRec.append(try BuildListSubContainer(dataStream: &dataStream))
        }
        
        self.rgChildRec = rgChildRec
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
