//
//  ShapeClientRoundtripDataSubContainerOrAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.4 ShapeClientRoundtripDataSubContainerOrAtom
/// Referenced by: OfficeArtClientData
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified by the following table.
public enum ShapeClientRoundtripDataSubContainerOrAtom {
    /// RT_ProgTags (section 2.13.24) A ShapeProgTagsContainer record that specifies programmable tags for the shape.
    case progTags(data: ShapeProgTagsContainer)
    
    /// RT_RoundTripNewPlaceholderId12Atom A RoundTripNewPlaceholderId12Atom record that specifies a placeholder shape identifier. It SHOULD<88>
    /// be ignored and SHOULD<89> be preserved.
    case roundTripNewPlaceholderId12Atom(data: RoundTripNewPlaceholderId12Atom)
    
    /// RT_RoundTripShapeId12Atom A RoundTripShapeId12Atom record that specifies a shape identifier. It SHOULD<90> be ignored and SHOULD<91>
    /// be preserved.
    case roundTripShapeId12Atom(data: RoundTripShapeId12Atom)
    
    /// RT_RoundTripHFPlaceholder12Atom A RoundTripHFPlaceholder12Atom record that specifies whether a shape is a header or footer placeholder shape.
    /// It SHOULD<92> be ignored and SHOULD<93> be preserved.
    case roundTripHFPlaceholder12Atom(data: RoundTripHFPlaceholder12Atom)
    
    /// RT_RoundTripShapeCheckSumForCL12Atom A RoundTripShapeCheckSumForCustomLayouts12Atom record that specifies checksum values for a
    /// shape. It SHOULD<94> be ignored and SHOULD<95> be preserved.
    case roundTripShapeCheckSumForCL12Atom(data: RoundTripShapeCheckSumForCustomLayouts12Atom)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rh: RecordHeader = try RecordHeader(dataStream: &dataStream)
        dataStream.position = position
        
        switch rh.recType {
        case .progTags:
            self = .progTags(data: try ShapeProgTagsContainer(dataStream: &dataStream))
        case .roundTripNewPlaceholderId12Atom:
            self = .roundTripNewPlaceholderId12Atom(data: try RoundTripNewPlaceholderId12Atom(dataStream: &dataStream))
        case .roundTripShapeId12Atom:
            self = .roundTripShapeId12Atom(data: try RoundTripShapeId12Atom(dataStream: &dataStream))
        case .roundTripHFPlaceholder12Atom:
            self = .roundTripHFPlaceholder12Atom(data: try RoundTripHFPlaceholder12Atom(dataStream: &dataStream))
        case .roundTripShapeCheckSumForCL12Atom:
            self = .roundTripShapeCheckSumForCL12Atom(data: try RoundTripShapeCheckSumForCustomLayouts12Atom(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
