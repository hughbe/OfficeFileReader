//
//  ExHyperlinkId.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.5 ExHyperlinkId
/// Referenced by: ExHyperlinkAtom
/// A 4-byte unsigned integer that specifies an identifier for a hyperlink. It MUST be greater than 0x00000000. The combined set of ExObjId
/// (section 2.2.7) and ExHyperlinkId values in the file MUST NOT contain duplicates.
public struct ExHyperlinkId {
    public let value: UInt32
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        if self.value == 0x00000000 {
            throw OfficeFileError.corrupted
        }
    }
}
