//
//  RatioStruct.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.12.6 RatioStruct
/// Referenced by: DocumentAtom, NormalViewSetInfoAtom, ScalingStruct
/// A structure that specifies a rational number.
public struct RatioStruct {
    public let numer: Int32
    public let denom: Int32
    
    public var ratio: Double { Double(numer) / Double(denom) }
    
    public init(dataStream: inout DataStream) throws {
        /// numer (4 bytes): A signed integer that specifies the numerator portion of this ratio.
        self.numer = try dataStream.read(endianess: .littleEndian)
        
        /// denom (4 bytes): A signed integer that specifies the denominator portion of this ratio. It MUST NOT be 0x00000000.
        self.denom = try dataStream.read(endianess: .littleEndian)
        guard self.denom != 0x00000000 else {
            throw OfficeFileError.corrupted
        }
    }
}
