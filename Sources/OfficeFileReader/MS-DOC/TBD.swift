//
//  TBD.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.310 TBD
/// A TBD structure specifies the alignment type and the leader type for a custom tab stop.
public struct TBD {
    public let jc: TabJC
    public let lc: TabLC
    public let unused: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// jc (3 bits): A TabJC value that specifies the alignment (justification) type for the current custom tab stop.
        let jcRaw = flags.readBits(count: 3)
        guard let jc = TabJC(rawValue: jcRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.jc = jc
        
        /// lc (3 bits): A TabLC value that specifies the leader type for the current custom tab stop. The value MUST be ignored if jc is equal
        /// to 0x4 (jcBar).
        let lcRaw = flags.readBits(count: 3)
        guard let lc = TabLC(rawValue: lcRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.lc = lc
        
        /// A - UNUSED (2 bits): This field MUST be ignored.
        self.unused = flags.readRemainingBits()
    }
}
