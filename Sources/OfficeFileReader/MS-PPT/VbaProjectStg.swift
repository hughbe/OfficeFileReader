//
//  VbaProjectStg.swift
//
//
//  Created by Hugh Bellamy on 23/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.40 VbaProjectStg
/// A variable type record whose type and meaning are dictated by the value of the record header member rh.recInstance of the contained storage, as
/// specified in the following table.
public enum VbaProjectStg {
    /// 0x000 A VbaProjectStgUncompressedAtom record that specifies uncompressed storage for a VBA project.
    case uncompressed(data: VbaProjectStgUncompressedAtom)
    
    /// 0x001 A VbaProjectStgCompressedAtom record that specifies compressed storage for a VBA project.
    case compressed(data: VbaProjectStgCompressedAtom)
    
    public init(dataStream: inout DataStream) throws {
        let rh = try dataStream.peekRecordHeader()
        guard rh.recType == .externalOleObjectStg else {
            throw OfficeFileError.corrupted
        }
        
        switch rh.recInstance {
        case 0x000:
            self = .uncompressed(data: try VbaProjectStgUncompressedAtom(dataStream: &dataStream))
        case 0x001:
            self = .compressed(data: try VbaProjectStgCompressedAtom(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
