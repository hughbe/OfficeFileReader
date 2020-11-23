//
//  TCellBrcTypeOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.314 TCellBrcTypeOperand
/// A TCellBrcTypeOperand structure specifies an array of border types for table cells.
public struct TCellBrcTypeOperand {
    public let cb: UInt8
    public let rgBrcType: [(top: BrcType, left: BrcType, bottom: BrcType, right: BrcType)]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): cb (1 byte): An unsigned integer that specifies the size, in bytes, of rgBrcType. This value MUST be evenly divisible by four.
        self.cb = try dataStream.read(endianess: .littleEndian)
        if (self.cb % 4) != 0 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgBrcType (variable): An array of BrcType that specifies border types for a set of table cells. Each cell corresponds to four bytes. Every
        /// four bytes specify the border types of the top, left, bottom and right borders, in that order.
        var rgBrcType: [(top: BrcType, left: BrcType, bottom: BrcType, right: BrcType)] = []
        let count = self.cb / 4
        rgBrcType.reserveCapacity(Int(count))
        for _ in 0..<count {
            func getBrcType() throws -> BrcType {
                let brcTypeRaw: UInt8 = try dataStream.read()
                guard let brcType = BrcType(rawValue: brcTypeRaw) else {
                    throw OfficeFileError.corrupted
                }
             
                return brcType
            }

            rgBrcType.append((top: try getBrcType(), left: try getBrcType(), bottom: try getBrcType(), right: try getBrcType()))
        }
        
        self.rgBrcType = rgBrcType
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
