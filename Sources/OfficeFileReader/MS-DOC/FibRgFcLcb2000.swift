//
//  FibRgFcLcb2000.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.7 FibRgFcLcb2000
/// The FibRgFcLcb2000 structure is a variable-sized portion of the Fib. It extends the FibRgFcLcb97.
public struct FibRgFcLcb2000 {
    public let rgFcLcb97: FibRgFcLcb97
    public let fcPlcfTch: UInt32
    public let lcbPlcfTch: UInt32
    public let fcRmdThreading: UInt32
    public let lcbRmdThreading: UInt32
    public let fcMid: UInt32
    public let lcbMid: UInt32
    public let fcSttbRgtplc: UInt32
    public let lcbSttbRgtplc: UInt32
    public let fcMsoEnvelope: UInt32
    public let lcbMsoEnvelope: UInt32
    public let fcPlcfLad: UInt32
    public let lcbPlcfLad: UInt32
    public let fcRgDofr: UInt32
    public let lcbRgDofr: UInt32
    public let fcPlcosl: UInt32
    public let lcbPlcosl: UInt32
    public let fcPlcfCookieOld: UInt32
    public let lcbPlcfCookieOld: UInt32
    public let fcPgdMotherOld: UInt32
    public let lcbPgdMotherOld: UInt32
    public let fcBkdMotherOld: UInt32
    public let lcbBkdMotherOld: UInt32
    public let fcPgdFtnOld: UInt32
    public let lcbPgdFtnOld: UInt32
    public let fcBkdFtnOld: UInt32
    public let lcbBkdFtnOld: UInt32
    public let fcPgdEdnOld: UInt32
    public let lcbPgdEdnOld: UInt32
    public let fcBkdEdnOld: UInt32
    public let lcbBkdEdnOld: UInt32
    
    public init(dataStream: inout DataStream, fibBase: FibBase, fibRgLw97: FibRgLw97) throws {
        /// rgFcLcb97 (744 bytes): The contained FibRgFcLcb97.
        self.rgFcLcb97 = try FibRgFcLcb97(dataStream: &dataStream, fibBase: fibBase, fibRgLw97: fibRgLw97)
        
        /// fcPlcfTch (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfTch begins at this offset and specifies a
        /// cache of table characters. Information at this offset SHOULD<65> be ignored. If lcbPlcfTch is zero, fcPlcfTch is undefined and
        /// MUST be ignored.
        self.fcPlcfTch = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfTch (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfTch at offset fcPlcfTch.
        self.lcbPlcfTch = try dataStream.read(endianess: .littleEndian)
        
        /// fcRmdThreading (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An RmdThreading that specifies the
        /// data concerning the e-mail messages and their authors in this document begins at this offset.
        self.fcRmdThreading = try dataStream.read(endianess: .littleEndian)
        
        /// lcbRmdThreading (4 bytes): An unsigned integer that specifies the size, in bytes, of the RmdThreading at the offset fcRmdThreading.
        /// This value MUST NOT be zero.
        self.lcbRmdThreading = try dataStream.read(endianess: .littleEndian)
        
        /// fcMid (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A double-byte character Unicode string that specifies
        /// the message identifier of the document begins at this offset. This value MUST be ignored.
        self.fcMid = try dataStream.read(endianess: .littleEndian)
        
        /// lcbMid (4 bytes): An unsigned integer that specifies the size, in bytes, of the double-byte character Unicode string at offset fcMid.
        /// This value MUST be ignored.
        self.lcbMid = try dataStream.read(endianess: .littleEndian)
        
        /// fcSttbRgtplc (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A SttbRgtplc that specifies the styles of lists
        /// in the document begins at this offset. If lcbSttbRgtplc is zero, fcSttbRgtplc is undefined and MUST be ignored.
        self.fcSttbRgtplc = try dataStream.read(endianess: .littleEndian)
        
        /// lcbSttbRgtplc (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbRgtplc at the offset fcSttbRgtplc.
        self.lcbSttbRgtplc = try dataStream.read(endianess: .littleEndian)
        
        /// fcMsoEnvelope (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An MsoEnvelopeCLSID, which specifies
        /// the envelope data as specified by [MS-OSHARED] section 2.3.8.1, begins at this offset. If lcbMsoEnvelope is zero, fcMsoEnvelope
        /// is undefined and MUST be ignored.
        self.fcMsoEnvelope = try dataStream.read(endianess: .littleEndian)
        
        /// lcbMsoEnvelope (4 bytes): An unsigned integer that specifies the size, in bytes, of the MsoEnvelopeCLSID at the offset
        /// fcMsoEnvelope.
        self.lcbMsoEnvelope = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfLad (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Plcflad begins at this offset and specifies the
        /// language auto-detect state of each text range. If lcbPlcfLad is zero, fcPlcfLad is undefined and MUST be ignored.
        self.fcPlcfLad = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfLad (4 bytes): An unsigned integer that specifies the size, in bytes, of the Plcflad that begins at offset fcPlcfLad in the
        /// Table Stream.
        self.lcbPlcfLad = try dataStream.read(endianess: .littleEndian)
        
        /// fcRgDofr (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A variablelength array with elements of type
        /// Dofrh begins at that offset. The elements of this array are records that support the frame set and list style features. If lcbRgDofr is
        /// zero, fcRgDofr is undefined and MUST be ignored.
        self.fcRgDofr = try dataStream.read(endianess: .littleEndian)
        
        /// lcbRgDofr (4 bytes): An unsigned integer that specifies the size, in bytes, of the array that begins at offset fcRgDofr in the
        /// Table Stream.
        self.lcbRgDofr = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcosl (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlfCosl begins at the offset. If lcbPlcosl is zero,
        /// fcPlcosl is undefined and MUST be ignored.
        self.fcPlcosl = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcosl (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlfCosl at offset fcPlcosl in the Table Stream.
        self.lcbPlcosl = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfCookieOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfcookieOld begins at this offset.
        /// If lcbPlcfcookieOld is zero, fcPlcfcookieOld is undefined and MUST be ignored. fcPlcfcookieOld MAY<66> be ignored.
        self.fcPlcfCookieOld = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfCookieOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfcookieOld at offset fcPlcfcookieOld
        /// in the Table Stream.
        self.lcbPlcfCookieOld = try dataStream.read(endianess: .littleEndian)
        
        /// fcPgdMotherOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated document page layout
        /// cache begins at this offset. Information SHOULD NOT<67> be emitted at this offset and SHOULD<68> be ignored. If
        /// lcbPgdMotherOld is zero, fcPgdMotherOld is undefined and MUST be ignored.
        self.fcPgdMotherOld = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPgdMotherOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated document page layout cache at
        /// offset fcPgdMotherOld in the Table Stream.
        self.lcbPgdMotherOld = try dataStream.read(endianess: .littleEndian)
        
        /// fcBkdMotherOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated document text flow
        /// break cache begins at this offset. Information SHOULD NOT<69> be emitted at this offset and SHOULD<70> be ignored. If
        /// lcbBkdMotherOld is zero, fcBkdMotherOld is undefined and MUST be ignored.
        self.fcBkdMotherOld = try dataStream.read(endianess: .littleEndian)
        
        /// lcbBkdMotherOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated document text flow break
        /// cache at offset fcBkdMotherOld in the Table Stream.
        self.lcbBkdMotherOld = try dataStream.read(endianess: .littleEndian)
        
        /// fcPgdFtnOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated footnote layout cache
        /// begins at this offset. Information SHOULD NOT<71> be emitted at this offset and SHOULD<72> be ignored. If lcbPgdFtnOld is
        /// zero, fcPgdFtnOld is undefined and MUST be ignored.
        self.fcPgdFtnOld = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPgdFtnOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated footnote layout cache at offset
        /// fcPgdFtnOld in the Table Stream.
        self.lcbPgdFtnOld = try dataStream.read(endianess: .littleEndian)
        
        /// fcBkdFtnOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated footnote text flow break
        /// cache begins at this offset. Information SHOULD NOT<73> be emitted at this offset and SHOULD<74> be ignored. If lcbBkdFtnOld
        /// is zero, fcBkdFtnOld is undefined and MUST be ignored.
        self.fcBkdFtnOld = try dataStream.read(endianess: .littleEndian)
        
        /// lcbBkdFtnOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated footnote text flow break cache at
        /// offset fcBkdFtnOld in the Table Stream.
        self.lcbBkdFtnOld = try dataStream.read(endianess: .littleEndian)
        
        /// fcPgdEdnOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated endnote layout cache
        /// begins at this offset. Information SHOULD NOT<75> be emitted at this offset and SHOULD<76> be ignored. If lcbPgdEdnOld
        /// is zero, fcPgdEdnOld is undefined and MUST be ignored.
        self.fcPgdEdnOld = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPgdEdnOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated endnote layout cache at offset
        /// fcPgdEdnOld in the Table Stream.
        self.lcbPgdEdnOld = try dataStream.read(endianess: .littleEndian)
        
        /// fcBkdEdnOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated endnote text flow break
        /// cache begins at this offset. Information SHOULD NOT<77> be emitted at this offset and SHOULD<78> be ignored. If lcbBkdEdnOld
        /// is zero, fcBkdEdnOld is undefined and MUST be ignored.
        self.fcBkdEdnOld = try dataStream.read(endianess: .littleEndian)
        
        /// lcbBkdEdnOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated endnote text flow break cache at
        /// offset fcBkdEdnOld in the Table Stream.
        self.lcbBkdEdnOld = try dataStream.read(endianess: .littleEndian)
    }
}
