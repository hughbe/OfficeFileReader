//
//  PrintableUnicodeString.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.23 PrintableUnicodeString
/// Referenced by: AuthorNameAtom, BCContactAtom, BCEmailAddressAtom, BCEmailNameAtom, BCSpeakerAtom, BookmarkValueAtom,
/// ClipboardNameAtom, Comment10AuthorAtom, Comment10AuthorInitialAtom, CopyrightAtom, CurrentUserAtom, FileNameAtom, FooterAtom,
/// HeaderAtom, KeywordsAtom, MacroNameAtom, ModifyPasswordAtom, NamedShowAtom, NamedShowNameAtom, PP10DocBinaryTagExtension,
/// PP10ShapeBinaryTagExtension, PP10SlideBinaryTagExtension, PP11DocBinaryTagExtension, PP11ShapeBinaryTagExtension,
/// PP12DocBinaryTagExtension, PP12SlideBinaryTagExtension, PP9DocBinaryTagExtension, PP9ShapeBinaryTagExtension,
/// PP9SlideBinaryTagExtension, ProgIDAtom, ReviewerNameAtom, ServerIdAtom, SoundNameAtom, TagNameAtom, UserDateAtom
/// An array of bytes that specifies a UTF-16 Unicode [RFC2781] string. It MUST NOT contain the following characters:
///  0x0000 - 0x001F
///  0x007F - 0x009F
/// The Unicode NULL character (0x0000), if present, terminates the string.
public struct PrintableUnicodeString: ExpressibleByStringLiteral, Hashable {
    public let value: String
    
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }
    
    public init(dataStream: inout DataStream, byteCount: Int) throws {
        self.value = try dataStream.readString(count: byteCount, encoding: .utf16LittleEndian)!
    }
}
