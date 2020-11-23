//
//  TimeAnimateColor.swift
//
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.58 TimeAnimateColor
/// Referenced by: TimeColorBehaviorAtom
/// A variable type structure whose type and meaning are dictated by the value of the model field within these two structures, as specified by the
/// following table.
public enum TimeAnimateColor {
    /// 0x00000000 An RGBColor structure that specifies an RGB color.
    case rgbColor(data: RGBColor)
    
    /// 0x00000002 An IndexSchemeColor structure that specifies a color scheme color.
    case indexSchemeColor(data: IndexSchemeColor)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peek(endianess: .littleEndian) as UInt32 {
        case 0x00000000:
            self = .rgbColor(data: try RGBColor(dataStream: &dataStream))
        case 0x00000002:
            self = .indexSchemeColor(data: try IndexSchemeColor(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
