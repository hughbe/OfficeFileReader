//
//  SlideViewInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.10 SlideViewInfoAtom
/// Referenced by: NotesViewInfoContainer, SlideViewInfoContainer
/// An atom record that specifies editing preferences for content positioning.
public struct SlideViewInfoAtom {
    public let rh: RecordHeader
    public let unused: UInt8
    public let fSnapToGrid: bool1
    public let fSnapToShape: bool1
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlideViewInfoAtom.
        /// rh.recLen MUST be 0x00000003.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideViewInfoAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000003 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// unused (1 byte): Undefined and MUST be ignored.
        self.unused = try dataStream.read()
        
        /// fSnapToGrid (1 byte): A bool1 (section 2.2.2) that specifies an editing preference that the position of a shape aligns to the grid specified by
        /// the GridSpacing10Atom record.
        self.fSnapToGrid = try bool1(dataStream: &dataStream)
        
        /// fSnapToShape (1 byte): A bool1 that specifies an editing preference that the position of a shape aligns to the position of other shapes.
        self.fSnapToShape = try bool1(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
