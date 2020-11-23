//
//  HeaderFooterDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.9 HeaderFooterDiffContainer
/// Referenced by: DocDiff10Container, SlideDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to the SlideHeadersFootersContainer (section 2.4.15.1),
/// NotesHeadersFootersContainer (section 2.4.15.6), or PerSlideHeadersFootersContainer record.
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this HeaderFooterDiffContainer record.
/// Let the corresponding slide be as specified in the SlideDiffContainer record that contains this HeaderFooterDiffContainer record.
public struct HeaderFooterDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex The value 0x00 specifies display information for the changes made in the corresponding reviewer document to the
        /// NotesHeadersFootersContainer record (section 2.4.15.6).
        /// The value 0x01 specifies display information for the changes made in the corresponding reviewer document to the
        /// SlideHeadersFootersContainer record or to the PerSlideHeadersFootersContainer record in the corresponding slide.
        /// rhs.gmiTag MUST be Diff_HeaderFooterDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard self.rhs.gmiTag == .headerFooterDiff else {
            throw OfficeFileError.corrupted
        }
        
        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
