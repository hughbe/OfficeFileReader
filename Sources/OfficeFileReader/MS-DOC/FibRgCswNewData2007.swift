//
//  FibRgCswNewData2007.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.13 FibRgCswNewData2007
/// The FibRgCswNewData2007 structure is a variable-sized portion of the Fib. It extends the FibRgCswNewData2000.
public struct FibRgCswNewData2007 {
    public let rgCswNewData2000: FibRgCswNewData2000
    public let lidThemeOther: UInt16
    public let lidThemeFE: UInt16
    public let lidThemeCS: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rgCswNewData2000 (2 bytes): The contained FibRgCswNewData2000.
        self.rgCswNewData2000 = try FibRgCswNewData2000(dataStream: &dataStream)
        
        /// lidThemeOther (2 bytes): This value is undefined and MUST be ignored.
        self.lidThemeOther = try dataStream.read(endianess: .littleEndian)
        
        /// lidThemeFE (2 bytes): This value is undefined and MUST be ignored.
        self.lidThemeFE = try dataStream.read(endianess: .littleEndian)
        
        /// lidThemeCS (2 bytes): This value is undefined and MUST be ignored.
        self.lidThemeCS = try dataStream.read(endianess: .littleEndian)
    }
}
