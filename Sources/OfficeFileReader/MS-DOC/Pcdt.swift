//
//  Pcdt.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.178 Pcdt
/// The Pcdt structure contains a PlcPcd structure and specifies its size.
public struct Pcdt {
    public let clxt: UInt8
    public let lcb: UInt32
    public let plcPcd: PlcPcd
    
    public init(dataStream: inout DataStream, fibRgLw97: FibRgLw97) throws {
        /// clxt (1 byte): This value MUST be 0x02.
        self.clxt = try dataStream.read()
        if self.clxt != 0x02 {
            throw OfficeFileError.corrupted
        }
        
        /// lcb (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcPcd structure.
        self.lcb = try dataStream.read(endianess: .littleEndian)
        
        /// PlcPcd (variable): A PlcPcd structure. As with all Plc elements, the size that is specified by lcb MUST result in a whole number of
        /// Pcd structures in this PlcPcd structure.
        let startPosition = dataStream.position
        self.plcPcd = try PlcPcd(dataStream: &dataStream, fibRgLw97: fibRgLw97, size: self.lcb)
        
        if dataStream.position - startPosition != self.lcb {
            throw OfficeFileError.corrupted
        }
    }
}
