//
//  MainMasterDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.15 MainMasterDiffContainer
/// Referenced by: MasterListDiff10ChildContainer
/// A container record that specifies how to display the changes made by the reviewer to a main master slide.
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this MainMasterDiffContainer record.
/// The ith MainMasterDiffContainer record in its parent MasterListDiffContainer record specifies how to display changes made to the MainMasterContainer
/// record in the corresponding reviewer document that is referenced by the ith MasterPersistAtom record (section 2.4.14.2) in its parent
/// MasterListWithTextContainer record (section 2.4.14.1) in the corresponding reviewer document.
/// Let the corresponding main master slide be the MainMasterContainer record so specified.
public struct MainMasterDiffContainer {
    public let rhs: DiffRecordHeaders
    public let scheme: Bool
    public let background: Bool
    public let reserved1: UInt16
    public let timeNode: Bool
    public let addMainMaster: Bool
    public let deleteMainMaster: Bool
    public let locked: Bool
    public let reserved2: UInt16
    public let shapeListDiff: ShapeListDiffContainer?
    public let tableListDiff: TableListDiffContainer?
    public let notesDiff: NotesDiffContainer?
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_MainMasterDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .mainMasterDiff else {
            throw OfficeFileError.corrupted
        }
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - scheme (1 bit): A bit that specifies whether the change made by the reviewer to the slideFlags.fMasterScheme field of the SlideAtom
        /// record contained within the corresponding main master slide is not displayed.
        self.scheme = flags.readBit()
        
        /// B - background (1 bit): A bit that specifies whether the change made by the reviewer to the slideFlags.fMasterBackground field of the
        /// SlideAtom record contained within the corresponding main master slide is not displayed.
        self.background = flags.readBit()
        
        /// reserved1 (10 bits): MUST be zero and MUST be ignored.
        self.reserved1 = UInt16(flags.readBits(count: 10))
        
        /// C - timeNode (1 bit): A bit that specifies whether the change made by the reviewer to the ExtTimeNodeContainer record (section 2.8.15)
        /// contained within the corresponding main master slide is not displayed.
        self.timeNode = flags.readBit()
        
        /// D - addMainMaster (1 bit): A bit that specifies whether the addition of the corresponding main master slide made by the reviewer in the
        /// corresponding reviewer document is not displayed.
        self.addMainMaster = flags.readBit()
        
        /// E - deleteMainMaster (1 bit): A bit that specifies whether the deletion of the corresponding main master slide made by the reviewer in the
        /// corresponding reviewer document is not displayed.
        self.deleteMainMaster = flags.readBit()
        
        /// F - locked (1 bit): A bit that specifies whether the change made by the reviewer to the slideFlagsAtom.fPreserveMaster field of the
        /// PP10SlideBinaryTagExtension record contained within the corresponding main master slide is not displayed.
        self.locked = flags.readBit()
        
        /// reserved2 (16 bits): MUST be zero and MUST be ignored.
        self.reserved2 = UInt16(flags.readRemainingBits())
        
        /// shapeListDiff (variable): An optional ShapeListDiffContainer record that specifies how to display the changes made by the reviewer to the
        /// shapes contained within the corresponding main master slide.
        self.shapeListDiff = try ShapeListDiffContainer(dataStream: &dataStream)
        
        /// tableListDiff (variable): An optional TableListDiffContainer record that specifies how to display the changes made by the reviewer to the table
        /// objects contained within the corresponding main master slide.
        self.tableListDiff = try TableListDiffContainer(dataStream: &dataStream)
        
        /// notesDiff (32 bytes): An optional NotesDiffContainer record that specifies how to display the changes made by the reviewer in the
        /// corresponding reviewer document to the notes master slide.
        self.notesDiff = try NotesDiffContainer(dataStream: &dataStream)
    }
}
