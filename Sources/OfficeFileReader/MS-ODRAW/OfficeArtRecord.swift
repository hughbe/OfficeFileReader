//
//  OfficeArtRecord.swift
//  
//
//  Created by Hugh Bellamy on 14/11/2020.
//

import DataStream

public enum OfficeArtRecord {
    case dggContainer(data: OfficeArtDggContainer)
    case bStoreContainer(data: OfficeArtBStoreContainer)
    case dgContainer(data: OfficeArtDgContainer)
    case spgrContainer(data: OfficeArtSpgrContainer)
    case spContainer(data: OfficeArtSpContainer)
    case solverContainer(data: OfficeArtSolverContainer)
    case fdggBlock(data: OfficeArtFDGGBlock)
    case fbse(data: OfficeArtFBSE)
    case fdg(data: OfficeArtFDG)
    case fspgr(data: OfficeArtFSPGR)
    case fsp(data: OfficeArtFSP)
    case fopt(data: OfficeArtFOPT)
    case clientTextbox(data: OfficeArtClientTextboxPpt)
    case childAnchor(data: OfficeArtChildAnchor)
    case clientAnchor(data: OfficeArtClientAnchorPpt)
    case clientData(data: OfficeArtClientData)
    case fConnectorRule(data: OfficeArtFConnectorRule)
    case fArcRule(data: OfficeArtFArcRule)
    case fCalloutRule(data: OfficeArtFCalloutRule)
    case blip(data: OfficeArtBlip)
    case fritContainer(data: OfficeArtFRITContainer)
    case colorMRUContainer(data: OfficeArtColorMRUContainer)
    case fpspl(data: OfficeArtFPSPL)
    case splitMenuColorContainer(data: OfficeArtSplitMenuColorContainer)
    case secondaryFOPT(data: OfficeArtSecondaryFOPT)
    case tertiaryFOPT(data: OfficeArtTertiaryFOPT)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        dataStream.position = position
        
        switch rh.recType {
        case 0xF000:
            self = .dggContainer(data: try OfficeArtDggContainer(dataStream: &dataStream))
        case 0xF001:
            self = .bStoreContainer(data: try OfficeArtBStoreContainer(dataStream: &dataStream))
        case 0xF002:
            self = .dgContainer(data: try OfficeArtDgContainer(dataStream: &dataStream))
        case 0xF003:
            self = .spgrContainer(data: try OfficeArtSpgrContainer(dataStream: &dataStream))
        case 0xF004:
            self = .spContainer(data: try OfficeArtSpContainer(dataStream: &dataStream))
        case 0xF005:
            self = .solverContainer(data: try OfficeArtSolverContainer(dataStream: &dataStream))
        case 0xF006:
            self = .fdggBlock(data: try OfficeArtFDGGBlock(dataStream: &dataStream))
        case 0xF007:
            self = .fbse(data: try OfficeArtFBSE(dataStream: &dataStream))
        case 0xF008:
            self = .fdg(data: try OfficeArtFDG(dataStream: &dataStream))
        case 0xF009:
            self = .fspgr(data: try OfficeArtFSPGR(dataStream: &dataStream))
        case 0xF00A:
            self = .fsp(data: try OfficeArtFSP(dataStream: &dataStream))
        case 0xF00B:
            self = .fopt(data: try OfficeArtFOPT(dataStream: &dataStream))
        case 0xF00D:
            self = .clientTextbox(data: try OfficeArtClientTextboxPpt(dataStream: &dataStream))
        case 0xF00F:
            self = .childAnchor(data: try OfficeArtChildAnchor(dataStream: &dataStream))
        case 0xF010:
            self = .clientAnchor(data: try OfficeArtClientAnchorPpt(dataStream: &dataStream))
        case 0xF011:
            self = .clientData(data: try OfficeArtClientData(dataStream: &dataStream))
        case 0xF012:
            self = .fConnectorRule(data: try OfficeArtFConnectorRule(dataStream: &dataStream))
        case 0xF014:
            self = .fArcRule(data: try OfficeArtFArcRule(dataStream: &dataStream))
        case 0xF017:
            self = .fCalloutRule(data: try OfficeArtFCalloutRule(dataStream: &dataStream))
        case let recType where recType >= 0xF018 && recType <= 0xF117:
            self = .blip(data: try OfficeArtBlip(dataStream: &dataStream))
        case 0xF118:
            self = .fritContainer(data: try OfficeArtFRITContainer(dataStream: &dataStream))
        case 0xF11A:
            self = .colorMRUContainer(data: try OfficeArtColorMRUContainer(dataStream: &dataStream))
        case 0xF11D:
            self = .fpspl(data: try OfficeArtFPSPL(dataStream: &dataStream))
        case 0xF11E:
            self = .splitMenuColorContainer(data: try OfficeArtSplitMenuColorContainer(dataStream: &dataStream))
        case 0xF121:
            self = .secondaryFOPT(data: try OfficeArtSecondaryFOPT(dataStream: &dataStream))
        case 0xF122:
            self = .tertiaryFOPT(data: try OfficeArtTertiaryFOPT(dataStream: &dataStream))
        default:
            fatalError("NYI: \(rh.recType.hexString)")
        }
    }
}
