//
//  FtsWWidth_Indent.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.102 FtsWWidth_Indent
/// The FtsWWidth_Indent structure specifies the preferred width of indentation for a table.
public struct FtsWWidth_Indent {
    public let ftsWidth: Fts
    public let wWidth: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// ftsWidth (1 byte): A value from the Fts enumeration that specifies the units of measurement for the wWidth value. ftsWidth MUST
        /// NOT be ftsPercent. ftsWidth MUST NOT be ftsDxaSys.
        let ftsWidthRaw: UInt8 = try dataStream.read()
        guard let ftsWidth = Fts(rawValue: ftsWidthRaw) else {
            throw OfficeFileError.corrupted
        }
        guard ftsWidth != .dxaSys && ftsWidth != .percent else {
            throw OfficeFileError.corrupted
        }
        
        self.ftsWidth = ftsWidth
        
        /// wWidth (2 bytes): An integer that specifies the preferred size of the indent. The size is evaluated differently depending on the value of ftsWidth.
        /// ftsWidth value wWidth meaning
        /// ftsNil wWidth is not used and MUST be zero.
        /// ftsAuto wWidth is not used and MUST be zero.
        /// ftsPercent This value of ftsWidth is not allowed.
        /// ftsDxa wWidth is measured in twips. It MUST be greater than or equal to -31,560 (-21 11/12 inches). It MUST be less than or equal to 31,680
        /// (22 inches), less the width of the table. That is, the logical right edge of the table, calculated as the sum of this indentation and the width of the
        /// table (or the sum of the widths of the cells), MUST be less than or equal to 31,680 (22 inches).
        let wWidth: Int16 = try dataStream.read(endianess: .littleEndian)
        if ftsWidth == .nil && wWidth != 0 {
            throw OfficeFileError.corrupted
        } else if ftsWidth == .auto && wWidth == 0 {
            throw OfficeFileError.corrupted
        } else if ftsWidth == .dxa && (wWidth < -31560 || wWidth > 31680) {
            throw OfficeFileError.corrupted
        }
        
        self.wWidth = wWidth
    }
}
