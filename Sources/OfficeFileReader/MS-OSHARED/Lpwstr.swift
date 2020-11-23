//
//  Lpwstr.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.6 Lpwstr
/// Referenced by: VtHyperlink, VtString, VtUnalignedString, VtVecLpwstrValue Specifies data for a null-terminated Unicode character string.
/// This type deviates from the UnicodeString type specified in [MS-OLEPS] section 2.7 in the limit to the length of the string and in the way the
/// length is specified in characters and not bytes.
public struct Lpwstr {
    public let cch: UInt32
    public let value: String
    
    public init(dataStream: inout DataStream) throws {
        /// cch (4 bytes): An unsigned integer specifying the number of Unicode characters written as the value field including the terminating NULL
        /// character. SHOULD be less than or equal to 0x0000FFFF.<19>
        self.cch = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// value (variable): A null-terminated array of Unicode characters defining the string.
        self.value = try dataStream.readString(count: Int(self.cch * 2) - 2, encoding: .ascii)!.trimmingCharacters(in: ["\0"])
        if dataStream.position + 2 > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position += 2
        
        /// padding (variable): An array of bytes. The length of the array MUST be the smallest number of bytes required to pad the size of the
        /// value field to a multiple of 4 bytes. The padding SHOULD be 0x00 values, but MAY be undefined values, and MUST be ignored.<20>
        let excessBytes = (dataStream.position - startPosition) % 4
        if excessBytes != 0 {
            let position = dataStream.position + (4 - excessBytes)
            if position > dataStream.count {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position = position
        }
        
        if dataStream.position - startPosition != self.cch {
            throw OfficeFileError.corrupted
        }
    }
}
