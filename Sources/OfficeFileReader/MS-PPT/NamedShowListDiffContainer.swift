//
//  NamedShowListDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.10 NamedShowListDiffContainer
/// Referenced by: DocDiff10Container
/// A container record that specifies how to display the changes made by the reviewer to the NamedShowsContainer record (section 2.6.2).
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this NamedShowListDiffContainer record.
public struct NamedShowListDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    public let rgNamedShowDiff: [NamedShowDiffContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_NamedShowListDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .namedShowListDiff else {
            throw OfficeFileError.corrupted
        }
        
        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// rgNamedShowDiff (variable): An array of NamedShowDiffContainer records that specifies how to display changes made by the reviewer
        /// in the corresponding reviewer document to the named shows. The size, in bytes, of the array is specified by the following formula:
        /// rhs.rh.recLen - rhs.rhAtom.recLen - 8
        var rgNamedShowDiff: [NamedShowDiffContainer] = []
        while dataStream.position - startPosition < self.rhs.rh.recLen - self.rhs.rhAtom.recLen - 8 {
            rgNamedShowDiff.append(try NamedShowDiffContainer(dataStream: &dataStream))
        }
        
        self.rgNamedShowDiff = rgNamedShowDiff
    }
}
