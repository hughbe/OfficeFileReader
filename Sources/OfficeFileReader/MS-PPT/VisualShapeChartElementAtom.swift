//
//  VisualShapeChartElementAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.50 VisualShapeChartElementAtom
/// Referenced by: VisualShapeAtom
/// An atom record that specifies an embedded chart or its sub-elements to animate.
public struct VisualShapeChartElementAtom {
    public let rh: RecordHeader
    public let type: TimeVisualElementEnum
    public let refType: ElementTypeEnum
    public let shapeIdRef: UInt32
    public let data1: ChartBuildType
    public let data2: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_VisualShapeAtom.
        /// rh.recLen MUST be 0x00000014.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .visualShapeAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000014 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// type (4 bytes): A TimeVisualElementEnum enumeration that specifies the target element type for the shape that the animation is applied to.
        /// It MUST NOT be TL_TVET_ChartElement.
        guard let type = TimeVisualElementEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        guard type != .chartElement else {
            throw OfficeFileError.corrupted
        }
        
        self.type = type
        
        /// refType (4 bytes): An ElementTypeEnum enumeration that specifies the target element type of the animation. It MUST be TL_ET_ShapeType.
        guard let refType = ElementTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        guard refType == .shape else {
            throw OfficeFileError.corrupted
        }
        
        self.refType = refType
        
        /// shapeIdRef (4 bytes): An unsigned integer that specifies the target shape on the slide to animate.
        self.shapeIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// data1 (4 bytes): An unsigned integer that specifies how the chart is built during its animation. It MUST be a value from the following table.
        guard let data1 = ChartBuildType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.data1 = data1
        
        /// data2 (4 bytes): A signed integer that specifies a chart element to animate. It MUST be greater than or equal to 0xFFFFFFFF (-1). The value
        /// 0xFFFFFFFF specifies that this record is invalid and SHOULD be ignored. The value 0x00000000 specifies the chart background. Values
        /// greater than 0x0000000 specify a one-based index in the list of chart elements specified by data1.
        self.data2 = try dataStream.read(endianess: .littleEndian)
        guard self.data2 >= -1 else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// data1 (4 bytes): An unsigned integer that specifies how the chart is built during its animation. It MUST be a value from the following table.
    public enum ChartBuildType: UInt32 {
        /// 0x00000000 The entire chart.
        case entireChart = 0x00000000
        
        /// 0x00000001 By series.
        case bySeries = 0x00000001
        
        /// 0x00000002 By category.
        case byCategory = 0x00000002
        
        /// 0x00000003 By series element.
        case bySeriesElement = 0x00000003
        
        /// 0x00000004 By category element.
        case byCategoryElement = 0x00000004
        
        /// 0x00000005 Custom chart element.
        case customChartElement = 0x00000005
    }
}
