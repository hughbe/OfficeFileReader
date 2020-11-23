//
//  PChgTabsDelClose.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.181 PChgTabsDelClose
/// The PChgTabsDelClose structure specifies the locations at which custom tab stops are ignored.
public struct PChgTabsDelClose {
    public let cTabs: UInt8
    public let rgdxaDel: [UInt16]
    public let rgdxaClose: [XAS_plusOne]
    
    public init(dataStream: inout DataStream) throws {
        /// cTabs (1 byte): An unsigned integer that specifies the number of records in rgdxaDel and rgdxaClose. This value MUST be less than or equal to 64.
        self.cTabs = try dataStream.read()
        if self.cTabs > 64 {
            throw OfficeFileError.corrupted
        }
        
        /// rgdxaDel (variable): An array of 16-bit integers. The number of records is specified by cTabs. The integers contained in the array MUST be in
        /// ascending order. Each integer SHOULD<231> be greater than or equal to -31680. Each integer MUST be less than or equal to 31680.
        /// Each integer specifies a location at which to ignore any custom tab stop within 25 twips.
        var rgdxaDel: [UInt16] = []
        rgdxaDel.reserveCapacity(Int(self.cTabs))
        for _ in 0..<self.cTabs {
            rgdxaDel.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.rgdxaDel = rgdxaDel
        
        /// rgdxaClose (variable): An array of XAS_plusOne. The number of records is specified by cTabs. Each entry in rgdxaClose specifies a distance,
        /// in twips in both directions, from the corresponding entry in rgdxaDel. All tab stops inside this range are deleted. Any entry in rgdxaClose that has a
        /// value of less than 0x0019 is treated as though the value was 0x0019.
        var rgdxaClose: [XAS_plusOne] = []
        rgdxaClose.reserveCapacity(Int(self.cTabs))
        for _ in 0..<self.cTabs {
            rgdxaClose.append(try XAS_plusOne(dataStream: &dataStream))
        }
        
        self.rgdxaClose = rgdxaClose
    }
}
