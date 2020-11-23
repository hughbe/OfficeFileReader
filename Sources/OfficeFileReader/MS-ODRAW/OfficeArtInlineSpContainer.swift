//
//  OfficeArtInlineSpContainer.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.15 OfficeArtInlineSpContainer
/// The OfficeArtInlineSpContainer record specifies a container for inline shapes. This record SHOULD<4> be ignored.
public struct OfficeArtInlineSpContainer {
    public let shape: OfficeArtSpContainer
    public let rgfb: [OfficeArtBStoreContainerFileBlock]
    
    public init(dataStream: inout DataStream) throws {
        /// shape (variable): An OfficeArtSpContainer record, as defined in section 2.2.14, that specifies an instance of a shape.
        self.shape = try OfficeArtSpContainer(dataStream: &dataStream)
        
        /// rgfb (variable): An array of OfficeArtBStoreContainerFileBlock records, as defined in section 2.2.22, that specifies BLIP data. The array continues
        /// if the rh.recType field of the OfficeArtBStoreContainerFileBlock record equals either 0xF007 or a value from 0xF018 through 0xF117, inclusive.
        /// BLIP properties contained in shape.shapePrimaryOptions or shape.shapeTertiaryOptions1 are stored in this array in the order they are encountered,
        /// and the property values OfficeArtFOPTE.opid.fBid, OfficeArtFOPTE.opid.fComplex, and OfficeArtFOPTE.op MUST be ignored.
        var rgfb: [OfficeArtBStoreContainerFileBlock] = []
        while true {
            let rh = try dataStream.peekOfficeArtRecordHeader()
            guard rh.recType == 0x007 || (rh.recType >= 0xF018 && rh.recType <= 0xF117) else {
                break
            }
            
            rgfb.append(try OfficeArtBStoreContainerFileBlock(dataStream: &dataStream))
        }
        
        self.rgfb = rgfb
    }
}
