//
//  FibRgLw97.swift
//  
//
//  Created by Hugh Bellamy on 05/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.4 FibRgLw97
/// The FibRgLw97 structure is the third section of the FIB. This contains an array of 4-byte values.
public struct FibRgLw97 {
    public let bMac: UInt32
    public let reserved1: UInt32
    public let reserved2: UInt32
    public let ccpText: Int32
    public let ccpFtn: Int32
    public let ccpHdd: Int32
    public let reserved3: Int32
    public let ccpAtn: Int32
    public let ccpEdn: Int32
    public let ccpTxbx: Int32
    public let ccpHdrTxbx: Int32
    public let reserved4: UInt32
    public let reserved5: UInt32
    public let reserved6: UInt32
    public let reserved7: UInt32
    public let reserved8: UInt32
    public let reserved9: UInt32
    public let reserved10: UInt32
    public let reserved11: UInt32
    public let reserved12: UInt32
    public let reserved13: UInt32
    public let reserved14: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// bMac (4 bytes): Specifies the count of bytes of those written to the WordDocument stream of the file that have any meaning.
        /// All bytes in the WordDocument stream at offset cbMac and greater MUST be ignored.
        self.bMac = try dataStream.read(endianess: .littleEndian)
        
        /// reserved1 (4 bytes): This value is undefined and MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved2 (4 bytes): This value is undefined and MUST be ignored.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
        
        /// ccpText (4 bytes): A signed integer that specifies the count of CPs in the main document. This value MUST be zero, 1, or greater.
        self.ccpText = try dataStream.read(endianess: .littleEndian)
        if self.ccpText < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// ccpFtn (4 bytes): A signed integer that specifies the count of CPs in the footnote subdocument. This value MUST be zero, 1, or greater.
        self.ccpFtn = try dataStream.read(endianess: .littleEndian)
        if self.ccpFtn < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// ccpHdd (4 bytes): A signed integer that specifies the count of CPs in the header subdocument. This value MUST be zero, 1, or greater.
        self.ccpHdd = try dataStream.read(endianess: .littleEndian)
        if self.ccpHdd < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved3 (4 bytes): This value MUST be zero and MUST be ignored.
        self.reserved3 = try dataStream.read(endianess: .littleEndian)
        
        /// ccpAtn (4 bytes): A signed integer that specifies the count of CPs in the comment subdocument. This value MUST be zero, 1, or greater.
        self.ccpAtn = try dataStream.read(endianess: .littleEndian)
        if self.ccpAtn < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// ccpEdn (4 bytes): A signed integer that specifies the count of CPs in the endnote subdocument. This value MUST be zero, 1, or greater.
        self.ccpEdn = try dataStream.read(endianess: .littleEndian)
        if self.ccpEdn < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// ccpTxbx (4 bytes): A signed integer that specifies the count of CPs in the textbox subdocument of the main document. This value MUST be zero, 1, or greater.
        self.ccpTxbx = try dataStream.read(endianess: .littleEndian)
        if self.ccpTxbx < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// ccpHdrTxbx (4 bytes): A signed integer that specifies the count of CPs in the textbox subdocument of the header. This value MUST be zero, 1, or greater.
        self.ccpHdrTxbx = try dataStream.read(endianess: .littleEndian)
        if self.ccpHdrTxbx < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved4 (4 bytes): This value is undefined and MUST be ignored.
        self.reserved4 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved5 (4 bytes): This value is undefined and MUST be ignored.
        self.reserved5 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved6 (4 bytes): This value MUST be equal or less than the number of data elements in PlcBteChpx, as specified by
        /// FibRgFcLcb97.fcPlcfBteChpx and FibRgFcLcb97.lcbPlcfBteChpx. This value MUST be ignored.
        self.reserved6 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved7 (4 bytes): This value is undefined and MUST be ignored
        self.reserved7 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved8 (4 bytes): This value is undefined and MUST be ignored
        self.reserved8 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved9 (4 bytes): This value MUST be less than or equal to the number of data elements in PlcBtePapx, as specified by
        /// FibRgFcLcb97.fcPlcfBtePapx and FibRgFcLcb97.lcbPlcfBtePapx. This value MUST be ignored.
        self.reserved9 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved10 (4 bytes): This value is undefined and MUST be ignored.
        self.reserved10 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved11 (4 bytes): This value is undefined and MUST be ignored.
        self.reserved11 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved12 (4 bytes): This value SHOULD<26> be zero, and MUST be ignored.
        self.reserved12 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved13 (4 bytes): This value MUST be zero and MUST be ignored.
        self.reserved13 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved14 (4 bytes): This value MUST be zero and MUST be ignored.
        self.reserved14 = try dataStream.read(endianess: .littleEndian)
    }
}
