//
//  StshiB.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.273 STSHIB
/// The STSHIB structure has no effect and MUST be ignored.
public struct STSHIB {
    public let grpprlChpStandard: LPStshiGrpPrl
    public let grpprlPapStandard: LPStshiGrpPrl
    
    public init(dataStream: inout DataStream) throws {
        /// grpprlChpStandard (variable): An LPStshiGrpPrl that MUST be ignored.
        self.grpprlChpStandard = try LPStshiGrpPrl(dataStream: &dataStream)
        
        /// grpprlPapStandard (variable): An LPStshiGrpPrl that MUST be ignored.
        self.grpprlPapStandard = try LPStshiGrpPrl(dataStream: &dataStream)
    }
}
