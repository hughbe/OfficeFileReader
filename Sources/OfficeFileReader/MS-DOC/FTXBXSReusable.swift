//
//  FTXBXSReusable.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.107 FTXBXSReusable
/// The FTXBXSReusable structure is used within the FTXBXS structure when it describes a spare structure that can be reused by the application and
/// converted into an actual textbox. An FTXBXS structure can become reusable when the shape is deleted or linked after another shape in a chain.
/// Additionally, the final FTXBXS structure in a PLC is reusable. All reusable FTXBXS structures in a PLC are part of a single chain, with the last FTXBXS
/// structure in a PLC being the first item in the chain.
public struct FTXBXSReusable {
    public let iNextReuse: Int32
    public let cReusable: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// iNextReuse (4 bytes): An integer that specifies the index of the next reusable item in the chain. If this is the last FTXBXS structure in the chain,
        /// this value MUST be -1. Otherwise, this value MUST be non-negative, and MUST be less than the number of FTXBXS structures in the PLC.
        /// Furthermore, the FTXBXS structure at that index MUST be flagged as reusable, and MUST have a cReusable value that is 1 less than the
        /// cReusable value from this structure.
        self.iNextReuse = try dataStream.read(endianess: .littleEndian)
        if self.iNextReuse < -1 {
            throw OfficeFileError.corrupted
        }
        
        /// cReusable (4 bytes): An integer that specifies how many reusable FTXBXS structures are in the chain after this one. If this is the last FTXBXS
        /// structure in the chain, this value MUST be zero. Otherwise, it MUST be greater than zero, and MUST be less than the number of FTXBXS
        /// structures in the PLC.
        self.cReusable = try dataStream.read(endianess: .littleEndian)
        if self.cReusable < 0 {
            throw OfficeFileError.corrupted
        }
    }
}
