//
//  OfficeArtClientData.swift
//  
//
//  Created by Hugh Bellamy on 14/11/2020.
//

import DataStream

public enum OfficeArtClientData {
    case doc(data: OfficeArtClientDataDoc)
    case ppt(data: OfficeArtClientDataPpt)
    
    public init(dataStream: inout DataStream) throws {
        let rh = try dataStream.peekOfficeArtRecordHeader()
        guard rh.recType == 0xF011 else {
            throw OfficeFileError.corrupted
        }
        
        switch rh.recLen {
        case 4:
            self = .doc(data: try OfficeArtClientDataDoc(dataStream: &dataStream))
        default:
            self = .ppt(data: try OfficeArtClientDataPpt(dataStream: &dataStream))
        }
    }
}
