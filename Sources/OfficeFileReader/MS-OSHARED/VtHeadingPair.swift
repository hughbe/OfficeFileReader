//
//  VtHeadingPair.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream
import OlePropertySet

/// [MS-OSHARED] 2.3.3.1.13 VtHeadingPair
/// Referenced by: VtVecHeadingPairValue
/// Specifies data for a heading pair for a property.
public struct VtHeadingPair {
    public let headingString: VtUnalignedString
    public let headerParts: TypedPropertyValue
    
    public init(dataStream: inout DataStream) throws {
        /// headingString (variable): A structure of type VtUnalignedString (section 2.3.3.1.12) specifying the header string.
        self.headingString = try VtUnalignedString(dataStream: &dataStream)
        
        /// headerParts (8 bytes): A VT_I4 TypedPropertyValue structure as specified in [MS-OLEPS] section 2.15. The Value field of the
        /// TypedPropertyValue structure specifies the number of document parts associated with this header.
        self.headerParts = try TypedPropertyValue(dataStream: &dataStream, codePage: nil)
        if self.headerParts.type != .i4 {
            throw OfficeFileError.corrupted
        }
    }
}
