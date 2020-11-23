//
//  SPgbPropOperand.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.255 SPgbPropOperand
/// The SPgbPropOperand structure is the operand to sprmSPgbProp. It specifies the properties of a page border.
public struct SPgbPropOperand {
    public let pgbApplyTo: PgbApplyTo
    public let pgbPageDepth: PgbPageDepth
    public let pgbOffsetFrom: PgbOffsetFrom
    public let reserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - pgbApplyTo (3 bits): A value from the PgbApplyTo enumeration that specifies to what pages the border applies.
        let pgbApplyToRaw = flags.readBits(count: 3)
        guard let pgbApplyTo = PgbApplyTo(rawValue: pgbApplyToRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.pgbApplyTo = pgbApplyTo
        
        /// B - pgbPageDepth (2 bits): A value from the PgbPageDepth enumeration controlling the "depth" of the border—for example, whether it is above
        /// or below other page elements.
        let pgbPageDepthRaw = flags.readBits(count: 2)
        guard let pgbPageDepth = PgbPageDepth(rawValue: pgbPageDepthRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.pgbPageDepth = pgbPageDepth
        
        /// C - pgbOffsetFrom (3 bits): A value from the PgbOffsetFrom enumeration that specifies from where the offset of the border is measured.
        let pgbOffsetFromRaw = flags.readBits(count: 3)
        guard let pgbOffsetFrom = PgbOffsetFrom(rawValue: pgbOffsetFromRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.pgbOffsetFrom = pgbOffsetFrom
        
        /// reserved (1 byte): This value MUST be zero.
        self.reserved = try dataStream.read()
    }
}
