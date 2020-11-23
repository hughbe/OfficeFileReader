//
//  SlideShowDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.25 SlideShowDiffContainer
/// Referenced by: SlideDiffContainer
/// A container record that specifies how to display changes made by the reviewer to the SlideShowSlideInfoAtom record contained within the
/// corresponding slide.
/// Let the corresponding slide be as specified in the SlideDiffContainer record that contains this SlideShowDiffContainer record.
public struct SlideShowDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_SlideShowDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .slideShowDiff else {
            throw OfficeFileError.corrupted
        }

        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
