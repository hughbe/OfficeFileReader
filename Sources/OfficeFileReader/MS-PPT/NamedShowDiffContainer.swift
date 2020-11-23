//
//  NamedShowDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT]2.4.20.11 NamedShowDiffContainer
/// Referenced by: NamedShowListDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to a NamedShowContainer record.
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this NamedShowDiffContainer record.
/// The ith NamedShowDiffContainer record in its parent NamedShowListDiffContainer record specifies how to display changes made to the ith
/// NamedShowContainer record in its parent NamedShowsContainer record (section 2.6.2) in the corresponding reviewer document.
public struct NamedShowDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_NamedShowDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .namedShowDiff else {
            throw OfficeFileError.corrupted
        }
        
        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
