//
//  VisualShapeAtom.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.49 VisualShapeAtom
/// Referenced by: VisualShapeOrSoundAtom
/// A variable type record whose type and meaning are dictated by the value of type, as specified in the following table.
public enum VisualShapeAtom {
    /// TL_TVET_ChartElement A VisualShapeChartElementAtom record that specifies the embedded chart shape for an animation target.
    case chartElement(data: VisualShapeChartElementAtom)
    
    /// All other values A VisualShapeGeneralAtom record that specifies the shape for an animation target. The shape MUST NOT be an embedded chart.
    case other(data: VisualShapeGeneralAtom)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recType == .visualShapeAtom else {
            throw OfficeFileError.corrupted
        }
        
        /// type (4 bytes): A TimeVisualElementEnum enumeration that specifies the target element type for the shape that the animation is applied to.
        guard let type = TimeVisualElementEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = position
        
        switch type {
        case .chartElement:
            self = .chartElement(data: try VisualShapeChartElementAtom(dataStream: &dataStream))
        default:
            self = .other(data: try VisualShapeGeneralAtom(dataStream: &dataStream))
        }
    }
}
