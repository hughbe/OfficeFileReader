//
//  OfficeArtSolverContainerFileBlock.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.19 OfficeArtSolverContainerFileBlock
/// Referenced by: OfficeArtSolverContainer
/// The OfficeArtSolverContainerFileBlock record specifies a file block that contains a record specifying rule data. The OfficeArtRecordHeader structure, as
/// defined in section 2.2.1, of the contained record specifies the type of record. The following table lists the possible record types.
public enum OfficeArtSolverContainerFileBlock {
    /// 0xF012 OfficeArtFConnectorRule, as defined in section 2.2.36.
    case fConnectorRule(data: OfficeArtFConnectorRule)
    
    /// 0xF014 OfficeArtFArcRule, as defined in section 2.2.35.
    case fArcRule(data: OfficeArtFArcRule)
    
    /// 0xF017 OfficeArtFCalloutRule, as defined in section 2.2.34.
    case fCalloutRule(data: OfficeArtFCalloutRule)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        dataStream.position = position
        
        switch rh.recType {
        case 0xF012:
            self = .fConnectorRule(data: try OfficeArtFConnectorRule(dataStream: &dataStream))
        case 0xF014:
            self = .fArcRule(data: try OfficeArtFArcRule(dataStream: &dataStream))
        case 0xF017:
            self = .fCalloutRule(data: try OfficeArtFCalloutRule(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
