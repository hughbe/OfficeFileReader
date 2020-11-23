//
//  DocDiff10Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.8 DocDiff10Container
/// Referenced by: DiffTree10Container
/// A container record that specifies how to display document-level changes made by the reviewer.
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this DocDiff10Container record.
public struct DocDiff10Container {
    public let rhs: DiffRecordHeaders
    public let reserved1: UInt8
    public let slideSize: Bool
    public let omitTitlePlace: Bool
    public let namedShowList: Bool
    public let slideHeaderFooter: Bool
    public let notesHeaderFooter: Bool
    public let reserved2: UInt32
    public let slideHFDiff: HeaderFooterDiffContainer
    public let notesHFDiff: HeaderFooterDiffContainer
    public let namedShowListDiff: NamedShowListDiffContainer
    public let masterListDiff: MasterListDiffContainer
    public let slideListDiff: SlideListDiffContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_DocDiff
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .docDiff else {
            throw OfficeFileError.corrupted
        }
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - reserved1 (2 bits): MUST be zero and MUST be ignored.
        self.reserved1 = UInt8(flags.readBits(count: 2))
        
        /// B - slideSize (1 bit): A bit that specifies whether the change made by the reviewer in the corresponding reviewer document to the slideSize
        /// field of the DocumentAtom record (section 2.4.2) is not displayed.
        self.slideSize = flags.readBit()
        
        /// C - omitTitlePlace (1 bit): A bit that specifies whether the change made by the reviewer in the corresponding reviewer document to the
        /// fOmitTitlePlace field of the DocumentAtom record is not displayed.
        self.omitTitlePlace = flags.readBit()
        
        /// D - namedShowList (1 bit): A bit that specifies whether the changes made by the reviewer in the corresponding reviewer document to any
        /// NamedShowContainer record in the NamedShowsContainer record (section 2.6.2) are not displayed.
        self.namedShowList = flags.readBit()
        
        /// E - slideHeaderFooter (1 bit): A bit that specifies whether the changes made by the reviewer in the corresponding reviewer document to
        /// the SlideHeadersFootersContainer record (section 2.4.15.1) are not displayed.
        self.slideHeaderFooter = flags.readBit()
        
        /// F - notesHeaderFooter (1 bit): A bit that specifies whether the changes made by the reviewer in the corresponding reviewer document to
        /// the NotesHeadersFootersContainer record (section 2.4.15.6) are not displayed.
        self.notesHeaderFooter = flags.readBit()
        
        /// reserved2 (25 bits): MUST be zero and MUST be ignored.
        self.reserved2 = flags.readRemainingBits()
        
        /// slideHFDiff (32 bytes): An optional HeaderFooterDiffContainer record that specifies how to display the changes made by the reviewer in
        /// the corresponding reviewer document to the SlideHeadersFootersContainer record.
        self.slideHFDiff = try HeaderFooterDiffContainer(dataStream: &dataStream)
        
        /// notesHFDiff (32 bytes): An optional HeaderFooterDiffContainer record that specifies how to display the changes made by the reviewer in
        /// the corresponding reviewer document to the NotesHeadersFootersContainer record.
        self.notesHFDiff = try HeaderFooterDiffContainer(dataStream: &dataStream)
        
        /// namedShowListDiff (variable): An optional NamedShowListDiffContainer record that specifies how to display the changes made by the
        /// reviewer in the corresponding reviewer document to each NamedShowContainer record in the NamedShowsContainer record.
        self.namedShowListDiff = try NamedShowListDiffContainer(dataStream: &dataStream)
        
        /// masterListDiff (variable): An optional MasterListDiffContainer record that specifies how to display the changes made by the reviewer in the
        /// corresponding reviewer document to each MasterPersistAtom record (section 2.4.14.2) in the MasterListWithTextContainer record
        /// (section 2.4.14.1).
        self.masterListDiff = try MasterListDiffContainer(dataStream: &dataStream)
        
        /// slideListDiff (variable): An optional SlideListDiffContainer record that contains records that specify how to display the changes made by the
        /// reviewer in the corresponding reviewer document to each SlidePersistAtom record (section 2.4.14.5) in the SlideListWithTextContainer
        /// record (section 2.4.14.3).
        self.slideListDiff = try SlideListDiffContainer(dataStream: &dataStream)
    }
}
