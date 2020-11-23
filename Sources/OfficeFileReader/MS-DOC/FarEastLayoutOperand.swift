//
//  FarEastLayoutOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.68 FarEastLayoutOperand
/// The FarEastLayoutOperand structure specifies layout information for text in East Asian languages, as well as the text that is considered part of
/// the same layout unit.
public struct FarEastLayoutOperand {
    public let cb: UInt8
    public let ufel: UFEL
    public let ifeLayoutID: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): The size of this structure, in bytes, not including this byte. cb MUST be 0x06.
        self.cb = try dataStream.read()
        if self.cb != 0x06 {
            throw OfficeFileError.corrupted
        }
        
        /// ufel (2 bytes): A UFEL that specifies the layout information.
        self.ufel = try UFEL(dataStream: &dataStream)
        
        /// lFELayoutID (4 bytes): An integer that specifies whether the corresponding text is in the same layout unit as other text. If two adjacent
        /// text runs have the same lFELayoutID value applied to them, they are laid out together.
        self.ifeLayoutID = try dataStream.read(endianess: .littleEndian)
    }
}
