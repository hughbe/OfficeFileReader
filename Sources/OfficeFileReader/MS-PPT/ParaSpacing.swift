//
//  ParaSpacing.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.20 ParaSpacing
/// Referenced by: TextPFException
/// A 2-byte signed integer that specifies text paragraph spacing. It MUST be a value from the following table:
public enum ParaSpacing {
    /// 0 to 13200, inclusive. The value specifies spacing as a percentage of the text line height.
    case percentage(value: Int16)
    
    /// Less than 0. The absolute value specifies spacing in master units.
    case masterUnits(value: Int16)
    
    public init(dataStream: inout DataStream) throws {
        let value: Int16 = try dataStream.read(endianess: .littleEndian)
        switch value {
        case let value where value >= 0 && value <= 13200:
            self = .percentage(value: value)
        case let value where value < 0:
            self = .masterUnits(value: value)
        default:
            throw OfficeFileError.corrupted
        }
    }
}
