//
//  HandoutRoundTripAtom.swift
//  
//
//  Created by Hugh Bellamy on 23/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.9 HandoutRoundTripAtom
/// Referenced by: HandoutContainer
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified in the following table.
public enum HandoutRoundTripAtom {
    /// RT_RoundTripTheme12Atom A RoundTripThemeAtom record that specifies round-trip information. It SHOULD<77> be ignored and
    /// SHOULD<78> be preserved.
    case roundTripTheme12Atom(data: RoundTripThemeAtom)
    
    /// RT_RoundTripColorMapping12Atom A RoundTripColorMappingAtom record that specifies round-trip information. It SHOULD<79> be ignored
    /// and SHOULD<80> be preserved.
    case roundTripColorMapping12Atom(data: RoundTripColorMappingAtom)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .roundTripTheme12Atom:
            self = .roundTripTheme12Atom(data: try RoundTripThemeAtom(dataStream: &dataStream))
        case .roundTripColorMapping12Atom:
            self = .roundTripColorMapping12Atom(data: try RoundTripColorMappingAtom(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
