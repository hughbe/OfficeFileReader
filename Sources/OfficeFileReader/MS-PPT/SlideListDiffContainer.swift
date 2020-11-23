//
//  SlideListDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.12 SlideListDiffContainer
/// Referenced by: DocDiff10Container
/// A container record that specifies how to display the changes made by the reviewer to the SlideListWithTextContainer record (section 2.4.14.3).
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this SlideListDiffContainer record.
public struct SlideListDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    public let rgSlideDiff: [SlideDiffContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_SlideListDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .slideListDiff else {
            throw OfficeFileError.corrupted
        }
        
        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// rgSlideDiff (variable): An array of SlideDiffContainer records that specifies how to display changes made by the reviewer in the corresponding
        /// reviewer document to the SlideListWithTextContainer record (section 2.4.14.3). The size, in bytes, of the array is specified by the following
        /// formula: rhs.rh.recLen - rhs.rhAtom.recLen - 8
        var rgSlideDiff: [SlideDiffContainer] = []
        while dataStream.position - startPosition < self.rhs.rh.recLen - self.rhs.rhAtom.recLen - 8 {
            rgSlideDiff.append(try SlideDiffContainer(dataStream: &dataStream))
        }

        self.rgSlideDiff = rgSlideDiff
    }
}
