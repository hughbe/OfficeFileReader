//
//  RecolorInfoDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.20 RecolorInfoDiffContainer
/// Referenced by: ShapeDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to the RecolorInfoAtom record contained within the corresponding shape.
/// Let the corresponding shape be as specified in the ShapeDiffContainer record that contains this RecolorDiffContainer record.
public struct RecolorInfoDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_RecolorInfoDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .recolorInfoDiff else {
            throw OfficeFileError.corrupted
        }
        
        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
