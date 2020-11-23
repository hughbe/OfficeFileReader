//
//  SlideDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.16 SlideDiffContainer
/// Referenced by: MasterListDiff10ChildContainer, SlideListDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to a title masterslide or to a presentation slide.
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this SlideDiffContainer record.
/// When this SlideDiffContainer record is contained within a MasterListDiffContainer record, the ith SlideDiffContainer record in its parent
/// MasterListDiffContainer record specifies how to display changes made to the SlideContainer record (section 2.5.1) in the corresponding reviewer
/// document that is referenced by the ith MasterPersistAtom record (section 2.4.14.2) in its parent MasterListWithTextContainer record (section 2.4.14.1)
/// in the corresponding reviewer document.
/// Let the corresponding slide be the SlideContainer record (section 2.5.1) so specified.
/// When this SlideDiffContainer record is contained within a SlideListDiffContainer, the ith SlideDiffContainer record in its parent SlideListDiffContainer
/// record specifies how to display changes made to the SlideContainer record in the corresponding reviewer document that is specified by the ith
/// SlidePersistAtom record (section 2.4.14.5) in its parent SlideListWithTextContainer record (section 2.4.14.3) in the corresponding reviewer document.
/// Let the corresponding slide be the SlideContainer record so specified.
public struct SlideDiffContainer {
    public let rhs: DiffRecordHeaders
    public let scheme: Bool
    public let background: Bool
    public let reserved1: UInt8
    public let addSlide: Bool
    public let deleteSlide: Bool
    public let layout: Bool
    public let slideShow: Bool
    public let headerFooter: Bool
    public let reserved2: Bool
    public let master: Bool
    public let position: Bool
    public let timeNode: Bool
    public let reserved3: UInt32
    public let shapeListDiff: ShapeListDiffContainer?
    public let tableListDiff: TableListDiffContainer?
    public let slideShowDiff: SlideShowDiffContainer?
    public let hfDiff: HeaderFooterDiffContainer?
    public let notesDiff: NotesDiffContainer?
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_SlideDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .slideDiff else {
            throw OfficeFileError.corrupted
        }
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - scheme (1 bit): A bit that specifies whether the change made by the reviewer to the slideFlags.fMasterScheme field of the SlideAtom
        /// record contained within the corresponding slide is not displayed.
        self.scheme = flags.readBit()
        
        /// B - background (1 bit): A bit that specifies whether the change made by the reviewer to the slideFlags.fMasterBackground field of the
        /// SlideAtom record contained within the corresponding slide is not displayed.
        self.background = flags.readBit()
        
        /// C - reserved1 (2 bits): MUST be zero and MUST be ignored.
        self.reserved1 = UInt8(flags.readBits(count: 2))
        
        /// D - addSlide (1 bit): A bit that specifies whether the addition of the corresponding slide made by the reviewer in the corresponding reviewer
        /// document is not displayed.
        self.addSlide = flags.readBit()
        
        /// E - deleteSlide (1 bit): A bit that specifies whether the deletion of the corresponding slide made by the reviewer in the corresponding reviewer
        /// document is not displayed.
        self.deleteSlide = flags.readBit()
        
        /// F - layout (1 bit): A bit that specifies whether the change made by the reviewer to the geom field of the SlideAtom record contained within the
        /// corresponding slide is not displayed.
        self.layout = flags.readBit()
        
        /// G - slideShow (1 bit): A bit that specifies whether the changes made by the reviewer to the SlideShowSlideInfoAtom record contained within
        /// the corresponding slide are not displayed.
        self.slideShow = flags.readBit()
        
        /// H - headerFooter (1 bit): A bit that specifies whether the changes made by the reviewer in the corresponding reviewer document to the
        /// PerSlideHeadersFootersContainer record in the corresponding slide are not displayed.
        self.headerFooter = flags.readBit()
        
        /// I - reserved2 (1 bit): MUST be zero and MUST be ignored.
        self.reserved2 = flags.readBit()
        
        /// J - master (1 bit): A bit that specifies whether the change made by the reviewer to the masterIdRef field of the SlideAtom record contained
        /// within the corresponding slide is not displayed.
        self.master = flags.readBit()
        
        /// K - position (1 bit): A bit that specifies whether the change made by the reviewer to the position of the corresponding slide in the
        /// SlideListWithTextContainer record (section 2.4.14.3) in the corresponding reviewer document is not displayed.
        self.position = flags.readBit()
        
        /// L - timeNode (1 bit): A bit that specifies whether the change made by the reviewer to the ExtTimeNodeContainer record (section 2.8.15)
        /// contained within the corresponding slide is not displayed.
        self.timeNode = flags.readBit()
        
        /// reserved3 (19 bits): MUST be zero and MUST be ignored.
        self.reserved3 = flags.readRemainingBits()
        
        /// shapeListDiff (variable): An optional ShapeListDiffContainer record that specifies how to display the changes made by the reviewer to the
        /// shapes contained within the corresponding slide.
        self.shapeListDiff = try ShapeListDiffContainer(dataStream: &dataStream)
        
        /// tableListDiff (variable): An optional TableListDiffContainer record that specifies how to display the changes made by the reviewer to the table
        /// objects contained within the corresponding slide.
        self.tableListDiff = try TableListDiffContainer(dataStream: &dataStream)
        
        /// slideShowDiff (32 bytes): An optional SlideShowDiffContainer record that specifies how to display the changes made by the reviewer to the
        /// SlideShowSlideInfoAtom record contained within the corresponding slide.
        self.slideShowDiff = try SlideShowDiffContainer(dataStream: &dataStream)
        
        /// hfDiff (32 bytes): An optional HeaderFooterDiffContainer record that specifies how to display the changes made by the reviewer to the
        /// PerSlideHeadersFootersContainer record contained within the corresponding slide.
        self.hfDiff = try HeaderFooterDiffContainer(dataStream: &dataStream)
        
        /// notesDiff (32 bytes): An optional NotesDiffContainer record that specifies how to display the changes made by the reviewer to the notes
        /// slide for the corresponding slide.
        self.notesDiff = try NotesDiffContainer(dataStream: &dataStream)
    }
}
