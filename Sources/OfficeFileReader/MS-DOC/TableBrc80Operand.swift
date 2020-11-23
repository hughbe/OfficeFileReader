//
//  TableBrc80Operand.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.304 TableBrc80Operand
/// The TableBrc80Operand structure is an operand that specifies borders for a range of cells in a table row.
public struct TableBrc80Operand {
    public let cb: UInt8
    public let itc: ItcFirstLim
    public let bordersToApply: BordersToApply
    public let brc: Brc80MayBeNil
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size, in bytes, of the remainder of this structure. The value MUST be 7.
        self.cb = try dataStream.read()
        if self.cb != 7 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// itc (2 bytes): An ItcFirstLim structure that specifies the range of cell columns to apply the border type format.
        self.itc = try ItcFirstLim(dataStream: &dataStream)
        
        /// bordersToApply (1 byte): An unsigned integer that specifies which borders are affected. The value MUST be the result of the bitwise OR of any
        /// subset of the following values that specifies an edge to be formatted:
        self.bordersToApply = BordersToApply(rawValue: try dataStream.read())
        
        /// brc (4 bytes): A Brc80MayBeNil structure that specifies the border type that is applied to the edges which are indicated by bordersToApply.
        self.brc = try Brc80MayBeNil(dataStream: &dataStream)
        
        if dataStream.position - startPosition < self.cb {
            throw OfficeFileError.corrupted
        }
    }
    
    /// bordersToApply (1 byte): An unsigned integer that specifies which borders are affected. The value MUST be the result of the bitwise OR of any
    /// subset of the following values that specifies an edge to be formatted:
    public struct BordersToApply: OptionSet {
        public let rawValue: UInt8
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
        
        /// 0x01: Top border.
        public static let top = BordersToApply(rawValue: 0x01)
        
        /// 0x02: Logical left border.
        public static let logicalLeft = BordersToApply(rawValue: 0x02)
        
        /// 0x04: Bottom border.
        public static let bottom = BordersToApply(rawValue: 0x04)
        
        /// 0x08: Logical right border.
        public static let logicalRight = BordersToApply(rawValue: 0x08)
        
        public static let all: BordersToApply = [.top, .logicalLeft, .bottom, .logicalRight]
    }
}
