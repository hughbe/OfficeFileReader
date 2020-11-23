//
//  ExObjId.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.7 ExObjId
/// Referenced by: ExMediaAtom, ExOleObjAtom
/// A 4-byte unsigned integer that specifies an identifier for an external object. It MUST be greater than 0x00000000. The combined set of ExObjId
/// and ExHyperlinkId (section 2.2.5) values in the file MUST NOT contain duplicates.
public struct ExObjId {
    public let value: UInt32
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        if self.value == 0x00000000 {
            throw OfficeFileError.corrupted
        }
    }
}
