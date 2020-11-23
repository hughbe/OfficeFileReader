//
//  SlideListTable10Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.2 SlideListTable10Container
/// Referenced by: PP10DocBinaryTagExtension
/// A container record that specifies information about presentation slides contained in the document that also contains this SlideListTable10Container
/// record.
public struct SlideListTable10Container {
    public let rh: RecordHeader
    public let slideListTableSizeAtom: SlideListTableSize10Atom
    public let rgSlideListEntryAtom: [SlideListEntry10Atom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlideListTable10.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideListTable10 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// slideListTableSizeAtom (12 bytes): A SlideListTableSize10Atom record that specifies the number of SlideListEntry10Atom records in the
        /// rgSlideListEntryAtom field.
        self.slideListTableSizeAtom = try SlideListTableSize10Atom(dataStream: &dataStream)
        
        /// rgSlideListEntryAtom (variable): An array of SlideListEntry10Atom records that specifies the creation time of the presentation slides in the
        /// document. The count of items in the array is specified by the slideListTableSizeAtom.count field.
        var rgSlideListEntryAtom: [SlideListEntry10Atom] = []
        rgSlideListEntryAtom.reserveCapacity(Int(self.slideListTableSizeAtom.count))
        for _ in 0..<self.slideListTableSizeAtom.count {
            rgSlideListEntryAtom.append(try SlideListEntry10Atom(dataStream: &dataStream))
        }
        
        self.rgSlideListEntryAtom = rgSlideListEntryAtom
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
