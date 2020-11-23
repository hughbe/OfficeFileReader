//
//  FibRgCswNew.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.11 FibRgCswNew
/// The FibRgCswNew structure is an extension to the Fib structure that exists only if Fib.cswNew is nonzero.
public struct FibRgCswNew {
    public let nFibNew: UInt16
    public let fibRgCswNewData2000: FibRgCswNewData2000
    public let fibRgCswNewData2007: FibRgCswNewData2007?
    private let rgCswNewData: Any
    
    public init(dataStream: inout DataStream) throws {
        /// nFibNew (2 bytes): An unsigned integer that specifies the version number of the file format that is used. This value MUST be one
        /// of the following.
        /// Value
        /// 0x00D9
        /// 0x0101
        /// 0x010C
        /// 0x0112
        let nFibNew: UInt16 = try dataStream.read(endianess: .littleEndian)
        if nFibNew != 0x00D9 &&
            nFibNew != 0x0101 &&
            nFibNew != 0x010C &&
            nFibNew != 0x0112 {
            throw OfficeFileError.corrupted
        }
        
        self.nFibNew = nFibNew
        
        /// rgCswNewData (variable): Depending on the value of nFibNew this is one of the following.
        /// Value of nFibNew Meaning
        /// 0x00D9 fibRgCswNewData2000 (2 bytes)
        /// 0x0101 fibRgCswNewData2000 (2 bytes)
        /// 0x010C fibRgCswNewData2000 (2 bytes)
        /// 0x0112 fibRgCswNewData2007 (8 bytes)
        switch self.nFibNew {
        case 0x00D9, 0x0101, 0x010C:
            let rgCswNewData = try FibRgCswNewData2000(dataStream: &dataStream)
            self.fibRgCswNewData2000 = rgCswNewData
            self.fibRgCswNewData2007 = nil
            self.rgCswNewData = rgCswNewData
        case 0x0112:
            let rgCswNewData = try FibRgCswNewData2007(dataStream: &dataStream)
            self.fibRgCswNewData2000 = rgCswNewData.rgCswNewData2000
            self.fibRgCswNewData2007 = rgCswNewData
            self.rgCswNewData = rgCswNewData
        default:
            throw OfficeFileError.corrupted
        }
    }
}
