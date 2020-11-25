//
//  VBAInfoContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.10 VBAInfoContainer
/// Referenced by: DocInfoListSubContainerOrAtom
/// A container record that specifies VBA information for the document
public struct VBAInfoContainer {
    public let rh: RecordHeader
    public let vbaInfoAtom: VBAInfoAtom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be RT_VbaInfo (section 2.13.24).
        /// rh.recLen MUST be 0x00000014.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .vbaInfo else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000014 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// vbaInfoAtom (20 bytes): A VBAInfoAtom record that specifies VBA information for this document.
        self.vbaInfoAtom = try VBAInfoAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
