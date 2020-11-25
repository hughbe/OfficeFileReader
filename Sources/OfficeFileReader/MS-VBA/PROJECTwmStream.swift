//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.3 PROJECTwm Stream: Module Name Information
/// Specifies a map from MBCS module names to Unicode module names.
public struct PROJECTwmStream {
    public let nameMap: [NAMEMAP]
    public let terminator: UInt16
    
    public init(dataStream: inout DataStream, count: Int) throws {
        guard count >= 2 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// NameMap (variable): An array of NAMEMAP Record (section 2.3.3.1). The length of NameMap MUST be two bytes less than the size
        /// of the PROJECTwm Stream (section 2.2.8). Array items MUST appear in the same order as they appear in the PROJECTMODULES
        /// Record (section 2.3.4.2.3).
        var nameMap: [NAMEMAP] = []
        while dataStream.position - startPosition < count - 2 {
            nameMap.append(try NAMEMAP(dataStream: &dataStream))
        }
        
        self.nameMap = nameMap
        
        /// Terminator (2 bytes): An unsigned integer that specifies the end of the stream. MUST be 0x0000.
        self.terminator = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == count else {
            throw OfficeFileError.corrupted
        }
    }
}
