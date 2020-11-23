//
//  RoundTripMainMasterRecord.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.4 RoundTripMainMasterRecord
/// Referenced by: MainMasterContainer
/// A variable type record whose type and meaning is dictated by the value of rh.recType, as specified in the following table.
public enum RoundTripMainMasterRecord {
    /// RT_RoundTripOriginalMainMasterId12Atom A RoundTripOriginalMainMasterId12Atom record that specifies round-trip information. It SHOULD<53>
    /// be ignored and SHOULD<54> be preserved.
    case roundTripOriginalMainMasterId12Atom(data: RoundTripOriginalMainMasterId12Atom)
    
    /// RT_RoundTripTheme12Atom A RoundTripThemeAtom record that specifies round-trip information. It SHOULD<55> be ignored and SHOULD<56>
    /// be preserved.
    case roundTripTheme12Atom(data: RoundTripThemeAtom)
    
    /// RT_RoundTripColorMapping12Atom A RoundTripColorMappingAtom record that specifies round-trip information. It SHOULD<57> be ignored and
    /// SHOULD<58> be preserved.
    case roundTripColorMapping12Atom(data: RoundTripColorMappingAtom)
    
    /// RT_RoundTripContentMasterInfo12Atom A RoundTripContentMasterInfo12Atom record that specifies roundtrip information. It SHOULD<59> be
    /// ignored and SHOULD<60> be preserved.
    case roundTripContentMasterInfo12Atom(data: RoundTripContentMasterInfo12Atom)
    
    /// RT_RoundTripOArtTextStyles12Atom A RoundTripOArtTextStyles12Atom record that specifies round-trip information. It SHOULD<61> be ignored
    /// and SHOULD<62> be preserved.
    case roundTripOArtTextStyles12Atom(data: RoundTripOArtTextStyles12Atom)
    
    /// RT_RoundTripAnimationHashAtom12Atom A RoundTripAnimationHashAtom record that specifies round-trip information. It SHOULD<63> be
    /// ignored and SHOULD<64> be preserved.
    case roundTripAnimationHashAtom12Atom(data: RoundTripAnimationHashAtom)
    
    /// RT_RoundTripAnimationAtom12Atom A RoundTripAnimationAtom record that specifies round-trip information. It SHOULD<65> be ignored and
    /// SHOULD<66> be preserved.
    case roundTripAnimationAtom12Atom(data: RoundTripAnimationAtom)
    
    /// RT_RoundTripCompositeMasterId12Atom A RoundTripCompositeMasterId12Atom record that specifies roundtrip information. It SHOULD<67>
    /// be ignored and SHOULD<68> be preserved.
    case roundTripCompositeMasterId12Atom(data: RoundTripCompositeMasterId12Atom)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .roundTripOriginalMainMasterId12Atom:
            self = .roundTripOriginalMainMasterId12Atom(data: try RoundTripOriginalMainMasterId12Atom(dataStream: &dataStream))
        case .roundTripTheme12Atom:
            self = .roundTripTheme12Atom(data: try RoundTripThemeAtom(dataStream: &dataStream))
        case .roundTripColorMapping12Atom:
            self = .roundTripColorMapping12Atom(data: try RoundTripColorMappingAtom(dataStream: &dataStream))
        case .roundTripContentMasterInfo12Atom:
            self = .roundTripContentMasterInfo12Atom(data: try RoundTripContentMasterInfo12Atom(dataStream: &dataStream))
        case .roundTripOArtTextStyles12Atom:
            self = .roundTripOArtTextStyles12Atom(data: try RoundTripOArtTextStyles12Atom(dataStream: &dataStream))
        case .roundTripAnimationHashAtom12Atom:
            self = .roundTripAnimationHashAtom12Atom(data: try RoundTripAnimationHashAtom(dataStream: &dataStream))
        case .roundTripAnimationAtom12Atom:
            self = .roundTripAnimationAtom12Atom(data: try RoundTripAnimationAtom(dataStream: &dataStream))
        case .roundTripCompositeMasterId12Atom:
            self = .roundTripCompositeMasterId12Atom(data: try RoundTripCompositeMasterId12Atom(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
