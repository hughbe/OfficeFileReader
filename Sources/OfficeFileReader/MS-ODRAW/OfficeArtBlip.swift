//
//  OfficeArtBlip.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.23 OfficeArtBlip
/// Referenced by: fillBlip_complex, lineBottomFillBlip_complex, lineFillBlip_complex, lineLeftFillBlip_complex, lineRightFillBlip_complex, lineTopFillBlip_complex,
/// OfficeArtBStoreContainerFileBlock, OfficeArtFBSE, pib_complex, pibPrint_complex
/// The OfficeArtBlip record specifies BLIP file data. The OfficeArtRecordHeader structure, as defined in section 2.2.1, specifies the type of BLIP record that is
/// contained. The following table lists the possible record types.
public enum OfficeArtBlip {
    /// 0xF01A OfficeArtBlipEMF, as defined in section 2.2.24.
    case emf(data: OfficeArtBlipEMF)
    
    /// 0xF01B OfficeArtBlipWMF, as defined in section 2.2.25.
    case wmf(data: OfficeArtBlipWMF)
    
    /// 0xF01C OfficeArtBlipPICT, as defined in section 2.2.26.
    case pict(data: OfficeArtBlipPICT)
    
    /// 0xF01D OfficeArtBlipJPEG, as defined in section 2.2.27.
    /// 0xF02A OfficeArtBlipJPEG, as defined in section 2.2.27.<5>
    case jpeg(data: OfficeArtBlipJPEG)
    
    /// 0xF01E OfficeArtBlipPNG, as defined in section 2.2.28.
    case png(data: OfficeArtBlipPNG)
    
    /// 0xF01F OfficeArtBlipDIB, as defined in section 2.2.29.
    case dib(data: OfficeArtBlipDIB)
    
    /// 0xF029 OfficeArtBlipTIFF, as defined in section 2.2.30.
    case tiff(data: OfficeArtBlipTIFF)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        dataStream.position = position
        
        switch rh.recType {
        case 0xF01A:
            self = .emf(data: try OfficeArtBlipEMF(dataStream: &dataStream))
        case 0xF01B:
            self = .wmf(data: try OfficeArtBlipWMF(dataStream: &dataStream))
        case 0xF01C:
            self = .pict(data: try OfficeArtBlipPICT(dataStream: &dataStream))
        case 0xF01D, 0xF02A:
            self = .jpeg(data: try OfficeArtBlipJPEG(dataStream: &dataStream))
        case 0xF01E:
            self = .png(data: try OfficeArtBlipPNG(dataStream: &dataStream))
        case 0xF01F:
            self = .dib(data: try OfficeArtBlipDIB(dataStream: &dataStream))
        case 0xF029:
            self = .tiff(data: try OfficeArtBlipTIFF(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
