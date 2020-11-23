//
//  PChgTabsDel.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.180 PChgTabsDel
/// The PChgTabsDel structure specifies the locations at which custom tab stops are ignored
public struct PChgTabsDel {
    public let cTabs: UInt8
    public let rgdxaDel: [XAS]
    
    public init(dataStream: inout DataStream) throws {
        /// cTabs (1 byte): An unsigned integer that specifies the number of records in rgdxaDel. This value MUST be less than or equal to 64.
        self.cTabs = try dataStream.read()
        if self.cTabs > 64 {
            throw OfficeFileError.corrupted
        }
        
        /// rgdxaDel (variable): An array of XAS. The number of records is specified by cTabs. The elements contained in the array MUST be in ascending
        /// order. Each XAS specifies a location at which to ignore any custom tab stop within 25 twips.
        var rgdxaDel: [XAS] = []
        rgdxaDel.reserveCapacity(Int(self.cTabs))
        for _ in 0..<self.cTabs {
            rgdxaDel.append(try XAS(dataStream: &dataStream))
        }
        
        self.rgdxaDel = rgdxaDel
    }
}
