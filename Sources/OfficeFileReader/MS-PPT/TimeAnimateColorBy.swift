//
//  TimeAnimateColorBy.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.55 TimeAnimateColorBy
/// Referenced by: TimeColorBehaviorAtom
/// A variable type structure whose type and meaning are dictated by the value of the model field within these three structures, as specified by the
/// following table.
public enum TimeAnimateColorBy {
    /// 0x00000000 An RGBColorBy structure that specifies an RGB color offset.
    case rgbColorBy(data: RGBColorBy)
    
    /// 0x00000001 An HSLColorBy structure that specifies an HSL color offset.
    case hslColorBy(data: HSLColorBy)
    
    /// 0x00000002 An IndexSchemeColor structure that specifies a color scheme color.
    case indexSchemeColor(data: IndexSchemeColor)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peek(endianess: .littleEndian) as UInt32 {
        case 0x00000000:
            self = .rgbColorBy(data: try RGBColorBy(dataStream: &dataStream))
        case 0x00000001:
            self = .hslColorBy(data: try HSLColorBy(dataStream: &dataStream))
        case 0x00000002:
            self = .indexSchemeColor(data: try IndexSchemeColor(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
