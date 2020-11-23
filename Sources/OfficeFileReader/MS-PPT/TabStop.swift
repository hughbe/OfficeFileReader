//
//  TabStop.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.24 TabStop
/// Referenced by: TabStops
/// A structure that specifies a tab stop.
public struct TabStop {
    public let position: Int16
    public let type: TextTabTypeEnum
    
    public init(dataStream: inout DataStream) throws {
        /// position (2 bytes): A signed integer that specifies an offset, in master units, of the tab stop.
        /// If the TextPFException record that contains this TabStop structure also contains a leftMargin, then the value of position is relative to the left margin
        /// of the paragraph; otherwise, the value is relative to the left side of the paragraph.
        /// If a TextRuler record contains this TabStop structure, the value is relative to the left side of the text ruler.
        self.position = try dataStream.read(endianess: .littleEndian)
        
        /// type (2 bytes): A TextTabTypeEnum enumeration that specifies how text aligns at the tab stop.
        let typeRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let type = TextTabTypeEnum(rawValue: typeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.type = type
    }
}
