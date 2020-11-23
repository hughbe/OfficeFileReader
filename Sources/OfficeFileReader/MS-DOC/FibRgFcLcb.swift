//
//  FibRgFcLcb.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.5 FibRgFcLcb
/// The FibRgFcLcb structure specifies the file offsets and byte counts for various portions of the data in the document. The structure of
/// FibRgFcLcb depends on the value of nFib, which is one of the following.
/// Value Meaning
/// 0x00C1 fibRgFcLcb97
/// 0x00D9 fibRgFcLcb2000
/// 0x0101 fibRgFcLcb2002
/// 0x010C fibRgFcLcb2003
/// 0x0112 fibRgFcLcb2007
public struct FibRgFcLcb {
    public let fibRgFcLcb97: FibRgFcLcb97
    public let fibRgFcLcb2000: FibRgFcLcb2000?
    public let fibRgFcLcb2002: FibRgFcLcb2002?
    public let fibRgFcLcb2003: FibRgFcLcb2003?
    public let fibRgFcLcb2007: FibRgFcLcb2007?
    private let fibRgFcLcb: Any
    
    public init(dataStream: inout DataStream, cbRgFcLcb: UInt16, fibBase: FibBase, fibRgLw97: FibRgLw97) throws {
        switch cbRgFcLcb {
        case 0x005D:
            let fibRgFcLcb97 = try FibRgFcLcb97(dataStream: &dataStream, fibBase: fibBase, fibRgLw97: fibRgLw97)
            self.fibRgFcLcb97 = fibRgFcLcb97
            self.fibRgFcLcb2000 = nil
            self.fibRgFcLcb2002 = nil
            self.fibRgFcLcb2003 = nil
            self.fibRgFcLcb2007 = nil
            self.fibRgFcLcb = fibRgFcLcb97
        case 0x006C:
            let fibRgFcLcb2000 = try FibRgFcLcb2000(dataStream: &dataStream, fibBase: fibBase, fibRgLw97: fibRgLw97)
            self.fibRgFcLcb97 = fibRgFcLcb2000.rgFcLcb97
            self.fibRgFcLcb2000 = fibRgFcLcb2000
            self.fibRgFcLcb2002 = nil
            self.fibRgFcLcb2003 = nil
            self.fibRgFcLcb2007 = nil
            self.fibRgFcLcb = fibRgFcLcb2000
        case 0x0088:
            let fibRgFcLcb2002 = try FibRgFcLcb2002(dataStream: &dataStream, fibBase: fibBase, fibRgLw97: fibRgLw97)
            self.fibRgFcLcb97 = fibRgFcLcb2002.rgFcLcb2000.rgFcLcb97
            self.fibRgFcLcb2000 = fibRgFcLcb2002.rgFcLcb2000
            self.fibRgFcLcb2002 = fibRgFcLcb2002
            self.fibRgFcLcb2003 = nil
            self.fibRgFcLcb2007 = nil
            self.fibRgFcLcb = fibRgFcLcb2002
        case 0x00A4:
            let fibRgFcLcb2003 = try FibRgFcLcb2003(dataStream: &dataStream, fibBase: fibBase, fibRgLw97: fibRgLw97)
            self.fibRgFcLcb97 = fibRgFcLcb2003.rgFcLcb2002.rgFcLcb2000.rgFcLcb97
            self.fibRgFcLcb2000 = fibRgFcLcb2003.rgFcLcb2002.rgFcLcb2000
            self.fibRgFcLcb2002 = fibRgFcLcb2003.rgFcLcb2002
            self.fibRgFcLcb2003 = fibRgFcLcb2003
            self.fibRgFcLcb2007 = nil
            self.fibRgFcLcb = fibRgFcLcb2003
        case 0x00B7:
            let fibRgFcLcb2007 = try FibRgFcLcb2007(dataStream: &dataStream, fibBase: fibBase, fibRgLw97: fibRgLw97)
            self.fibRgFcLcb97 = fibRgFcLcb2007.rgFcLcb2003.rgFcLcb2002.rgFcLcb2000.rgFcLcb97
            self.fibRgFcLcb2000 = fibRgFcLcb2007.rgFcLcb2003.rgFcLcb2002.rgFcLcb2000
            self.fibRgFcLcb2002 = fibRgFcLcb2007.rgFcLcb2003.rgFcLcb2002
            self.fibRgFcLcb2003 = fibRgFcLcb2007.rgFcLcb2003
            self.fibRgFcLcb2007 = fibRgFcLcb2007
            self.fibRgFcLcb = fibRgFcLcb2007
        default:
            throw OfficeFileError.corrupted
        }
    }
}
