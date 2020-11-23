//
//  LEGOXTR_V11.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.130 LEGOXTR_V11
/// The LEGOXTR_V11 structure contains information about an AutoText item.
public struct LEGOXTR_V11 {
    public let flego: AutoTextType
    public let unused1: UInt8
    public let ibst: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// flego (1 byte): An unsigned integer that specifies the type of an AutoText item. This MUST be one of the following values.
        let flegoRaw: UInt8 = try dataStream.read()
        guard let flego = AutoTextType(rawValue: flegoRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.flego = flego
        
        /// unused1 (1 byte): This field MUST be ignored.
        self.unused1 = try dataStream.read()
        
        /// ibst (2 bytes): A signed integer that specifies a zero-based index into SttbGlsyStyle. The string at this index is the name of the style that is
        /// used by the AutoText item. If this integer is equal to 0xFFFF, there is no style used by the AutoText item. If flego is nonzero, this MUST be
        /// equal to 0xFFFF.
        self.ibst = try dataStream.read(endianess: .littleEndian)
    }
    
    public enum AutoTextType: UInt8 {
        /// 0x00 The item is a named AutoText item.
        case named = 0x00
        
        /// 0x0A The item is a formatted text AutoCorrect item.
        case formattedText = 0x0A
    }
}
