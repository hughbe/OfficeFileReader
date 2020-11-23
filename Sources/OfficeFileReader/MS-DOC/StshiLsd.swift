//
//  StshiLsd.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.275 StshiLsd
/// The StshiLsd structure specifies latent style data for application-defined styles. Application-defined styles are considered to be latent if they
/// have an LPStd that is 0x0000 in STSH.rglpstd or if they have no corresponding LPStd in STSH.rglpstd. (For example, if an application has a
/// built-in definition for a "Heading 1" style but that style is not currently defined in a document stylesheet, that style is considered latent.) Latent
/// style data specifies a default set of behavior properties to be used when latent styles are first created.
/// The index into mpstiilsd is the sti value (in the StdfBase structure) of the application-defined style to which it applies. An LSD structure MUST
/// be provided for every application-defined style with sti values from 0 to one less than stiMaxWhenSaved (in the Stshif structure), regardless
/// of whether those application-defined styles are currently latent or not.
public struct StshiLsd {
    public let cbLSD: UInt16
    public let mpstiilsd: [LSD]
    
    public init(dataStream: inout DataStream, stshif: Stshif) throws {
        /// cbLSD (2 bytes): An unsigned 16-bit integer that specifies the size in bytes of the LSD structure. This value MUST be 4.
        self.cbLSD = try dataStream.read(endianess: .littleEndian)
        if self.cbLSD != 0x0004 {
            throw OfficeFileError.corrupted
        }
        
        /// mpstiilsd (variable): An array of LSD structures that specifies the latent style data for applicationdefined styles.
        /// The count of elements MUST be equal to the stiMaxWhenSaved member of the Stshif structure.
        var mpstiilsd: [LSD] = []
        mpstiilsd.reserveCapacity(Int(stshif.stiMaxWhenSaved))
        for _ in 0..<stshif.stiMaxWhenSaved {
            mpstiilsd.append(try LSD(dataStream: &dataStream))
        }
        
        self.mpstiilsd = mpstiilsd
    }
}
