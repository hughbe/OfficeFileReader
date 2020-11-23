//
//  RoundTripSlideRecord.swift
//  
//
//  Created by Hugh Bellamy on 23/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.2 RoundTripSlideRecord
/// Referenced by: SlideContainer
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified in the following table.
public enum RoundTripSlideRecord {
    /// RT_RoundTripTheme12Atom A RoundTripThemeAtom record that specifies round-trip information. It SHOULD<35> be ignored and
    /// SHOULD<36> be preserved.
    case roundTripTheme12Atom(data: RoundTripThemeAtom)
    
    /// RT_RoundTripColorMapping12Atom A RoundTripColorMappingAtom record that specifies round-trip information. It SHOULD<37> be ignored
    /// and SHOULD<38> be preserved.
    case roundTripColorMapping12Atom(data: RoundTripColorMappingAtom)
    
    /// RT_RoundTripCompositeMasterId12Atom A RoundTripCompositeMasterId12Atom record that specifies roundtrip information. It SHOULD<39>
    /// be ignored and SHOULD<40> be preserved.
    case roundTripCompositeMasterId12Atom(data: RoundTripCompositeMasterId12Atom)
    
    /// RT_RoundTripSlideSyncInfo12 A RoundTripSlideSyncInfo12Container record that specifies roundtrip information. It SHOULD<41> be ignored
    /// and SHOULD<42> be preserved.
    case roundTripSlideSyncInfo12(data: RoundTripSlideSyncInfo12Container)
    
    /// RT_RoundTripAnimationHashAtom12Atom A RoundTripAnimationHashAtom record that specifies round-trip information. It SHOULD<43> be
    /// ignored and SHOULD<44> be preserved.
    case roundTripAnimationHashAtom12Atom(data: RoundTripAnimationHashAtom)
    
    /// RT_RoundTripAnimationAtom12Atom A RoundTripAnimationAtom record that specifies round-trip information. It SHOULD<45> be ignored and
    /// SHOULD<46> be preserved.
    case roundTripAnimationAtom12Atom(data: RoundTripAnimationAtom)
    
    /// RT_RoundTripContentMasterId12Atom A RoundTripContentMasterId12Atom record that specifies round-trip information. It SHOULD<47> be
    /// ignored and SHOULD<48> be preserved.
    case roundTripContentMasterId12Atom(data: RoundTripContentMasterId12Atom)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .roundTripTheme12Atom:
            self = .roundTripTheme12Atom(data: try RoundTripThemeAtom(dataStream: &dataStream))
        case .roundTripColorMapping12Atom:
            self = .roundTripColorMapping12Atom(data: try RoundTripColorMappingAtom(dataStream: &dataStream))
        case .roundTripCompositeMasterId12Atom:
            self = .roundTripCompositeMasterId12Atom(data: try RoundTripCompositeMasterId12Atom(dataStream: &dataStream))
        case .roundTripSlideSyncInfo12:
            self = .roundTripSlideSyncInfo12(data: try RoundTripSlideSyncInfo12Container(dataStream: &dataStream))
        case .roundTripAnimationHashAtom12Atom:
            self = .roundTripAnimationHashAtom12Atom(data: try RoundTripAnimationHashAtom(dataStream: &dataStream))
        case .roundTripAnimationAtom12Atom:
            self = .roundTripAnimationAtom12Atom(data: try RoundTripAnimationAtom(dataStream: &dataStream))
        case .roundTripContentMasterId12Atom:
            self = .roundTripContentMasterId12Atom(data: try RoundTripContentMasterId12Atom(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
