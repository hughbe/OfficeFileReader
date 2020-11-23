//
//  BKC.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.8 BKC
/// The BKC structure contains information about how a bookmark interacts with tables.
public struct BKC {
    public let itcFirst: UInt8
    public let fPub: Bool
    public let itcLim: UInt8
    public let fNative: Bool
    public let fCol: Bool
    
    public init(dataStream: inout DataStream) throws {
        var rawValue: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// itcFirst (7 bits): If fCol is zero, this value MUST be ignored. Otherwise, this value is an unsigned integer specifying the zero-based index of the
        /// table column that is the start of the table column range associated with the bookmark described by this BKC. See itcLim for additional constraints
        /// on the value of itcFirst.
        self.itcFirst = UInt8(rawValue.readBits(count: 7))
        
        /// A - fPub (1 bit): This value MUST be zero, and MUST be ignored.
        self.fPub = rawValue.readBit()
        
        /// itcLim (6 bits): If fCol is zero, this value MUST be ignored. Otherwise, this value is an unsigned integer specifying the zero-based index of the
        /// first column beyond the end of the table column range associated with the bookmark described by this BKC.
        /// For all bookmark types, itcFirst MUST be less than itcLim if fCol is not zero.
        /// For range-level protection bookmarks, itcLim MUST be exactly 1 greater than itcFirst if fCol is not zero.
        self.itcLim = UInt8(rawValue.readBits(count: 6))
        
        /// B - fNative (1 bit): A bit flag that specifies whether an application is expected to include the bookmark described by this BKC when saving its file
        /// as Rich Text Format (RTF), HTML, or XML. If fNative is zero, the bookmark is no longer needed and is a disposable item that was generated
        /// by the application to act as a temporary placeholder at run time. The bookmark is not expected to be included if the file is saved as RTF, HTML,
        /// or XML.
        self.fNative = rawValue.readBit()
        
        /// C - fCol (1 bit): For structured document tag bookmarks and annotation bookmarks, fCol MUST be zero. Otherwise, if the lowest table depth
        /// within the span of text defined by the CPs of a bookmark is greater than zero, and the span of text defined by the CPs of that bookmark contains
        /// a table cell mark from that table and nothing outside that table, then the fCol member of the bookmark’s (1) BKC MUST be 1. Otherwise, it
        /// MUST be zero. If the fCol member of the BKC of a range-level protection bookmark is set to 1, the span of text that is defined by the CPs of that
        /// bookmark MUST NOT include more than one table terminating paragraph mark. Further constraints upon the span of text defined by the CPs of
        /// a bookmark can be found in section PlcfBkf.
        self.fCol = rawValue.readBit()
    }
}
