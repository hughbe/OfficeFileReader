//
//  TableListDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.23 TableListDiffContainer
/// Referenced by: MainMasterDiffContainer, SlideDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to table objects.
/// Let the corresponding slide or corresponding main master slide be as specified in the SlideDiffContainer or MainMasterDiffContainer record that
/// contains this TableListDiffContainer record.
public struct TableListDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    public let rgTableDiff: [TableDiffContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_TableListDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .tableListDiff else {
            throw OfficeFileError.corrupted
        }
        
        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// rgTableDiff (variable): An array of TableDiffContainer records that specifies how to display changes made by the reviewer to the table objects
        /// in the corresponding slide or corresponding main master slide. The size, in bytes, of the array is specified by the following formula:
        /// rhs.rh.recLen -rhs.rhAtom.recLen - 8
        var rgTableDiff: [TableDiffContainer] = []
        while dataStream.position - startPosition < self.rhs.rh.recLen - self.rhs.rhAtom.recLen - 8 {
            rgTableDiff.append(try TableDiffContainer(dataStream: &dataStream))
        }

        self.rgTableDiff = rgTableDiff
    }
}
