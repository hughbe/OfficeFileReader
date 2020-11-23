//
//  UnalignedLpstr.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.5 UnalignedLpstr
/// Referenced by: VtUnalignedString, VtVecUnalignedLpstrValue
/// Specifies data for a null-terminated single-byte character string, the encoding of which corresponds to the value of the enclosing property set’s
/// CodePage property ([MS-OLEPS] section 2.18.2). This type deviates from the CodePageString type specified in [MS-OLEPS] section 2.5 in
/// the absence of padding bytes and in the limit to the length of the string.
public struct UnalignedLpstr {
    public let cch: UInt32
    public let value: String
    
    public init(dataStream: inout DataStream) throws {
        /// cch (4 bytes): An unsigned integer specifying the number of single-byte characters in the value field. SHOULD be less than or equal
        /// to 0x0000FFFF.<18>
        self.cch = try dataStream.read(endianess: .littleEndian)
        
        /// value (variable): A null-terminated array of single-byte characters defining the string.
        self.value = try dataStream.readString(count: Int(self.cch), encoding: .ascii)!
    }
}
