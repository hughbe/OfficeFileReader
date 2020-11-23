//
//  Tbkd.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.312 Tbkd
/// The Tbkd structure is used by the PlcftxbxBkd and PlcfTxbxHdrBkd structures to associate ranges of text from the Textboxes Document and the Header
/// Textboxes Document with FTXBXS objects. Ranges of text from the Textboxes Document are associated with FTXBXS objects from PlcftxbxTxt;
/// ranges of text from the Header Textboxes Document are associated with FTXBXS objects from PlcfHdrtxbxTxt.
public struct Tbkd {
    public let itxbxs: Int16
    public let dcpDepend: UInt16
    public let reserved1: UInt16
    public let fMarkDelete: Bool
    public let fUnk: Bool
    public let fTextOverflow: Bool
    public let reserved2: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// itxbxs (2 bytes): A signed integer that specifies the index of an FTXBXS object within the PlcftxbxTxt structure or the PlcfHdrtxbxTxt structure.
        /// The text range of this Tbkd object MUST be the same as the text range of the FTXBXS object, or else it MUST be a subset of that range.
        /// When the FTXBXS object specifies a chain of linked textboxes, the text range of each component textbox MUST be represented by its own
        /// Tbkd object and a discrete text range. In all but the last Tbkd object, itxbxs MUST be a valid FTXBXS index. The final Tbkd is not associated
        /// with any FTXBXS object. The itxbxs value for the final Tbkd MUST be ignored.
        self.itxbxs = try dataStream.read(endianess: .littleEndian)
        
        /// dcpDepend (2 bytes): Specifies version-specific information about the quantity of text that was processed. This makes it possible to identify the
        /// end of the corresponding text range. This value SHOULD<257> be zero and SHOULD<258> be ignored.
        self.dcpDepend = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// reserved1 (10 bits): This value MUST be zero and MUST be ignored.
        self.reserved1 = flags.readBits(count: 10)
        
        /// A - fMarkDelete (1 bit): This value MUST be zero and MUST be ignored.
        self.fMarkDelete = flags.readBit()
        
        /// B - fUnk (1 bit): Specifies version-specific information that flags the text range which corresponds to this Tbkd as not being used by a textbox.
        /// This value SHOULD<259> be zero and SHOULD<260> be ignored.
        self.fUnk = flags.readBit()
        
        /// C - fTextOverflow (1 bit): Specifies version-specific information about whether the text that is associated with a textbox exceeds the amount that
        /// fits into the associated shape. This value SHOULD<261> be zero and SHOULD<262> be ignored.
        self.fTextOverflow = flags.readBit()
        
        /// D - reserved2 (3 bits): This value MUST be zero and MUST be ignored.
        self.reserved2 = UInt8(flags.readBits(count: 3))
    }
}
