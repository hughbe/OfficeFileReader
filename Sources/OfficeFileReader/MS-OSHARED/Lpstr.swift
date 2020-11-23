//
//  Lpstr.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.4 Lpstr
/// Referenced by: VtString
/// Specifies data for a null-terminated single-byte character string, the encoding of which corresponds to the value of the enclosing property set’s
/// CodePage property ([MS-OLEPS] section 2.18.2). This type deviates from the CodePageString type specified in [MS-OLEPS] section 2.5 in
/// the way that the cch field can be calculated and in the limit to the length of the string.
public struct Lpstr {
    public let cch: UInt32
    public let value: String
    
    public init(dataStream: inout DataStream) throws {
        /// cch (4 bytes): An unsigned integer specifying the number of single-byte characters in the value field. SHOULD be less than or equal to
        /// 0x0000FFFF.<15> SHOULD specify the number of characters in the value field including the terminating NULL character but
        /// not including padding. MAY specify the number of characters in both the value and padding fields.<16>
        self.cch = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// value (variable): A null-terminated array of single-byte characters defining the string.
        self.value = try dataStream.readString(count: Int(self.cch) - 1, encoding: .ascii)!.trimmingCharacters(in: ["\0"])
        if dataStream.position + 1 > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position += 1
        
        /// padding (variable): An array of bytes. The length of the array MUST be the smallest number of bytes required to pad the size of the value
        /// field to a multiple of 4 bytes. The padding SHOULD be 0x00 values, but MAY be undefined values, and MUST be ignored.<17>
        let endPosition = dataStream.position
        let excessBytes = (dataStream.position - startPosition) % 4
        if excessBytes != 0 {
            let position = dataStream.position + (4 - excessBytes)
            if position > dataStream.count {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position = position
        }
        
        if dataStream.position - startPosition != endPosition && dataStream.position - startPosition != self.cch {
            throw OfficeFileError.corrupted
        }
    }
}
