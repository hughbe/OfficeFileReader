//
//  ParaBuildLevel.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.9 ParaBuildLevel
/// Referenced by: ParaBuildContainer
/// A structure that specifies information about the build step for a specific paragraph level.
public struct ParaBuildLevel {
    public let levelInfoAtom: LevelInfoAtom
    public let timeNode: ExtTimeNodeContainer
    
    public init(dataStream: inout DataStream) throws {
        /// levelInfoAtom (12 bytes): A LevelInfoAtom record that specifies the paragraph level.
        self.levelInfoAtom = try LevelInfoAtom(dataStream: &dataStream)
        
        /// timeNode (variable): An ExtTimeNodeContainer record (section 2.8.15) that specifies all time nodes for the paragraph level specified by
        /// the levelInfoAtom.
        self.timeNode = try ExtTimeNodeContainer(dataStream: &dataStream)
    }
}
