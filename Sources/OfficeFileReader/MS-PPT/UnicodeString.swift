//
//  UnicodeString.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.35 UnicodeString
/// Referenced by: BCDescriptionAtom, BCEntryIDAtom, BCTitleAtom, FriendlyNameAtom, LocationAtom, MenuNameAtom, ScreenTipAtom, SlideNameAtom,
/// TagValueAtom, TargetAtom, TemplateNameAtom, TimeEventFilter, TimeNodeTimeFilter, TimePointsTypes, TimeRuntimeContext, TimeVariantString
/// An array of bytes that specifies a UTF-16 Unicode [RFC2781] string. The Unicode NULL character (0x0000), if present, terminates the string.
public struct UnicodeString: ExpressibleByStringLiteral, Hashable {
    public let value: String
    
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }
    
    public init(dataStream: inout DataStream, byteCount: Int) throws {
        self.value = try dataStream.readString(count: byteCount, encoding: .utf16LittleEndian)!
    }
}
