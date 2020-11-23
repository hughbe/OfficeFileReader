//
//  MasterListDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.13 MasterListDiffContainer
/// Referenced by: DocDiff10Container
/// A container record that specifies how to display the changes made by the reviewer to the MasterListWithTextContainer record (section 2.4.14.1).
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this MasterListDiffContainer record.
public struct MasterListDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    public let rgChildRec: [MasterListDiff10ChildContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_MasterListDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .masterListDiff else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        /// rgChildRec (variable): An array of MasterListDiff10ChildContainer records that specifies how to display changes made by the reviewer in
        /// the corresponding reviewer document to the MasterListWithTextContainer record (section 2.4.14.1). The size, in bytes, of the array is
        /// specified by the following formula: rhs.rh.recLen - rhs.rhAtom.recLen - 8
        var rgChildRec: [MasterListDiff10ChildContainer] = []
        while dataStream.position - startPosition < self.rhs.rh.recLen - self.rhs.rhAtom.recLen - 8 {
            rgChildRec.append(try MasterListDiff10ChildContainer(dataStream: &dataStream))
        }

        self.rgChildRec = rgChildRec
    }
}
