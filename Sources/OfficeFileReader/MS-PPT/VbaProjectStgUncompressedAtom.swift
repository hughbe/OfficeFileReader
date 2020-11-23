//
//  VbaProjectStgUncompressedAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.41 VbaProjectStgUncompressedAtom
/// Referenced by: VbaProjectStg
/// An atom record that specifies information about the uncompressed structured storage (described in [MSDN-COM]) for a VBA project.
public struct VbaProjectStgUncompressedAtom {
    public let rh: RecordHeader
    public let pptVbaProjStgUncompressed: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalOleObjectStg.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .externalOleObjectStg else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// pptVbaProjStgUncompressed (variable): An array of bytes that specifies a structured storage (described in [MSDN-COM]) for the VBA
        /// project ([MS-OVBA] section 2.2.1). The length, in bytes, of the field is specified by rh.recLen.
        self.pptVbaProjStgUncompressed = try dataStream.readBytes(count: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

