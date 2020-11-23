//
//  TableDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.24 TableDiffContainer
/// Referenced by: TableListDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to a table object.
/// Let the corresponding slide or corresponding main master slide be as specified in the TableListDiffContainer record that contains this TableDiffContainer
/// record.
/// The ith TableDiffContainer record in its parent TableListDiffContainer record specifies how to display changes made to the ith corresponding table
/// object contained within the corresponding slide or corresponding main master slide.
/// Let the corresponding table object be specified by the OfficeArtSpContainer record ([MS-ODRAW] section 2.2.14) such that the tableProperties.fIsTable
/// field of the tableProperties property ([MSODRAW] section 2.3.4.36) MUST be TRUE.
public struct TableDiffContainer {
    public let rhs: DiffRecordHeaders
    public let addTable: Bool
    public let deleteTable: Bool
    public let modifiedTable: Bool
    public let position: Bool
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_TableDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .tableDiff else {
            throw OfficeFileError.corrupted
        }

        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - addTable (1 bit): A bit that specifies whether the addition of the corresponding table object made by the reviewer in the corresponding
        /// slide or corresponding main master slide is not displayed.
        self.addTable = flags.readBit()
        
        /// B - deleteTable (1 bit): A bit that specifies whether the deletion of the corresponding table object made by the reviewer in the corresponding
        /// slide or corresponding main master slide is not displayed.
        self.deleteTable = flags.readBit()
        
        /// C - modifiedTable (1 bit): A bit that specifies whether the changes made by the reviewer to the corresponding table object are not displayed.
        self.modifiedTable = flags.readBit()
        
        /// D - position (1 bit): A bit that specifies whether the change made by the reviewer to the z-order of the corresponding table object is not
        /// displayed.
        self.position = flags.readBit()
        
        /// reserved (28 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
    }
}
