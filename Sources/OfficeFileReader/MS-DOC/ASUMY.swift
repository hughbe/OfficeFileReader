//
//  ASUMY.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.3 ASUMY
/// The ASUMY structure indicates the priority of a text range for AutoSummary.
public struct ASUMY {
    public let lLevel: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// lLevel (4 bytes): An integer that specifies the priority of the corresponding text range for AutoSummary. A smaller number implies greater
        /// importance of a text range to the summary. lLevel MUST be greater than 0, and MUST be less than or equal to the asumyi.lHighestLevel
        /// field of the Dop97.
        self.lLevel = try dataStream.read(endianess: .littleEndian)
        if self.lLevel < 0 {
            throw OfficeFileError.corrupted
        }
    }
}
