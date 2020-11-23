//
//  Fssd.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.98 Fssd
/// The Fssd structure specifies the position and units of a frame divider position.
public struct Fssd {
    public let units: FssUnits
    public let val: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// Units (4 bytes): An FssUnits element that specifies how to interpret Val.
        let unitsRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let units = FssUnits(rawValue: unitsRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.units = units
        
        /// Val (4 bytes): The position of the divider. This value can be interpreted in several ways, as specified by Units. If Units is set to
        /// iFssUnitsNil, this value MUST be ignored.
        self.val = try dataStream.read(endianess: .littleEndian)
    }
}
