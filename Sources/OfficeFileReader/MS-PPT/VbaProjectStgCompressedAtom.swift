//
//  VbaProjectStgCompressedAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.42 VbaProjectStgCompressedAtom
/// Referenced by: VbaProjectStg
/// An atom record that specifies information about the compressed structured storage (described in [MSDN-COM]) for a VBA project.
public struct VbaProjectStgCompressedAtom {
    public let rh: RecordHeader
    public let decompressedSize: UInt32
    public let pptVbaProjStgCompressed: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be an RT_ExternalOleObjectStg.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .externalOleObjectStg else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position
        
        /// decompressedSize (4 bytes): An unsigned integer that specifies the length of the storage after decompression.
        self.decompressedSize = try dataStream.read(endianess: .littleEndian)

        /// pptVbaProjStgCompressed (variable): An array of bytes that specifies a compressed structured storage (described in [MSDN-COM]) for
        /// the VBA project as specified in [MS-OVBA] section 2.2.1. The original bytes of the storage are compressed by the algorithm specified
        /// in [RFC1950] and are decompressed by the algorithm specified in [RFC1951]. The length, in bytes, of the field is specified by the
        /// following formula: rh.recLen - 4
        self.pptVbaProjStgCompressed = try dataStream.readBytes(count: Int(self.rh.recLen) - 4)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
