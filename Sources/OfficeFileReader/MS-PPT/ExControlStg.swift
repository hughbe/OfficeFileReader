//
//  ExControlStg.swift
//
//
//  Created by Hugh Bellamy on 23/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.37 ExControlStg
/// A variable type record whose type and meaning are specified by the value of the record header member rh.recInstance of the contained storage, as
/// specified in the following table.
public enum ExControlStg {
    /// 0x000 An ExControlStgUncompressedAtom record that specifies an uncompressed storage for an ActiveX control.
    case uncompressed(data: ExControlStgUncompressedAtom)
    
    /// 0x001 An ExControlStgCompressedAtom record that specifies a compressed storage for an ActiveX control.
    case compressed(data: ExControlStgCompressedAtom)
    
    public init(dataStream: inout DataStream) throws {
        let rh = try dataStream.peekRecordHeader()
        guard rh.recType == .externalOleObjectStg else {
            throw OfficeFileError.corrupted
        }
        
        switch rh.recInstance {
        case 0x000:
            self = .uncompressed(data: try ExControlStgUncompressedAtom(dataStream: &dataStream))
        case 0x001:
            self = .compressed(data: try ExControlStgCompressedAtom(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
