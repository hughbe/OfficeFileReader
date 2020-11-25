//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.3 Module Stream: Visual Basic Modules
/// Specifies the source code for a module.
public struct ModuleStream {
    public let performanceCache: [UInt8]
    public let compressedSourceCode: [UInt8]
    
    public init(dataStream: inout DataStream, offset: Int, count: Int) throws {
        guard offset <= count else {
            throw OfficeFileError.corrupted
        }
        
        /// PerformanceCache (variable): An array of bytes that forms an implementation-specific and version-dependent performance cache for the
        /// module. MUST be MODULEOFFSET (section 2.3.4.2.3.2.5) bytes in size. MUST be ignored on read.
        self.performanceCache = try dataStream.readBytes(count: offset)
        
        /// CompressedSourceCode (variable): An array of bytes compressed as specified in Compression (section 2.4.1). When decompressed
        /// yields an array of bytes that specifies the textual representation of VBA language source code as specified in [MS-VBAL] section 4.2.
        /// MUST contain MBCS characters encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4).
        self.compressedSourceCode = try dataStream.readBytes(count: count - offset)
    }
}
