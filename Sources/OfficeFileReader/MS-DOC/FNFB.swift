//
//  FNFB.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.91 FNFB
/// The FNFB structure describes the file systems for which a given path is valid.
public struct FNFB {
    public let fFAT: Bool
    public let unused1: Bool
    public let unused2: Bool
    public let fNTFS: Bool
    public let fNonFileSys: Bool
    public let unused3: UInt8
    public let unused4: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)

        /// A - fFAT (1 bit): A bit that specifies whether the path is valid on FAT file systems. If fNonFileSys is nonzero, this value MUST be zero.
        self.fFAT = flags.readBit()
        
        /// B - unused1 (1 bit): This bit is undefined and MUST be ignored.
        self.unused1 = flags.readBit()
        
        /// C - unused2 (1 bit): This bit is undefined and MUST be ignored.
        self.unused2 = flags.readBit()
        
        /// D - fNTFS (1 bit): A bit that specifies whether the path is valid on NTFS file systems. If fNonFileSys is nonzero, this MUST be zero.
        self.fNTFS = flags.readBit()
        
        /// E - fNonFileSys (1 bit): A bit that specifies whether the path is not a native file system path. If this value is nonzero, the path is not a
        /// native file system path, and therefore requires an external file I/O protocol. If this value is zero, the path is native and can be used by
        /// the native Windows file I/O API.
        self.fNonFileSys = flags.readBit()
        
        /// F - unused3 (2 bits): This field is undefined and MUST be ignored.
        self.unused3 = flags.readBits(count: 2)
        
        /// G - unused4 (1 bit): This field is undefined and MUST be ignored.
        self.unused4 = flags.readBit()
    }
}
