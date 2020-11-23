//
//  Pcd.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.177 Pcd
/// The Pcd structure specifies the location of text in the WordDocument Stream and additional properties for this text. A Pcd structure is an
/// element of a PlcPcd structure.
public struct Pcd {
    public let fNoParaLast: Bool
    public let fR1: Bool
    public let fDirty: Bool
    public let fR2: UInt16
    public let fc: FcCompressed
    public let prm: Prm
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fNoParaLast (1 bit): If this bit is 1, the text MUST NOT contain a paragraph mark.
        self.fNoParaLast = flags.readBit()
        
        /// B - fR1 (1 bit): This field is undefined and MUST be ignored.
        self.fR1 = flags.readBit()
        
        /// C - fDirty (1 bit): This field MUST be 0.
        self.fDirty = flags.readBit()
        
        /// fR2 (13 bits): This field is undefined and MUST be ignored.
        self.fR2 = flags.readBits(count: 13)
        
        /// fc (4 bytes): An FcCompressed structure that specifies the location of the text in the WordDocument Stream.
        self.fc = try FcCompressed(dataStream: &dataStream)
        
        /// prm (2 bytes): A Prm structure that specifies additional properties for this text. These properties are used as part of the algorithms
        /// in sections 2.4.6.1 (Direct Paragraph Formatting) and 2.4.6.2 (Direct Character Formatting).
        self.prm = try Prm(dataStream: &dataStream)
    }
}
