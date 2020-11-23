//
//  StdfBase.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.260 StdfBase
/// The StdfBase structure specifies general information about a style.
public struct StdfBase {
    public let sti: UInt16
    public let fScratch: Bool
    public let fInvalHeight: Bool
    public let fHasUpe: Bool
    public let fMassCopy: Bool
    public let stk: StyleType
    public let istdBase: UInt16
    public let cupx: UInt8
    public let istdNext: UInt16
    public let bchUpe: UInt16
    public let grfstd: GRFSTD
    
    public init(dataStream: inout DataStream) throws {
        var flags1: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// sti (12 bits): An unsigned integer that specifies the invariant style identifier for application-defined styles, or 0x0FFE for user-defined
        /// styles.
        /// The sti identifies which styles in the stylesheet correspond to which application-defined styles. An application-defined style can
        /// have different names in different languages, but it MUST have the same sti value regardless of language. The sti values correspond
        /// to the "Index within Built-in Styles" table column that is specified in [ECMA-376] part 4, section 2.7.3.9 (name).
        self.sti = flags1.readBits(count: 12)
        
        /// A - fScratch (1 bit): This bit is undefined and MUST be ignored.
        self.fScratch = flags1.readBit()
        
        /// B - fInvalHeight (1 bit): Specifies whether the paragraph height information in the fcPlcfPhe field of FibRgFcLcb97, for any paragraphs
        /// having this paragraph style, MUST be ignored. SHOULD<240> be 0.
        self.fInvalHeight = flags1.readBit()
        
        /// C - fHasUpe (1 bit): This bit is undefined and MUST be ignored.
        self.fHasUpe = flags1.readBit()
        
        /// D - fMassCopy (1 bit): This bit is undefined and MUST be ignored.
        self.fMassCopy = flags1.readBit()
        
        var flags2: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)

        /// stk (4 bits): An unsigned integer that specifies the type of this style, which corresponds to the "type" attribute of the style element
        /// as specified in [ECMA-376] part 4, section 2.7.3.17 (Style Definition). This MUST be one of the following values:
        /// Value Meaning
        /// 1 Paragraph style, as specified by the "paragraph" value in [ECMA-376] part 4, section 2.18.90 (ST_StyleType).
        /// 2 Character style, as specified by the "character" value in [ECMA-376] part 4, section 2.18.90 (ST_StyleType).
        /// 3 Table style, as specified by the "table" value in [ECMA-376] part 4, section 2.18.90 (ST_StyleType).
        /// 4 Numbering style, as specified by the "numbering" value in [ECMA-376] part 4, section 2.18.90 (ST_StyleType).
        let stkRaw = UInt8(flags2.readBits(count: 4))
        guard let stk = StyleType(rawValue: stkRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.stk = stk
        
        /// istdBase (12 bits): An unsigned integer that specifies the istd (see the rglpstd array in the STSH structure) of the parent style from
        /// which this style inherits in the style inheritance tree, or 0x0FFF if this style does not inherit from any other style in the current
        /// document. The meaning of the parent style is specified in the basedOn element in [ECMA-376] part 4, section 2.7.3.3. However,
        /// the style reference in that specification is a styleId rather than an istd, and an istdBase value of 0x0FFF corresponds to omitting
        /// the basedOn element.
        /// The istdBase value MUST be an index that refers to a valid non-empty style in the array of style definitions. The istdBase value
        /// MUST NOT be the same as the istd of the current style and MUST NOT cause a loop in the style inheritance tree.
        self.istdBase = flags2.readBits(count: 12)
        
        var flags3: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)

        /// cupx (4 bits): An unsigned integer that specifies the count of formatting sets inside the structure, specified to style type, that is
        /// contained in the GrLPUpxSw.
        /// Each type of style contains a different structure within GrLPUpxSw, as shown in the following table. The cupx value specifies the
        /// count of structures within the structure that is contained in the GrLPUpxSw. For each type of style, the cupx MUST be equal to
        /// the values that are shown in the table, depending on whether the style is revision-marked (in a revision-marked style the
        /// fHasOriginalStyle value in StdfPost2000 is 1; in a non-revision-marked style the value is 0.)
        /// Table and numbering styles MUST NOT be revision-marked.
        /// stk value GrLPUpxSw contains cupx for non-revisionmarked style cupx for revisionmarked-style
        /// 1 (paragraph) StkParaGRLPUPX 2 3
        /// 2 (character) StkCharGRLPUPX 1 2
        /// 3 (table) StkTableGRLPUPX 3 N/A
        /// 4 (numbering) StkListGRLPUPX 1 N/A
        self.cupx = UInt8(flags3.readBits(count: 4))
        
        /// istdNext (12 bits): An unsigned integer that specifies the istd (see rglpstd in STSH) of the style which is automatically applied to
        /// a new paragraph created following a paragraph with the current style, as specified in more detail in [ECMA-376] part 4, section
        /// 2.7.3.10 (next). However, the style reference in that specification is a styleId rather than an istd.
        /// The istdNext value MUST be an index that refers to a valid non-empty style in the array of style definitions.
        self.istdNext = flags3.readBits(count: 12)
        
        /// bchUpe (2 bytes): An unsigned integer that specifies the size, in bytes, of std in LPStd. This value MUST be equal to cbStd in LPStd.
        self.bchUpe = try dataStream.read(endianess: .littleEndian)
        
        /// grfstd (2 bytes): A GRFSTD that specifies miscellaneous style properties.
        self.grfstd = try GRFSTD(dataStream: &dataStream)
    }
    
    public enum StyleType: UInt8 {
        /// 1 Paragraph style, as specified by the "paragraph" value in [ECMA-376] part 4, section 2.18.90 (ST_StyleType).
        case paragraph = 1
        
        /// 2 Character style, as specified by the "character" value in [ECMA-376] part 4, section 2.18.90 (ST_StyleType).
        case character = 2
        
        /// 3 Table style, as specified by the "table" value in [ECMA-376] part 4, section 2.18.90 (ST_StyleType).
        case table = 3
        
        /// 4 Numbering style, as specified by the "numbering" value in [ECMA-376] part 4, section 2.18.90 (ST_StyleType).
        case numbering = 4
    }
}
