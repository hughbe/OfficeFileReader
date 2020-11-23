//
//  OfficeArtFRIT.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.42 OfficeArtFRIT
/// Referenced by: OfficeArtFRITContainer
/// The OfficeArtFRIT record specifies the last two group identifiers that are used to facilitate regrouping ungrouped shapes.
public struct OfficeArtFRIT {
    public let fridNew: FRID
    public let fridOld: FRID
    
    public init(dataStream: inout DataStream) throws {
        /// fridNew (2 bytes): A FRID structure, as defined in section 2.1.3, specifying the last group identifier of the shape before ungrouping. The value of
        /// fridNew MUST be greater than the value of fridOld.
        self.fridNew = try dataStream.read(endianess: .littleEndian)
        
        /// fridOld (2 bytes): A FRID structure, as defined in section 2.1.3, specifying the second-to-last group identifier of the shape before ungrouping.
        /// This value MUST be 0x0000 if a second-to-last group does not exist.
        self.fridOld = try dataStream.read(endianess: .littleEndian)
        if self.fridOld >= self.fridNew {
            throw OfficeFileError.corrupted
        }
    }
}
