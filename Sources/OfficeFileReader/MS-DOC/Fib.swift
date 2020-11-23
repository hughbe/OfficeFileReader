//
//  Fib.swift
//  
//
//  Created by Hugh Bellamy on 05/11/2020.
//

import DataStream

/// [MS-DOC] 2.5 The File Information Block
/// [MS-DOC] 2.5.1 Fib
/// The Fib structure contains information about the document and specifies the file pointers to various portions that make up the document.
/// The Fib is a variable length structure. With the exception of the base portion which is fixed in size, every section is preceded with a count
/// field that specifies the size of the next section.
public struct Fib {
    public let base: FibBase
    public let csw: UInt16
    public let fibRgW: FibRgW97
    public let cslw: UInt16
    public let fibRgLw97: FibRgLw97
    public let cbRgFcLcb: UInt16
    public let fibRgFcLcbBlob: FibRgFcLcb
    public let cswNew: UInt16
    public let fibRgCswNew: FibRgCswNew?
    
    public init(dataStream: inout DataStream) throws {
        /// base (32 bytes): The FibBase.
        self.base = try FibBase(dataStream: &dataStream)
        
        /// csw (2 bytes): An unsigned integer that specifies the count of 16-bit values corresponding to fibRgW that follow. MUST be 0x000E.
        self.csw = try dataStream.read(endianess: .littleEndian)
        if self.csw != 0x000E {
            throw OfficeFileError.corrupted
        }
        
        // fibRgW (28 bytes): The FibRgW97.
        self.fibRgW = try FibRgW97(dataStream: &dataStream)
        
        /// cslw (2 bytes): An unsigned integer that specifies the count of 32-bit values corresponding to fibRgLw that follow. MUST be 0x0016.
        self.cslw = try dataStream.read(endianess: .littleEndian)
        if self.cslw != 0x0016 {
            throw OfficeFileError.corrupted
        }
        
        /// fibRgLw (88 bytes): The FibRgLw97.
        self.fibRgLw97 = try FibRgLw97(dataStream: &dataStream)
        
        /// cbRgFcLcb (2 bytes): An unsigned integer that specifies the count of 64-bit values corresponding to fibRgFcLcbBlob that follow.
        /// This MUST be one of the following values, depending on the value of nFib.
        /// Value of nFib cbRgFcLcb
        /// 0x00C1 0x005D
        /// 0x00D9 0x006C
        /// 0x0101 0x0088
        /// 0x010C 0x00A4
        /// 0x0112 0x00B7
        let cbRgFcLcb: UInt16 = try dataStream.read(endianess: .littleEndian)
        if self.base.nFib == 0x00C1 && cbRgFcLcb != 0x005D && cbRgFcLcb != 0x006C && cbRgFcLcb != 0x00B7 {
            throw OfficeFileError.corrupted
        } else if self.base.nFib == 0x00D9 && cbRgFcLcb != 0x006C {
            throw OfficeFileError.corrupted
        } else if self.base.nFib == 0x0101 && cbRgFcLcb != 0x0088 {
            throw OfficeFileError.corrupted
        } else if self.base.nFib == 0x010C && cbRgFcLcb != 0x00A4 {
            throw OfficeFileError.corrupted
        } else if self.base.nFib == 0x0112 && cbRgFcLcb != 0x00B7 {
            throw OfficeFileError.corrupted
        }
        
        self.cbRgFcLcb = cbRgFcLcb
        
        /// fibRgFcLcbBlob (variable): The FibRgFcLcb.
        self.fibRgFcLcbBlob = try FibRgFcLcb(dataStream: &dataStream, cbRgFcLcb: cbRgFcLcb, fibBase: self.base, fibRgLw97: self.fibRgLw97)
        
        /// cswNew (2 bytes): An unsigned integer that specifies the count of 16-bit values corresponding to fibRgCswNew that follow.
        /// This MUST be one of the following values, depending on the value of nFib.
        /// Value of nFib cswNew
        /// 0x00C1 0
        /// 0x00D9 0x0002
        /// 0x0101 0x0002
        /// 0x010C 0x0002
        /// 0x0112 0x0005
        let cswNew: UInt16 = try dataStream.read(endianess: .littleEndian)
        if cswNew != 0 && cswNew != 0x0002 && cswNew != 0x0005 {
            throw OfficeFileError.corrupted
        }
        
        self.cswNew = cswNew
        
        /// fibRgCswNew (variable): If cswNew is nonzero, this is fibRgCswNew. Otherwise, it is not present in the file.
        if self.cswNew != 0 {
            self.fibRgCswNew = try FibRgCswNew(dataStream: &dataStream)
        } else {
            self.fibRgCswNew = nil
        }
    }
}
