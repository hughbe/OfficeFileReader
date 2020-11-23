//
//  RoundTripContentMasterInfo12Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.12 RoundTripContentMasterInfo12Atom
/// Referenced by: RoundTripMainMasterRecord
/// An atom record that specifies a slide layout.
public struct RoundTripContentMasterInfo12Atom {
    public let rh: RecordHeader
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recType MUST be an RT_RoundTripContentMasterInfo12Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripContentMasterInfo12Atom else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// data (variable): An ECMA-376 document that specifies a slide layout. The package contains XML in the PresentationML Content Master
        /// part containing a sldLayout element that conforms to the schema specified by CT_SlideLayout as specified in [ECMA-376] Part 4:
        /// Markup Language Reference, section 4.4.1.36.
        self.data = try dataStream.readBytes(count: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
