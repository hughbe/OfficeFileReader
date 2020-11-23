//
//  URICreateFlags.swift
//  
//
//  Created by Hugh Bellamy on 10/11/2020.
//

import DataStream

/// [MS-DOC] 2.3.7.7 URICreateFlags
/// Referenced by: URLMoniker
/// This structure specifies creation flags for an [RFC3986] compliant URI. For more information about URI creation flags, see [MSDN-CreateUri].
public struct URICreateFlags {
    public let createAllowRelative: Bool
    public let createAllowImplicitWildcardScheme: Bool
    public let createAllowImplicitFileScheme: Bool
    public let createNoFrag: Bool
    public let createNoCanonicalize: Bool
    public let createCanonicalize: Bool
    public let createFileUseDosPath: Bool
    public let createDecodeExtraInfo: Bool
    public let createNoDecodeExtraInfo: Bool
    public let createCrackUnknownSchemes: Bool
    public let createNoCrackUnknownSchemes: Bool
    public let createPreProcessHtmlUri: Bool
    public let createNoPreProcessHtmlUri: Bool
    public let createIESettings: Bool
    public let createNoIESettings: Bool
    public let createNoEncodeForbiddenCharacters: Bool
    public let reserved: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - createAllowRelative (1 bit): A bit that specifies that if the URI scheme is unspecified and not implicitly "file," a relative scheme is
        /// assumed during creation of the URI.
        self.createAllowRelative = flags.readBit()
        
        /// B - createAllowImplicitWildcardScheme (1 bit): A bit that specifies that if the URI scheme is unspecified and not implicitly "file," a
        /// wildcard scheme is assumed during creation of the URI.
        self.createAllowImplicitWildcardScheme = flags.readBit()
        
        /// C - createAllowImplicitFileScheme (1 bit): A bit that specifies that if the URI scheme is unspecified and the URI begins with a drive
        /// letter or a UNC path, a file scheme is assumed during creation of the URI.
        self.createAllowImplicitFileScheme = flags.readBit()
        
        /// D - createNoFrag (1 bit): A bit that specifies that if a URI query string is present, the URI fragment is not looked for during creation of
        /// the URI.
        self.createNoFrag = flags.readBit()
        
        /// E - createNoCanonicalize (1 bit): A bit that specifies that the scheme, host, authority, path, and fragment will not be canonicalized during
        /// creation of the URI. This value MUST be 0 if createCanonicalize equals 1.
        self.createNoCanonicalize = flags.readBit()
        
        /// F - createCanonicalize (1 bit): A bit that specifies that the scheme, host, authority, path, and fragment will be canonicalized during creation
        /// of the URI. This value MUST be 0 if createNoCanonicalize equals 1.
        self.createCanonicalize = flags.readBit()
        
        /// G - createFileUseDosPath (1 bit): A bit that specifies that MS-DOS path compatibility mode will be used during creation of file URIs.
        self.createFileUseDosPath = flags.readBit()
        
        /// H - createDecodeExtraInfo (1 bit): A bit that specifies that percent encoding and percent decoding canonicalizations will be performed
        /// on the URI query and URI fragment during creation of the URI. This field takes precedence over the createNoCanonicalize field. This
        /// value MUST be 0 if createNoDecodeExtraInfo equals 1. The value 1 can also be saved. This will cause a return value of E_INVALIDARG
        /// from CreateUri().
        self.createDecodeExtraInfo = flags.readBit()
        
        /// I - createNoDecodeExtraInfo (1 bit): A bit that specifies that percent encoding and percent decoding canonicalizations will not be performed
        /// on the URI query and URI fragment during creation of the URI. This field takes precedence over the createCanonicalize field. This value
        /// MUST be 0 if createDecodeExtraInfo equals 1. The value 1 can also be saved. This will cause a return value of E_INVALIDARG from
        /// CreateUri().
        self.createNoDecodeExtraInfo = flags.readBit()
        
        /// J - createCrackUnknownSchemes (1 bit): A bit that specifies that hierarchical URIs with unrecognized URI schemes will be treated like
        /// hierarchical URIs during creation of the URI. This value MUST be 0 if createNoCrackUnknownSchemes equals 1.
        self.createCrackUnknownSchemes = flags.readBit()
        
        /// K - createNoCrackUnknownSchemes (1 bit): A bit that specifies that hierarchical URIs with unrecognized URI schemes will be treated
        /// like opaque URIs during creation of the URI. This value MUST be 0 if createCrackUnknownSchemes equals 1.
        self.createNoCrackUnknownSchemes = flags.readBit()
        
        /// L - createPreProcessHtmlUri (1 bit): A bit that specifies that preprocessing will be performed on the URI to remove control characters
        /// and white space during creation of the URI. This value MUST be 0 if createNoPreProcessHtmlUri equals 1.
        self.createPreProcessHtmlUri = flags.readBit()
        
        /// M - createNoPreProcessHtmlUri (1 bit): A bit that specifies that preprocessing will not be performed on the URI to remove control
        /// characters and white space during creation of the URI. This value MUST be 0 if createPreProcessHtmlUri equals 1.
        self.createNoPreProcessHtmlUri = flags.readBit()
        
        /// N - createIESettings (1 bit): A bit that specifies that registry settings will be used to determine default URL parsing behavior during creation
        /// of the URI. This value MUST be 0 if createNoIESettings equals 1.
        self.createIESettings = flags.readBit()
        
        /// O - createNoIESettings (1 bit): A bit that specifies that registry settings will not be used to determine default URL parsing behavior during
        /// creation of the URI. This value MUST be 0 if createIESettings equals 1.
        self.createNoIESettings = flags.readBit()
        
        /// P - createNoEncodeForbiddenCharacters (1 bit): A bit that specifies that URI characters forbidden in [RFC3986] will not be
        /// percent-encoded during creation of the URI.
        self.createNoEncodeForbiddenCharacters = flags.readBit()
        
        /// reserved (16 bits): MUST be zero and MUST be ignored.
        self.reserved = UInt16(flags.readRemainingBits())
    }
}
