//
//  FTXBXNonReusable.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.105 FTXBXNonReusable
/// The FTXBXNonReusable structure is used within the FTXBXS structure when that structure describes a real textbox. A real textbox is any shape object
/// into which text is added, and that is the first or only shape in a linked chain.
public struct FTXBXNonReusable {
    public let cTxbx: Int32
    public let cTxbxEdit: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// cTxbx (4 bytes): An integer that specifies how many shapes are in the chain into which the textbox text can flow. This number MUST be
        /// greater than zero and MUST match the length of the chain starting with the shape that is identified by the lid field in the FTXBXS structure
        /// and continuing through each linked shape.
        self.cTxbx = try dataStream.read(endianess: .littleEndian)
        if self.cTxbx < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// cTxbxEdit (4 bytes): This value MUST be zero and MUST be ignored.
        self.cTxbxEdit = try dataStream.read(endianess: .littleEndian)
    }
}
