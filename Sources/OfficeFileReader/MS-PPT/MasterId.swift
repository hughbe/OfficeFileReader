//
//  MasterId.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.16 MasterId
/// Referenced by: MasterPersistAtom
/// A 4-byte unsigned integer that specifies an identifier for a main master slide or title master slide.
/// It MUST be greater than or equal to 0x80000000. The set of MasterId values in the file MUST NOT contain duplicates.
public struct MasterId {
    public let value: UInt32
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        guard self.value >= 0x80000000 else {
            throw OfficeFileError.corrupted
        }
    }
}
