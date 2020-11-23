//
//  OfficeArtBStoreContainerFileBlock.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.22 OfficeArtBStoreContainerFileBlock
/// Referenced by: OfficeArtBStoreContainer, OfficeArtBStoreDelay, OfficeArtInlineSpContainer The OfficeArtBStoreContainerFileBlock record specifies a file
/// block that contains a record specifying BLIP data. The OfficeArtRecordHeader structure, as defined in section 2.2.1, of the contained record specifies the
/// type of record. The following table lists the possible record types.
public enum OfficeArtBStoreContainerFileBlock {
    /// 0xF007 OfficeArtFBSE record, as defined in section 2.2.32.
    case fbse(data: OfficeArtFBSE)
    
    /// 0xF018–0xF117 OfficeArtBlip record, as defined in section 2.2.23.
    case blip(data: OfficeArtBlip)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        dataStream.position = position
        
        switch rh.recType {
        case 0xF007:
            self = .fbse(data: try OfficeArtFBSE(dataStream: &dataStream))
        case let recType where recType >= 0xF018 && recType <= 0xF117:
            self = .blip(data: try OfficeArtBlip(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
