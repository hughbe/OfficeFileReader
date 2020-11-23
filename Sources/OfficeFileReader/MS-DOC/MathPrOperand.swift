//
//  MathPrOperand.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

public struct MathPrOperand {
    public let cb: UInt8
    public let jcMath: DopMth.MathJustification
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): The size of this structure, in bytes, not including this byte. This value MUST be 0x02.
        self.cb = try dataStream.read()
        if self.cb != 0x02 {
            throw OfficeFileError.corrupted
        }
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - jcMath (3 bits): Specifies the justification. The valid values and their meanings are specified in the mthbpjc member of DOPMTH.
        let jcMathRaw = UInt8(flags.readBits(count: 3))
        guard let jcMath = DopMth.MathJustification(rawValue: jcMathRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.jcMath = jcMath
        
        /// unused (13 bits): This field is undefined and MUST be ignored.
        self.unused = flags.readRemainingBits()
    }
}
