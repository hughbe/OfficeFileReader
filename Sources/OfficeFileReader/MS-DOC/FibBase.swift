//
//  FibBase.swift
//  
//
//  Created by Hugh Bellamy on 05/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.2 FibBase
/// The FibBase structure is the fixed-size portion of the Fib.
public struct FibBase {
    public let ident: UInt16
    public let nFib: UInt16
    public let unused: UInt16
    public let lid: LID
    public let pnNext: UInt16
    public let fDot: Bool
    public let fGlsy: Bool
    public let fComplex: Bool
    public let fHasPic: Bool
    public let cQuickSaves: UInt8
    public let fEncrypted: Bool
    public let fWhichTblStm: Bool
    public let fReadOnlyRecommended: Bool
    public let fWriteReservation: Bool
    public let fExtChar: Bool
    public let fLoadOverride: Bool
    public let fFarEast: Bool
    public let fObfuscated: Bool
    public let nFibBack: UInt16
    public let lKey: UInt32
    public let envr: UInt8
    public let fMac: Bool
    public let fEmptySpecial: Bool
    public let fLoadOverridePage: Bool
    public let reserved1: Bool
    public let reserved2: Bool
    public let fSpare0: UInt8
    public let reserved3: UInt16
    public let reserved4: UInt16
    public let reserved5: UInt32
    public let reserved6: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// Ident (2 bytes): An unsigned integer that specifies that this is a Word Binary File. This value MUST be 0xA5EC.
        self.ident = try dataStream.read(endianess: .littleEndian)
        if self.ident != 0xA5EC {
            throw OfficeFileError.corrupted
        }
        
        /// nFib (2 bytes): An unsigned integer that specifies the version number of the file format used.
        /// Superseded by FibRgCswNew.nFibNew if it is present. This value SHOULD<12> be 0x00C1.
        self.nFib = try dataStream.read(endianess: .littleEndian)
        
        /// unused (2 bytes): This value is undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        /// lid (2 bytes): A LID that specifies the install language of the application that is producing the document. If nFib is 0x00D9 or greater,
        /// then any East Asian install lid or any install lid with a base language of Spanish, German or French MUST be recorded as lidAmerican.
        /// If the nFib is 0x0101 or greater, then any install lid with a base language of Vietnamese, Thai, or Hindi MUST be recorded as lidAmerican.
        self.lid = try dataStream.read(endianess: .littleEndian)
        
        /// pnNext (2 bytes): An unsigned integer that specifies the offset in the WordDocument stream of the FIB for the document which
        /// contains all the AutoText items. If this value is 0, there are no AutoText items attached. Otherwise the FIB is found at file location
        /// pnNext×512. If fGlsy is 1 or fDot is 0, this value MUST be 0. If pnNext is not 0, each FIB MUST share the same values for
        /// FibRgFcLcb97.fcPlcBteChpx, FibRgFcLcb97.lcbPlcBteChpx, FibRgFcLcb97.fcPlcBtePapx, FibRgFcLcb97.lcbPlcBtePapx, and
        /// FibRgLw97.cbMac.
        self.pnNext = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fDot (1 bit): Specifies whether this is a document template.
        self.fDot = flags.readBit()
        
        /// B - fGlsy (1 bit): Specifies whether this is a document that contains only AutoText items (see FibRgFcLcb97.fcSttbfGlsy,
        /// FibRgFcLcb97.fcPlcfGlsy and FibRgFcLcb97.fcSttbGlsyStyle).
        self.fGlsy = flags.readBit()
        
        /// C - fComplex (1 bit): Specifies that the last save operation that was performed on this document was an incremental save operation.
        self.fComplex = flags.readBit()
        
        /// D - fHasPic (1 bit): When set to 0, there SHOULD<13> be no pictures in the document.
        self.fHasPic = flags.readBit()
        
        /// E - cQuickSaves (4 bits): An unsigned integer. If nFib is less than 0x00D9, then cQuickSaves specifies the number of consecutive
        /// times this document was incrementally saved. If nFib is 0x00D9 or greater, then cQuickSaves MUST be 0xF.
        self.cQuickSaves = UInt8(flags.readBits(count: 4))
        
        /// F - fEncrypted (1 bit): Specifies whether the document is encrypted or obfuscated as specified in Encryption and Obfuscation.
        self.fEncrypted = flags.readBit()
        
        /// G - fWhichTblStm (1 bit): Specifies the Table stream to which the FIB refers. When this value is set to 1, use 1Table; when this value
        /// is set to 0, use 0Table.
        self.fWhichTblStm = flags.readBit()
        
        /// H - fReadOnlyRecommended (1 bit): Specifies whether the document author recommended that the document be opened in
        /// read-only mode.
        self.fReadOnlyRecommended = flags.readBit()
        
        /// I - fWriteReservation (1 bit): Specifies whether the document has a write-reservation password.
        self.fWriteReservation = flags.readBit()
        
        /// J - fExtChar (1 bit): This value MUST be 1.
        self.fExtChar = flags.readBit()
        
        /// K - fLoadOverride (1 bit): Specifies whether to override the language information and font that are specified in the paragraph style
        /// at istd 0 (the normal style) with the defaults that are appropriate for the installation language of the application.
        self.fLoadOverride = flags.readBit()
        
        /// L - fFarEast (1 bit): Specifies whether the installation language of the application that created the document was an East Asian language.
        self.fFarEast = flags.readBit()
        
        /// M - fObfuscated (1 bit): If fEncrypted is 1, this bit specifies whether the document is obfuscated by using XOR obfuscation
        /// (section 2.2.6.1); otherwise, this bit MUST be ignored.
        self.fObfuscated = flags.readBit()
        
        /// nFibBack (2 bytes): This value SHOULD<14> be 0x00BF. This value MUST be 0x00BF or 0x00C1.
        let nFibBack: UInt16 = try dataStream.read(endianess: .littleEndian)
        if nFibBack != 0x00BF && nFibBack != 0x00C1 {
            throw OfficeFileError.corrupted
        }
        
        self.nFibBack = nFibBack
        
        /// lKey (4 bytes): If fEncrypted is 1 and fObfuscation is 1, this value specifies the XOR obfuscation (section 2.2.6.1) password verifier.
        /// If fEncrypted is 1 and fObfuscation is 0, this value specifies the size of the EncryptionHeader that is stored at the beginning of the
        /// Table stream as described in Encryption and Obfuscation. Otherwise, this value MUST be 0.
        self.lKey = try dataStream.read(endianess: .littleEndian)
        
        /// envr (1 byte): This value MUST be 0, and MUST be ignored.
        self.envr = try dataStream.read()
        
        var flags2: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// N - fMac (1 bit): This value MUST be 0, and MUST be ignored.
        self.fMac = flags2.readBit()
        
        /// O - fEmptySpecial (1 bit): This value SHOULD<15> be 0 and SHOULD<16> be ignored.
        self.fEmptySpecial = flags2.readBit()
        
        /// P - fLoadOverridePage (1 bit): Specifies whether to override the section properties for page size, orientation, and margins with the
        /// defaults that are appropriate for the installation language of the application.
        self.fLoadOverridePage = flags2.readBit()
        
        /// Q - reserved1 (1 bit): This value is undefined and MUST be ignored.
        self.reserved1 = flags2.readBit()
        
        /// R - reserved2 (1 bit): This value is undefined and MUST be ignored.
        self.reserved2 = flags2.readBit()
        
        /// S - fSpare0 (3 bits): This value is undefined and MUST be ignored.
        self.fSpare0 = flags2.readRemainingBits()
        
        /// reserved3 (2 bytes): This value MUST be 0 and MUST be ignored.
        self.reserved3 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved4 (2 bytes): This value MUST be 0 and MUST be ignored.
        self.reserved4 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved5 (4 bytes): This value is undefined and MUST be ignored.
        self.reserved5 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved6 (4 bytes): This value is undefined and MUST be ignored.
        self.reserved6 = try dataStream.read(endianess: .littleEndian)
    }
}
