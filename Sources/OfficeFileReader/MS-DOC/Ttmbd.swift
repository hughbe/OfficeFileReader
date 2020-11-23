//
//  Ttmbd.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.331 Ttmbd
/// The Ttmbd structure specifies information about an embedded TrueType font, including where to locate the font in the document.
public struct Ttmbd {
    public let fc: UInt32
    public let iiffn: Int16
    public let fBold: Bool
    public let fItalic: Bool
    public let unnamed: UInt16
    public let fcSubset: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// fc (4 bytes): An unsigned integer value that specifies an offset into the WordDocument Stream where the embedded TrueType font is stored.
        /// This value MUST be nonzero. The font data that is stored at this offset is written as specified in [Embed-Open-Type-Format].
        self.fc = try dataStream.read(endianess: .littleEndian)
        if self.fc == 0 {
            throw OfficeFileError.corrupted
        }
        
        /// iiffn (2 bytes): A signed integer value that specifies an index into the SttbfFfn string table stored at FibRgFcLcb97.fcSttbfffn. This value
        /// MUST be a non-negative number.
        self.iiffn = try dataStream.read(endianess: .littleEndian)
        if self.iiffn < 0 {
            throw OfficeFileError.corrupted
        }
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fBold (1 bit): Specifies whether the font is bold.
        self.fBold = flags.readBit()
        
        /// B - fItalic (1 bit): Specifies whether the font is italic.
        self.fItalic = flags.readBit()
        
        /// unnamed (14 bits): Undefined and MUST be ignored.
        self.unnamed = flags.readRemainingBits()
        
        /// fcSubset (4 bytes): If entire fonts are embedded in the document, fcSubset MUST be 0xFFFFFFFF. If only the characters that are used
        /// by the document are embedded in the document, fcSubset is an unsigned integer that specifies the order in which fonts are first used.
        /// The first font to be used in the document has an fcSubset value that is equal to zero; all subsequent fonts are incremented by 1 in order
        /// of first use. fcSubset MUST be incremented for all fonts that are used in the document, including fonts that are not embedded in the
        /// document. This value MUST NOT exceed the total number of fonts used in the document.
        self.fcSubset = try dataStream.read(endianess: .littleEndian)
    }
}
