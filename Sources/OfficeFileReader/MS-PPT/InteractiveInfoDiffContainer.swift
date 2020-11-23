//
//  InteractiveInfoDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.22 InteractiveInfoDiffContainer
/// Referenced by: ShapeDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to the MouseClickInteractiveInfoContainer or
/// MouseOverInteractiveInfoContainer record contained within the corresponding shape.
/// Let the corresponding shape be as specified in the ShapeDiffContainer record that contains this InteractiveInfoDiffContainer record.
public struct InteractiveInfoDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex The value 0x00 specifies display information for the changes to the MouseOverInteractiveInfoContainer record contained within
        /// the corresponding shape.
        /// The value 0x01 specifies display information for the changes to the MouseClickInteractiveInfoContainer record contained within the
        /// corresponding shape.
        /// rhs.gmiTag MUST be Diff_InteractiveInfoDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .interactiveInfoDiff else {
            throw OfficeFileError.corrupted
        }
        
        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
