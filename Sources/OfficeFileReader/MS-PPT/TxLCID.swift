//
//  TxLCID.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.31 TxLCID
/// Referenced by: TextSIException
/// A 2-byte unsigned integer that specifies a language identifier. It MUST be a value from the following table.
public enum TxLCID {
    /// 0x0000 No language.
    case noLanguage
    
    /// 0x0013 Any Dutch language is preferred over non-Dutch languages when proofing the text.
    case anyDutchLanguagePreferredOverNonDutchLanguage
    
    /// 0x0400 No proofing is performed on the text.
    case noProofing
    
    /// Greater than 0x0400 A valid LCID as specified by [MS-LCID].
    case lcid(lcid: UInt16)
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt16 = try dataStream.read(endianess: .littleEndian)
        switch rawValue {
        case 0x0000:
            self = .noLanguage
        case 0x0013:
            self = .anyDutchLanguagePreferredOverNonDutchLanguage
        case 0x0400:
            self = .noProofing
        case let lcid where lcid > 0x0400:
            self = .lcid(lcid: lcid)
        default:
            throw OfficeFileError.corrupted
        }
    }
}
