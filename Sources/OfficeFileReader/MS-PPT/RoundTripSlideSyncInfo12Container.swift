//
//  RoundTripSlideSyncInfo12Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.23 RoundTripSlideSyncInfo12Container
/// Referenced by: RoundTripSlideRecord, SlideContainer
/// A container record that specifies information about a slide that synchronizes to a slide in a slide library. Slide synchronization data is fully specified in
/// [ECMA-376] Part 4: Markup Language Reference, section 4.7.
public struct RoundTripSlideSyncInfo12Container {
    public let rh: RecordHeader
    public let serverId: ServerIdAtom
    public let slideLibUrl: SlideLibUrlAtom
    public let slideSyncInfoAtom12: SlideSyncInfoAtom12
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripSlideSyncInfo12.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripSlideSyncInfo12 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// serverId (variable): A ServerIdAtom record that specifies a unique identifier for a slide in a slide library.
        self.serverId = try ServerIdAtom(dataStream: &dataStream)
        
        /// slideLibUrl (variable): A SlideLibUrlAtom record that specifies the URL of a slide library.
        self.slideLibUrl = try SlideLibUrlAtom(dataStream: &dataStream)
        
        /// slideSyncInfoAtom12 (40 bytes): A SlideSyncInfoAtom12 record that specifies timestamps for slides that synchronize with versions stored
        /// in a slide library.
        self.slideSyncInfoAtom12 = try SlideSyncInfoAtom12(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
