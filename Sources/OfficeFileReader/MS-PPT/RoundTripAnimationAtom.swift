//
//  RoundTripAnimationAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.7 RoundTripAnimationAtom
/// Referenced by: RoundTripMainMasterRecord, RoundTripSlideRecord
/// An atom record that specifies animations for a slide.
public struct RoundTripAnimationAtom {
    public let rh: RecordHeader
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripAnimationAtom12Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripAnimationAtom12Atom else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        
        /// data (variable): An ECMA-376 document that specifies animations, along with embedded sounds if present. The package contains XML in the
        /// PresentationML Timing Info part containing a <timing> element that conforms to the schema specified by CT_SlideTiming as specified in
        /// [ECMA-376] Part 4: Markup Language Reference, section 4.4.1.44.
        self.data = try dataStream.readBytes(count: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
