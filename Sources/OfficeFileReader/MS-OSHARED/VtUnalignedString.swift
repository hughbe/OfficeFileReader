//
//  VtUnalignedString.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.12 VtUnalignedString
/// Referenced by: VtHeadingPair
/// Specifies the format of a property for which the value is a string but where the stringValue field is not padded to any particular length if it is a
/// single-byte character string type.
public struct VtUnalignedString {
    public let stringType: UInt16
    public let padding: UInt16
    public let stringValue: StringValue
    
    public init(dataStream: inout DataStream) throws {
        /// stringType (2 bytes): An unsigned integer that MUST be VT_LPSTR (0x001E) or VT_LPWSTR (0x001F).
        let stringType: UInt16 = try dataStream.read(endianess: .littleEndian)
        if stringType != 0x001E && stringType != 0x001F {
            throw OfficeFileError.corrupted
        }
        
        self.stringType = stringType
        
        /// padding (2 bytes): An unsigned integer that MUST be 0x0000. MUST be ignored.
        self.padding = try dataStream.read(endianess: .littleEndian)
        
        /// stringValue (variable): A structure that determines its type depending on the value of the stringType field according to the following table.
        /// stringType stringValue type
        /// VT_LPSTR (0x001E) UnalignedLpstr (section 2.3.3.1.5)
        /// VT_LPWSTR (0x001F) Lpwstr (section 2.3.3.1.6)
        if self.stringType == 0x001E {
            self.stringValue = .lpstr(data: try UnalignedLpstr(dataStream: &dataStream))
        } else {
            self.stringValue = .lpwstr(data: try Lpwstr(dataStream: &dataStream))
        }
    }
    
    /// stringValue (variable): A structure that determines its type depending on the value of the stringType field according to the following table.
    public enum StringValue {
        /// VT_LPSTR (0x001E) UnalignedLpstr (section 2.3.3.1.5)
        case lpstr(data: UnalignedLpstr)
        
        /// VT_LPWSTR (0x001F) Lpwstr (section 2.3.3.1.6)
        case lpwstr(data: Lpwstr)
    }
}
