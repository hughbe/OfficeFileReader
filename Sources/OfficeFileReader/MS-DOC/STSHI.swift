//
//  STSHI.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.272 STSHI
/// The STSHI structure specifies general stylesheet and related information
public struct STSHI {
    public let stshif: Stshif
    public let ftcBi: Int16
    public let stshiLsd: StshiLsd
    public let stshiB: STSHIB
    
    public init(dataStream: inout DataStream) throws {
        /// stshif (18 bytes): An Stshif that specifies general stylesheet information.
        self.stshif = try Stshif(dataStream: &dataStream)
        
        /// ftcBi (2 bytes): A signed integer that specifies an operand value for the sprmCFtcBi for default document formatting, as defined
        /// in the section Determining Formatting Properties.
        self.ftcBi = try dataStream.read(endianess: .littleEndian)
        
        /// StshiLsd (variable): An StshiLsd that specifies latent style data.
        self.stshiLsd = try StshiLsd(dataStream: &dataStream, stshif: self.stshif)
        
        /// StshiB (variable): An STSHIB. This MUST be ignored.
        self.stshiB = try STSHIB(dataStream: &dataStream)
    }
}
