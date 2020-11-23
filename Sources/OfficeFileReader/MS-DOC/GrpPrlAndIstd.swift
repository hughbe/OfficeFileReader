//
//  GrpPrlAndIstd.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.114 GrpPrlAndIstd
/// The GrpPrlAndIstd structure specifies the style and properties that are applied to a paragraph, a table row, or a table cell.
public struct GrpPrlAndIstd {
    public let istd: UInt16
    public let grpprl: [Prl]
    
    public init(dataStream: inout DataStream, size: UInt16) throws {
        let startPosition = dataStream.position
        
        /// istd (2 bytes): An integer that specifies the style that is applied to this paragraph, cell marker or table row marker. See
        /// Applying Properties for more details about how to interpret this value.
        self.istd = try dataStream.read(endianess: .littleEndian)
        
        /// grpprl (variable): An array of Prl elements. Specifies the properties of this paragraph, table row, or table cell. This array MUST
        /// contain a whole number of Prl elements.
        var grpprl: [Prl] = []
        while dataStream.position - startPosition < size {
            grpprl.append(try Prl(dataStream: &dataStream))
        }
        
        self.grpprl = grpprl
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
