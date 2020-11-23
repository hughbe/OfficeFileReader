//
//  DiffRecordHeaders.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.7 DiffRecordHeaders
/// Referenced by: DocDiff10Container, ExternalObjectDiffContainer, HeaderFooterDiffContainer, InteractiveInfoDiffContainer, MainMasterDiffContainer,
/// MasterListDiffContainer, NamedShowDiffContainer, NamedShowListDiffContainer, NotesDiffContainer, RecolorInfoDiffContainer, ShapeDiffContainer,
/// ShapeListDiffContainer, SlideDiffContainer, SlideListDiffContainer, SlideShowDiffContainer, TableDiffContainer, TableListDiffContainer, TextDiffContainer
/// A structure at the beginning of each container record, when that container record is used to specify how to display the changes to a document made
/// by a reviewer.
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this DiffRecordHeaders record.
public struct DiffRecordHeaders {
    public let rh: RecordHeader
    public let rhAtom: RecordHeader
    public let fIndex: bool1
    public let unused1: UInt8
    public let unused2: UInt8
    public let unused3: UInt8
    public let gmiTag: DiffTypeEnum
    public let unused4: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for the container record. Sub-fields are further specified in
        /// the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_Diff10.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .diff10 else {
            throw OfficeFileError.corrupted
        }
        
        /// rhAtom (8 bytes): A RecordHeader structure (section 2.3.1) that specifies a header for the atom record that specifies how the changes made
        /// by the reviewer are displayed. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rhAtom.recVer MUST be 0x0.
        /// rhAtom.recInstance MUST be 0x000.
        /// rhAtom.recType MUST be RT_Diff10Atom.
        /// rhAtom.recLen MUST be 0x0000000C.
        self.rhAtom = try RecordHeader(dataStream: &dataStream)
        guard self.rhAtom.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rhAtom.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rhAtom.recType == .diff10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rhAtom.recLen == 0x0000000C else {
            throw OfficeFileError.corrupted
        }
        
        /// fIndex (1 byte): A bool1 (section 2.2.2) that specifies instance data. Interpretation of the value is dependent on gmiTag.
        self.fIndex = try bool1(dataStream: &dataStream)
        
        /// unused1 (1 byte): Undefined and MUST be ignored.
        self.unused1 = try dataStream.read()
        
        /// unused2 (1 byte): Undefined and MUST be ignored.
        self.unused2 = try dataStream.read()
        
        /// unused3 (1 byte): Undefined and MUST be ignored.
        self.unused3 = try dataStream.read()
        
        /// gmiTag (4 bytes): A DiffTypeEnum enumeration that identifies the type of changes made by the reviewer.
        guard let gmiTag = DiffTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.gmiTag = gmiTag
        
        /// unused4 (4 bytes): Undefined and MUST be ignored.
        self.unused4 = try dataStream.read(endianess: .littleEndian)
    }
}
