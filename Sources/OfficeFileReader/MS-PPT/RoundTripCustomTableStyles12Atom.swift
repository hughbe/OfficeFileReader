//
//  RoundTripCustomTableStyles12Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.13 RoundTripCustomTableStyles12Atom
/// Referenced by: DocumentContainer
/// An atom record that specifies table styles.
public struct RoundTripCustomTableStyles12Atom {
    public let rh: RecordHeader
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer SHOULD<110> be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripCustomTableStyles12Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripCustomTableStyles12Atom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// data (variable): An ECMA-376 document that specifies table styles. The package contains XML in the PresentationML Table Styles part
        /// containing a tblStyle element that conforms to the schema specified by CT_TableStyleList as specified in [ECMA-376] Part 4: Markup
        /// Language Reference, section 5.1.4.2.27.
        self.data = try dataStream.readBytes(count: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
