//
//  PROJECTREFERENCES.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.2 PROJECTREFERENCES Record
/// Specifies the external references of the VBA project as a variably sized array of REFERENCE (section 2.3.4.2.2.1). The termination of the array
/// is indicated by the beginning of PROJECTMODULES (section 2.3.4.2.3), which is indicated by a REFERENCE (section 2.3.4.2.2.1) being followed
/// by an unsigned 16-bit integer with a value of 0x000F.
public struct PROJECTREFERENCES {
    public let referenceArray: [REFERENCE]
    
    public init(dataStream: inout DataStream) throws {
        /// ReferenceArray (variable): An array of REFERENCE Records (section 2.3.4.2.2.1).
        var referenceArray: [REFERENCE] = []
        while try dataStream.peek(endianess: .littleEndian) as UInt16 != 0x000F {
            referenceArray.append(try REFERENCE(dataStream: &dataStream))
        }
        
        self.referenceArray = referenceArray
    }
}
