//
//  OfficeArtIDCL.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.46 OfficeArtIDCL
/// Referenced by: OfficeArtFDGGBlock
/// The OfficeArtIDCL record specifies a file identifier cluster, which is used to group shape identifiers within a drawing.
public struct OfficeArtIDCL {
    public let dgid: MSODGID
    public let cspidCur: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// dgid (4 bytes): An MSODGID structure, as defined in section 2.1.1, specifying the drawing identifier that owns this identifier cluster.
        self.dgid = try dataStream.read(endianess: .littleEndian)
        
        /// cspidCur (4 bytes): An unsigned integer that, if less than 0x00000400, specifies the largest shape identifier that is currently assigned in this
        /// cluster, or that otherwise specifies that no shapes can be added to the drawing.
        self.cspidCur = try dataStream.read(endianess: .littleEndian)
    }
}
