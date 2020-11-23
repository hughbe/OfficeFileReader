//
//  TextMasterStyleLevel.swift
//  
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.36 TextMasterStyleLevel
/// Referenced by: TextMasterStyleAtom
/// A structure that specifies character-level and paragraph-level formatting for a style level.
public struct TextMasterStyleLevel {
    public let level: UInt16?
    public let pf: TextPFException?
    public let cf: TextCFException?
    
    public init(dataStream: inout DataStream, textType: TextTypeEnum) throws {
        /// level (2 bytes): An optional unsigned integer that specifies to what style level this TextMasterStyleLevel applies. This field MUST exist if and
        /// only if the rh.recInstance field of the TextMasterStyleAtom record that contains this TextMasterStyleLevel structure is greater than or equal
        /// to 0x005. If the field exists, its value MUST be less than the cLevels field of the TextMasterStyleAtom record that contains this
        /// TextMasterStyleLevel structure.
        if textType == .centerBody || textType == .centerTitle || textType == .halfBody || textType == .quarterBody {
            self.level = try dataStream.read(endianess: .littleEndian)
        } else {
            self.level = nil
        }
        
        /// pf (variable): A TextPFException structure that specifies paragraph-level formatting.
        self.pf = try TextPFException(dataStream: &dataStream)
        
        /// cf (variable): A TextCFException structure that specifies character-level formatting.
        self.cf = try TextCFException(dataStream: &dataStream)
    }
}
