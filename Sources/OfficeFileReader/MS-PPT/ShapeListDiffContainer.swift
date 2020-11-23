//
//  ShapeListDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.17 ShapeListDiffContainer
/// Referenced by: MainMasterDiffContainer, SlideDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to shapes.
/// Let the corresponding slide or corresponding main master slide be as specified in the SlideDiffContainer or MainMasterDiffContainer record that
/// contains this ShapeListDiffContainerrecord.
public struct ShapeListDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    public let rgShapeDiff: [ShapeDiffContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_ShapeListDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .shapeListDiff else {
            throw OfficeFileError.corrupted
        }
        
        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// rgShapeDiff (variable): An array of ShapeDiffContainer records that specifies how to display changes made by the reviewer to the shapes
        /// contained within the corresponding slide or corresponding main master slide. The size, in bytes, of the array is specified by the following
        /// formula: rhs.rh.recLen - rhs.rhAtom.recLen - 8
        var rgShapeDiff: [ShapeDiffContainer] = []
        while dataStream.position - startPosition < self.rhs.rh.recLen - self.rhs.rhAtom.recLen - 8 {
            rgShapeDiff.append(try ShapeDiffContainer(dataStream: &dataStream))
        }

        self.rgShapeDiff = rgShapeDiff
    }
}
