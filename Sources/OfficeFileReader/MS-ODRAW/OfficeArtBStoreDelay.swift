//
//  OfficeArtBStoreDelay.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.21 OfficeArtBStoreDelay
/// The OfficeArtBStoreDelay record specifies the delay-loaded container of BLIPs in the host application. No OfficeArtRecordHeader structure, as defined in
/// section 2.2.1, exists for this container.
public struct OfficeArtBStoreDelay {
    public let rgfb: [OfficeArtBStoreContainerFileBlock]
    
    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position
        
        /// rgfb (variable): An array of OfficeArtBStoreContainerFileBlock records, as defined in section 2.2.22, that specifies BLIP data. The array continues
        /// if the rh.recType field of the OfficeArtBStoreContainerFileBlock record equals either 0xF007 or a value from 0xF018 through 0xF117, inclusive.
        var rgfb: [OfficeArtBStoreContainerFileBlock] = []
        while dataStream.position - startPosition < size {
            let position = dataStream.position
            let rh = try OfficeArtRecordHeader(dataStream: &dataStream)
            dataStream.position = position
            
            guard rh.recType == 0x007 || (rh.recType >= 0xF018 && rh.recType <= 0xF117) else {
                break
            }
            
            rgfb.append(try OfficeArtBStoreContainerFileBlock(dataStream: &dataStream))
        }
        
        self.rgfb = rgfb
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
