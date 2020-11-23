//
//  OfficeArtSpgrContainerFileBlock.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.17 OfficeArtSpgrContainerFileBlock
/// Referenced by: OfficeArtDgContainer, OfficeArtSpgrContainer
/// The OfficeArtSpgrContainerFileBlock record specifies a file block that contains a record specifying
/// group or shape data. The OfficeArtRecordHeader structure, as defined in section 2.2.1, of the contained record specifies the type of record. The following
/// table lists the possible record types.
public enum OfficeArtSpgrContainerFileBlock {
    /// 0xF004 OfficeArtSpContainer record, as defined in section 2.2.14.
    case spContainer(data: OfficeArtSpContainer)
    
    /// 0xF003 OfficeArtSpgrContainer record, as defined in section 2.2.16.
    case spgrContainer(data: OfficeArtSpgrContainer)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekOfficeArtRecordHeader().recType {
        case 0xF004:
            self = .spContainer(data: try OfficeArtSpContainer(dataStream: &dataStream))
        case 0xF003:
            self = .spgrContainer(data: try OfficeArtSpgrContainer(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
