//
//  NamedShowSlidesAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.6.5 NamedShowSlidesAtom
/// Referenced by: NamedShowContainer
/// An atom record that specifies the slide identifiers of presentation slides in a named show.
public struct NamedShowSlidesAtom {
    public let rh: RecordHeader
    public let rgSlideIdRef: [SlideIdRef]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_NamedShowSlidesAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .namedShowSlidesAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// rgSlideIdRef (variable): An array of SlideIdRef (section 2.2.25) that specifies the slides that are in this named show. The order of the
        /// slides in this array is also the order for the slides in the named show. Any slides referenced here that do not exist in the presentation
        /// itself MUST be ignored.
        var rgSlideIdRef: [SlideIdRef] = []
        let count = self.rh.recLen / 4
        rgSlideIdRef.reserveCapacity(Int(count))
        for _ in 0..<count {
            rgSlideIdRef.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.rgSlideIdRef = rgSlideIdRef
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
