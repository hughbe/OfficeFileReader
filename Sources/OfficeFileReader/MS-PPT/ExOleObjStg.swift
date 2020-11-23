//
//  ExOleObjStg.swift
//  
//
//  Created by Hugh Bellamy on 23/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.34 ExOleObjStg
/// A variable type record whose type and meaning are specified by the value of the rh.recInstance field of the contained storage, as specified in the
/// following table.
public enum ExOleObjStg {
    /// 0x000 An ExOleObjStgUncompressedAtom record that specifies an uncompressed OLE object.
    case uncompressed(data: ExOleObjStgUncompressedAtom)
    
    /// 0x001 An ExOleObjStgCompressedAtom record that specifies a compressed OLE object.
    case compressed(data: ExOleObjStgCompressedAtom)
    
    public init(dataStream: inout DataStream) throws {
        let rh = try dataStream.peekRecordHeader()
        guard rh.recType == .externalOleObjectStg else {
            throw OfficeFileError.corrupted
        }
        
        switch rh.recInstance {
        case 0x000:
            self = .uncompressed(data: try ExOleObjStgUncompressedAtom(dataStream: &dataStream))
        case 0x001:
            self = .compressed(data: try ExOleObjStgCompressedAtom(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
