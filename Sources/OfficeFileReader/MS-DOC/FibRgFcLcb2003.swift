//
//  FibRgFcLcb2003.swift
//
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.9 FibRgFcLcb2003
/// The FibRgFcLcb2003 structure is a variable-sized portion of the Fib. It extends the FibRgFcLcb2002.
public struct FibRgFcLcb2003 {
    public let rgFcLcb2002: FibRgFcLcb2002
    public let fcHplxsdr: UInt32
    public let lcbHplxsdr: UInt32
    public let fcSttbfBkmkSdt: UInt32
    public let lcbSttbfBkmkSdt: UInt32
    public let fcPlcfBkfSdt: UInt32
    public let lcbPlcfBkfSdt: UInt32
    public let fcPlcfBklSdt: UInt32
    public let lcbPlcfBklSdt: UInt32
    public let fcCustomXForm: UInt32
    public let lcbCustomXForm: UInt32
    public let fcSttbfBkmkProt: UInt32
    public let lcbSttbfBkmkProt: UInt32
    public let fcPlcfBkfProt: UInt32
    public let lcbPlcfBkfProt: UInt32
    public let fcPlcfBklProt: UInt32
    public let lcbPlcfBklProt: UInt32
    public let fcSttbProtUser: UInt32
    public let lcbSttbProtUser: UInt32
    public let fcUnused: UInt32
    public let lcbUnused: UInt32
    public let fcPlcfpmiOld: UInt32
    public let lcbPlcfpmiOld: UInt32
    public let fcPlcfpmiOldInline: UInt32
    public let lcbPlcfpmiOldInline: UInt32
    public let fcPlcfpmiNew: UInt32
    public let lcbPlcfpmiNew: UInt32
    public let fcPlcfpmiNewInline: UInt32
    public let lcbPlcfpmiNewInline: UInt32
    public let fcPlcflvcOld: UInt32
    public let lcbPlcflvcOld: UInt32
    public let fcPlcflvcOldInline: UInt32
    public let lcbPlcflvcOldInline: UInt32
    public let fcPlcflvcNew: UInt32
    public let lcbPlcflvcNew: UInt32
    public let fcPlcflvcNewInline: UInt32
    public let lcbPlcflvcNewInline: UInt32
    public let fcPgdMother: UInt32
    public let lcbPgdMother: UInt32
    public let fcBkdMother: UInt32
    public let lcbBkdMother: UInt32
    public let fcAfdMother: UInt32
    public let lcbAfdMother: UInt32
    public let fcPgdFtn: UInt32
    public let lcbPgdFtn: UInt32
    public let fcBkdFtn: UInt32
    public let lcbBkdFtn: UInt32
    public let fcAfdFtn: UInt32
    public let lcbAfdFtn: UInt32
    public let fcPgdEdn: UInt32
    public let lcbPgdEdn: UInt32
    public let fcBkdEdn: UInt32
    public let lcbBkdEdn: UInt32
    public let fcAfdEdn: UInt32
    public let lcbAfdEdn: UInt32
    public let fcAfd: UInt32
    public let lcbAfd: UInt32
    
    public init(dataStream: inout DataStream, fibBase: FibBase, fibRgLw97: FibRgLw97) throws {
        /// rgFcLcb2002 (1088 bytes): The contained FibRgFcLcb2002.
        self.rgFcLcb2002 = try FibRgFcLcb2002(dataStream: &dataStream, fibBase: fibBase, fibRgLw97: fibRgLw97)
        
        /// fcHplxsdr (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An Hplxsdr structure begins at this offset.
        /// This structure specifies information about XML schema definition (XSD) references.
        self.fcHplxsdr = try dataStream.read(endianess: .littleEndian)
        
        /// lcbHplxsdr (4 bytes): An unsigned integer that specifies the size, in bytes, of the Hplxsdr structure at the offset fcHplxsdr in the
        /// Table Stream. If lcbHplxsdr is zero, then fcHplxsdr is undefined and MUST be ignored.
        self.lcbHplxsdr = try dataStream.read(endianess: .littleEndian)
        
        /// fcSttbfBkmkSdt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfBkmkSdt that contains information
        /// about the structured document tag bookmarks in the document begins at this offset. If lcbSttbfBkmkSdt is zero, then fcSttbfBkmkSdt
        /// is undefined and MUST be ignored.
        /// The SttbfBkmkSdt is parallel to the PlcBkfd at offset fcPlcfBkfSdt in the Table Stream. Each element in the SttbfBkmkSdt specifies
        /// information about the bookmark that is associated with the data element which is located at the same offset in that PlcBkfd. For
        /// this reason, the SttbfBkmkSdt that begins at offset fcSttbfBkmkSdt, and the PlcBkfd that begins at offset fcPlcfBkfSdt, MUST
        /// contain the same number of elements.
        self.fcSttbfBkmkSdt = try dataStream.read(endianess: .littleEndian)
        
        /// lcbSttbfBkmkSdt (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfBkmkSdt at offset fcSttbfBkmkSdt.
        self.lcbSttbfBkmkSdt = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfBkfSdt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcBkfd that contains information about
        /// the structured document tag bookmarks in the document begins at this offset. If lcbPlcfBkfSdt is zero, fcPlcfBkfSdt is undefined
        /// and MUST be ignored.
        /// Each data element in the PlcBkfd is associated, in a one-to-one correlation, with a data element in the PlcBkld at offset fcPlcfBklSdt.
        /// For this reason, the PlcBkfd that begins at offset fcPlcfBkfSdt, and the PlcBkld that begins at offset fcPlcfBklSdt, MUST contain
        /// the same number of data elements. The PlcBkfd is parallel to the SttbfBkmkSdt at offset fcSttbfBkmkSdt in the Table Stream. Each
        /// data element in the PlcBkfd specifies information about the bookmark that is associated with the element which is located at the
        /// same offset in that SttbfBkmkSdt. For this reason, the PlcBkfd that begins at offset fcPlcfBkfSdt, and the SttbfBkmkSdt that begins
        /// at offset fcSttbfBkmkSdt, MUST contain the same number of elements.
        self.fcPlcfBkfSdt = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfBkfSdt (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcBkfd at offset fcPlcfBkfSdt.
        self.lcbPlcfBkfSdt = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfBklSdt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcBkld that contains information about
        /// the structured document tag bookmarks in the document begins at this offset. If lcbPlcfBklSdt is zero, fcPlcfBklSdt is undefined
        /// and MUST be ignored.
        /// Each data element in the PlcBkld is associated, in a one-to-one correlation, with a data element in the PlcBkfd at offset fcPlcfBkfSdt.
        /// For this reason, the PlcBkld that begins at offset fcPlcfBklSdt, and the PlcBkfd that begins at offset fcPlcfBkfSdt MUST contain the
        /// same number of data elements.
        self.fcPlcfBklSdt = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfBklSdt (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcBkld at offset fcPlcfBklSdt.
        self.lcbPlcfBklSdt = try dataStream.read(endianess: .littleEndian)
        
        /// fcCustomXForm (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An array of 16-bit Unicode characters,
        /// which specifies the full path and file name of the XML Stylesheet to apply when saving this document in XML format, begins at this
        /// offset. If lcbCustomXForm is zero, fcCustomXForm is undefined and MUST be ignored.
        self.fcCustomXForm = try dataStream.read(endianess: .littleEndian)
        
        /// lcbCustomXForm (4 bytes): An unsigned integer that specifies the size, in bytes, of the array at offset fcCustomXForm in the Table
        /// Stream. This value MUST be less than or equal to 4168 and MUST be evenly divisible by two.
        self.lcbCustomXForm = try dataStream.read(endianess: .littleEndian)
        
        /// fcSttbfBkmkProt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfBkmkProt that contains
        /// information about range-level protection bookmarks in the document begins at this offset. If lcbSttbfBkmkProt is zero,
        /// fcSttbfBkmkProt is undefined and MUST be ignored.
        /// The SttbfBkmkProt is parallel to the PlcBkf at offset fcPlcfBkfProt in the Table Stream. Each element in the SttbfBkmkProt specifies
        /// information about the bookmark that is associated with the data element which is located at the same offset in that PlcBkf. For this
        /// reason, the SttbfBkmkProt that begins at offset fcSttbfBkmkProt, and the PlcBkf that begins at offset fcPlcfBkfProt, MUST contain
        /// the same number of elements.
        self.fcSttbfBkmkProt = try dataStream.read(endianess: .littleEndian)
        
        /// lcbSttbfBkmkProt (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfBkmkProt at offset fcSttbfBkmkProt.
        self.lcbSttbfBkmkProt = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfBkfProt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcBkf that contains information about
        /// range-level protection bookmarks in the document begins at this offset. If lcbPlcfBkfProt is zero, then fcPlcfBkfProt is undefined
        /// and MUST be ignored.
        /// Each data element in the PlcBkf is associated, in a one-to-one correlation, with a data element in the PlcBkl at offset fcPlcfBklProt.
        /// For this reason, the PlcBkf that begins at offset fcPlcfBkfProt, and the PlcBkl that begins at offset fcPlcfBklProt, MUST contain the
        /// same number of data elements. The PlcBkf is parallel to the SttbfBkmkProt at offset fcSttbfBkmkProt in the Table Stream. Each
        /// data element in the PlcBkf specifies information about the bookmark that is associated with the element which is located at the
        /// same offset in that SttbfBkmkProt. For this reason, the PlcBkf that begins at offset fcPlcfBkfProt, and the SttbfBkmkProt that begins
        /// at offset fcSttbfBkmkProt, MUST contain the same number of elements.
        self.fcPlcfBkfProt = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfBkfProt (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcBkf at offset fcPlcfBkfProt.
        self.lcbPlcfBkfProt = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfBklProt (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcBkl containing information about
        /// range-level protection bookmarks in the document begins at this offset. If lcbPlcfBklProt is zero, then fcPlcfBklProt is undefined and
        /// MUST be ignored.
        /// Each data element in the PlcBkl is associated in a one-to-one correlation with a data element in the PlcBkf at offset fcPlcfBkfProt, so
        /// the PlcBkl beginning at offset fcPlcfBklProt and the PlcBkf beginning at offset fcPlcfBkfProt MUST contain the same number of data
        /// elements.
        self.fcPlcfBklProt = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfBklProt (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcBkl at offset fcPlcfBklProt.
        self.lcbPlcfBklProt = try dataStream.read(endianess: .littleEndian)
        
        /// fcSttbProtUser (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A SttbProtUser that specifies the usernames
        /// that are used for range-level protection begins at this offset.
        self.fcSttbProtUser = try dataStream.read(endianess: .littleEndian)
        
        /// lcbSttbProtUser (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbProtUser at the offset fcSttbProtUser.
        self.lcbSttbProtUser = try dataStream.read(endianess: .littleEndian)
        
        /// fcUnused (4 bytes): This value MUST be zero, and MUST be ignored.
        self.fcUnused = try dataStream.read(endianess: .littleEndian)
        
        /// lcbUnused (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfpmiOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated paragraph mark information
        /// cache begins at this offset. Information SHOULD NOT<100> be emitted at this offset and SHOULD<101> be ignored. If
        /// lcbPlcfpmiOld is zero, then fcPlcfpmiOld is undefined and MUST be ignored.
        self.fcPlcfpmiOld = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfpmiOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated paragraph mark information cache
        /// at offset fcPlcfpmiOld in the Table Stream. SHOULD<102> be zero.
        self.lcbPlcfpmiOld = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfpmiOldInline (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated paragraph mark information
        /// cache begins at this offset. Information SHOULD NOT<103> be emitted at this offset and SHOULD<104> be ignored. If
        /// lcbPlcfpmiOldInline is zero, then fcPlcfpmiOldInline is undefined and MUST be ignored.
        self.fcPlcfpmiOldInline = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfpmiOldInline (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated paragraph mark information
        /// cache at offset fcPlcfpmiOldInline in the Table Stream. SHOULD<105> be zero.
        self.lcbPlcfpmiOldInline = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfpmiNew (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated paragraph mark information
        /// cache begins at this offset. Information SHOULD NOT<106> be emitted at this offset and SHOULD<107> be ignored. If
        /// lcbPlcfpmiNew is zero, then fcPlcfpmiNew is undefined and MUST be ignored.
        self.fcPlcfpmiNew = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfpmiNew (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated paragraph mark information cache
        /// at offset fcPlcfpmiNew in the Table Stream. SHOULD<108> be zero.
        self.lcbPlcfpmiNew = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcfpmiNewInline (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated paragraph mark information
        /// cache begins at this offset. Information SHOULD NOT<109> be emitted at this offset and SHOULD<110> be ignored. If
        /// lcbPlcfpmiNewInline is zero, then fcPlcfpmiNewInline is undefined and MUST be ignored.
        self.fcPlcfpmiNewInline = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcfpmiNewInline (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated paragraph mark information
        /// cache at offset fcPlcfpmiNewInline in the Table Stream. SHOULD<111> be zero.
        self.lcbPlcfpmiNewInline = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcflvcOld (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated listnum field cache begins at this
        /// offset. Information SHOULD NOT<112> be emitted at this offset and SHOULD<113> be ignored. If lcbPlcflvcOld is zero, then
        /// fcPlcflvcOld is undefined and MUST be ignored.
        self.fcPlcflvcOld = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcflvcOld (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated listnum field cache at offset
        /// fcPlcflvcOld in the Table Stream. SHOULD<114> be zero.
        self.lcbPlcflvcOld = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcflvcOldInline (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated listnum field cache begins
        /// at this offset. Information SHOULD NOT<115> be emitted at this offset and SHOULD<116> be ignored. If lcbPlcflvcOldInline is
        /// zero, fcPlcflvcOldInline is undefined and MUST be ignored.
        self.fcPlcflvcOldInline = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcflvcOldInline (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated listnum field cache at offset
        /// fcPlcflvcOldInline in the Table Stream. SHOULD<117> be zero.
        self.lcbPlcflvcOldInline = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcflvcNew (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated listnum field cache begins at
        /// this offset. Information SHOULD NOT<118> be emitted at this offset and SHOULD<119> be ignored. If lcbPlcflvcNew is zero,
        /// fcPlcflvcNew is undefined and MUST be ignored.
        self.fcPlcflvcNew = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcflvcNew (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated listnum field cache at offset
        /// fcPlcflvcNew in the Table Stream. SHOULD<120> be zero.
        self.lcbPlcflvcNew = try dataStream.read(endianess: .littleEndian)
        
        /// fcPlcflvcNewInline (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated listnum field cache begins
        /// at this offset. Information SHOULD NOT<121> be emitted at this offset and SHOULD<122> be ignored. If lcbPlcflvcNewInline is
        /// zero, fcPlcflvcNewInline is undefined and MUST be ignored.
        self.fcPlcflvcNewInline = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPlcflvcNewInline (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated listnum field cache at offset
        /// fcPlcflvcNewInline in the Table Stream. SHOULD<123> be zero.
        self.lcbPlcflvcNewInline = try dataStream.read(endianess: .littleEndian)
        
        /// fcPgdMother (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated document page layout cache
        /// begins at this offset. Information SHOULD NOT<124> be emitted at this offset and SHOULD<125> be ignored. If lcbPgdMother
        /// is zero, fcPgdMother is undefined and MUST be ignored.
        self.fcPgdMother = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPgdMother (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated document page layout cache at
        /// offset fcPgdMother in the Table Stream.
        self.lcbPgdMother = try dataStream.read(endianess: .littleEndian)
        
        /// fcBkdMother (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated document text flow break
        /// cache begins at this offset. Information SHOULD NOT<126> be emitted at this offset and SHOULD<127> be ignored. If
        /// lcbBkdMother is zero, then fcBkdMother is undefined and MUST be ignored.
        self.fcBkdMother = try dataStream.read(endianess: .littleEndian)
        
        /// lcbBkdMother (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated document text flow break cache
        /// at offset fcBkdMother in the Table Stream.
        self.lcbBkdMother = try dataStream.read(endianess: .littleEndian)
        
        /// fcAfdMother (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated document author filter cache
        /// begins at this offset. Information SHOULD NOT<128> be emitted at this offset and SHOULD<129> be ignored. If lcbAfdMother is
        /// zero, then fcAfdMother is undefined and MUST be ignored.
        self.fcAfdMother = try dataStream.read(endianess: .littleEndian)
        
        /// lcbAfdMother (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated document author filter cache at
        /// offset fcAfdMother in the Table Stream.
        self.lcbAfdMother = try dataStream.read(endianess: .littleEndian)
        
        /// fcPgdFtn (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated footnote layout cache begins at
        /// this offset. Information SHOULD NOT<130> be emitted at this offset and SHOULD<131> be ignored. If lcbPgdFtn is zero, then
        /// fcPgdFtn is undefined and MUST be ignored.
        self.fcPgdFtn = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPgdFtn (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated footnote layout cache at offset fcPgdFtn
        /// in the Table Stream.
        self.lcbPgdFtn = try dataStream.read(endianess: .littleEndian)
        
        /// fcBkdFtn (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated footnote text flow break cache
        /// begins at this offset. Information SHOULD NOT<132> be emitted at this offset and SHOULD<133> be ignored. If lcbBkdFtn is
        /// zero, fcBkdFtn is undefined and MUST be ignored.
        self.fcBkdFtn = try dataStream.read(endianess: .littleEndian)
        
        /// lcbBkdFtn (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated footnote text flow break cache at offset
        /// fcBkdFtn in the Table Stream.
        self.lcbBkdFtn = try dataStream.read(endianess: .littleEndian)
        
        /// fcAfdFtn (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated footnote author filter cache
        /// begins at this offset. Information SHOULD NOT<134> be emitted at this offset and SHOULD<135> be ignored. If lcbAfdFtn is
        /// zero, fcAfdFtn is undefined and MUST be ignored.
        self.fcAfdFtn = try dataStream.read(endianess: .littleEndian)
        
        /// lcbAfdFtn (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated footnote author filter cache at offset
        /// fcAfdFtn in the Table Stream.
        self.lcbAfdFtn = try dataStream.read(endianess: .littleEndian)
        
        /// fcPgdEdn (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated endnote layout cache begins
        /// at this offset. Information SHOULD NOT<136> be emitted at this offset and SHOULD<137> be ignored. If lcbPgdEdn is zero, then
        /// fcPgdEdn is undefined and MUST be ignored.
        self.fcPgdEdn = try dataStream.read(endianess: .littleEndian)
        
        /// lcbPgdEdn (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated endnote layout cache at offset
        /// fcPgdEdn in the Table Stream.
        self.lcbPgdEdn = try dataStream.read(endianess: .littleEndian)
        
        /// fcBkdEdn (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated endnote text flow break
        /// cache begins at this offset. Information SHOULD NOT<138> be emitted at this offset and SHOULD<139> be ignored. If
        /// lcbBkdEdn is zero, fcBkdEdn is undefined and MUST be ignored.
        self.fcBkdEdn = try dataStream.read(endianess: .littleEndian)
        
        /// lcbBkdEdn (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated endnote text flow break cache at
        /// offset fcBkdEdn in the Table Stream.
        self.lcbBkdEdn = try dataStream.read(endianess: .littleEndian)
        
        /// fcAfdEdn (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Deprecated endnote author filter cache begins
        /// at this offset. Information SHOULD NOT<140> be emitted at this offset and SHOULD<141> be ignored. If lcbAfdEdn is zero, then
        /// fcAfdEdn is undefined and MUST be ignored.
        self.fcAfdEdn = try dataStream.read(endianess: .littleEndian)
        
        /// lcbAfdEdn (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated endnote author filter cache at offset
        /// fcAfdEdn in the Table Stream.
        self.lcbAfdEdn = try dataStream.read(endianess: .littleEndian)
        
        /// fcAfd (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A deprecated AFD structure begins at this offset.
        /// Information SHOULD NOT<142> be emitted at this offset and SHOULD<143> be ignored. If lcbAfd is zero, fcAfd is undefined
        /// and MUST be ignored.
        self.fcAfd = try dataStream.read(endianess: .littleEndian)
        
        /// lcbAfd (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated AFD structure at offset fcAfd in the
        /// Table Stream.
        self.lcbAfd = try dataStream.read(endianess: .littleEndian)
    }
}
