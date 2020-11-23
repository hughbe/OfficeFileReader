//
//  OfficeArtDggContainer.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.12 OfficeArtDggContainer
/// The OfficeArtDggContainer record type specifies the container for all the OfficeArt file records that contain document-wide data. <2>
public struct OfficeArtDggContainer {
    public let rh: OfficeArtRecordHeader
    public let drawingGroup: OfficeArtFDGGBlock?
    public let blipStore: OfficeArtBStoreContainer?
    public let drawingPrimaryOptions: OfficeArtFOPT?
    public let drawingTertiaryOptions: OfficeArtTertiaryFOPT?
    public let colorMRU: OfficeArtColorMRUContainer?
    public let splitColors: OfficeArtSplitMenuColorContainer?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0xF.
        /// rh.recInstance A value that MUST be 0x000.
        /// rh.recType A value that MUST be 0xF000.
        /// rh.recLen An unsigned integer specifying the number of bytes following the header that contain document-wide file records.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF000 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var drawingGroup: OfficeArtFDGGBlock? = nil
        var blipStore: OfficeArtBStoreContainer? = nil
        var drawingPrimaryOptions: OfficeArtFOPT? = nil
        var drawingTertiaryOptions: OfficeArtTertiaryFOPT? = nil
        var colorMRU: OfficeArtColorMRUContainer? = nil
        var splitColors: OfficeArtSplitMenuColorContainer? = nil
        while dataStream.position - startPosition < self.rh.recLen {
            let record = try OfficeArtRecord(dataStream: &dataStream)
            switch record {
            case .fdggBlock(data: let data):
                /// drawingGroup (variable): An OfficeArtFDGGBlock record, as defined in section 2.2.48, that specifies document-wide information about
                /// all the drawings that are saved in the file.
                drawingGroup = data
            case .bStoreContainer(data: let data):
                /// blipStore (variable): An OfficeArtBStoreContainer record, as defined in section 2.2.20, that specifies the container for all the BLIPs that
                /// are used in all the drawings in the parent document.
                blipStore = data
            case .fopt(data: let data):
                /// drawingPrimaryOptions (variable): An OfficeArtFOPT record, as defined in section 2.2.9, that specifies the default properties for all
                /// drawing objects that are contained in all the drawings in the parent document.
                drawingPrimaryOptions = data
            case .tertiaryFOPT(data: let data):
                /// drawingTertiaryOptions (variable): An OfficeArtTertiaryFOPT record, as defined in section 2.2.11, that specifies the default properties
                /// for all the drawing objects that are contained in all the drawings in the parent document.
                drawingTertiaryOptions = data
            case .colorMRUContainer(data: let data):
                /// colorMRU (variable): An OfficeArtColorMRUContainer record, as defined in section 2.2.43, that specifies the most recently used
                /// custom colors.
                colorMRU = data
            case .splitMenuColorContainer(data: let data):
                /// splitColors (variable): An OfficeArtSplitMenuColorContainer record, as defined in section 2.2.45, that specifies a container for the colors that were
                /// most recently used to format shapes.
                splitColors = data
            default:
                continue
            }
        }
        
        self.drawingGroup = drawingGroup
        self.blipStore = blipStore
        self.drawingPrimaryOptions = drawingPrimaryOptions
        self.drawingTertiaryOptions = drawingTertiaryOptions
        self.colorMRU = colorMRU
        self.splitColors = splitColors
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
