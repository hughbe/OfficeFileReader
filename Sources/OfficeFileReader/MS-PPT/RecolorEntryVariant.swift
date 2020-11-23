//
//  RecolorEntryVariant.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.11 RecolorEntryVariant
/// Referenced by: RecolorEntry
/// A variant structure whose type and meaning are dictated by the value of the type field of either of these two structures, as specified in the following table.
public enum RecolorEntryVariant {
    /// 0x0000 A RecolorEntryColor structure that specifies a source color.
    case color(data: RecolorEntryColor)
    
    /// 0x0001 A RecolorEntryBrush structure that specifies a source brush.
    case brush(data: RecolorEntryBrush)
    
    public init(dataStream: inout DataStream) throws {
        let type: UInt16 = try dataStream.peek(endianess: .littleEndian)
        if type == 0x0000 {
            self = .color(data: try RecolorEntryColor(dataStream: &dataStream))
        } else if type == 0x0001 {
            self = .brush(data: try RecolorEntryBrush(dataStream: &dataStream))
        } else {
            throw OfficeFileError.corrupted
        }
    }
}
