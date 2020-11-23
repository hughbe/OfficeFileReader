//
//  DocProgBinaryTagContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.23.3 DocProgBinaryTagContainer
/// Referenced by: DocProgTagsSubContainerOrAtom
/// A container record that specifies programmable tags with additional binary document data.
public struct DocProgBinaryTagContainer {
    public let rh: RecordHeader
    public let rec: DocProgBinaryTagSubContainerOrAtom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_ProgBinaryTag.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .progBinaryTag else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rec (variable): A DocProgBinaryTagSubContainerOrAtom record that specifies additional document data.
        self.rec = try DocProgBinaryTagSubContainerOrAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
