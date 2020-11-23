//
//  FtsWWidth_Table.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.103 FtsWWidth_Table
/// The FtsWWidth_Table structure specifies the preferred horizontal width of a table.
public struct FtsWWidth_Table {
    public let ftsWidth: Fts
    public let wWidth: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// ftsWidth (1 byte): A value from the Fts enumeration that specifies the units of measurement for the wWidth value.
        /// The ftsWidth value MUST NOT be ftsDxaSys.
        let ftsWidthRaw: UInt8 = try dataStream.read()
        guard let ftsWidth = Fts(rawValue: ftsWidthRaw) else {
            throw OfficeFileError.corrupted
        }
        guard ftsWidth != .dxaSys else {
            throw OfficeFileError.corrupted
        }
        
        self.ftsWidth = ftsWidth
        
        /// wWidth (2 bytes): An integer that specifies the preferred width. The size is evaluated differently depending on the value of ftsWidth.
        /// ftsWidth value wWidth meaning
        /// ftsNil wWidth is not used and MUST be zero.
        /// ftsAuto wWidth is not used and MUST be zero.
        /// ftsPercent wWidth MUST be non-negative and MUST be less than or equal to 30,000 (600%).
        /// ftsDxa wWidth MUST be non-negative and MUST be less than or equal to 31,680 (22 inches).
        let wWidth: Int16 = try dataStream.read(endianess: .littleEndian)
        if ftsWidth == .nil && wWidth != 0 {
            throw OfficeFileError.corrupted
        } else if ftsWidth == .auto && wWidth == 0 {
            throw OfficeFileError.corrupted
        } else if ftsWidth == .percent && (wWidth < 0 || wWidth > 30000) {
            throw OfficeFileError.corrupted
        } else if ftsWidth == .dxa && (wWidth < 0 || wWidth > 31680) {
            throw OfficeFileError.corrupted
        }
        
        self.wWidth = wWidth
    }
}
