//
//  StdfPost2000.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.261 StdfPost2000
/// The StdfPost2000 structure specifies general information about a style
public struct StdfPost2000 {
    public let istdLink: UInt16
    public let fHasOriginalStyle: Bool
    public let fSpare: UInt8
    public let rsid: UInt32
    public let iftcHtml: UInt8
    public let unused: Bool
    public let iPriority: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var rawValue: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// istdLink (12 bits): An unsigned integer that specifies the istd of the style that is linked to this one, or 0x0000 if this style is not linked
        /// to any other style in the document. The meaning of a linked style is as specified in [ECMA-376] part 4, section 2.7.3.6 (link).
        /// However, the style reference in that specification is a styleId rather than an istd, and an istdLink value of 0x0000 corresponds to
        /// omitting the link element.
        /// The istdLink value MUST be an index that refers to a valid non-empty style in the array of style definitions, or 0x0000.
        self.istdLink = rawValue.readBits(count: 12)
        
        /// A - fHasOriginalStyle (1 bit): Specifies whether the style is revision-marked. A revision-marked style stores the pre-revision
        /// formatting in addition to the current formatting. If this bit is set to 1, the cupx member of StdfBase MUST include the formatting
        /// sets that specify that pre-revision formatting.
        self.fHasOriginalStyle = rawValue.readBit()
        
        /// B - fSpare (3 bits): This value MUST be zero and MUST be ignored.
        self.fSpare = UInt8(rawValue.readBits(count: 3))
        
        /// rsid (4 bytes): An unsigned integer that specifies the revision save identifier of the session when this style definition was last modified,
        /// as specified in [ECMA-376] part 4, section 2.7.3.15 (rsid).
        self.rsid = try dataStream.read(endianess: .littleEndian)
        
        var flags2: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)

        /// C - iftcHtml (3 bits): This field is undefined and MUST be ignored.
        self.iftcHtml = UInt8(flags2.readBits(count: 3))
        
        /// D - unused (1 bit): This value MUST be zero and MUST be ignored.
        self.unused = flags2.readBit()
        
        /// iPriority (12 bits): An unsigned integer that specifies the priority value that is assigned to this style and that is used when ordering
        /// the styles by priority in the user interface, as specified in [ECMA376] part 4, section 2.7.3.19 (uiPriority).
        /// This MUST be a value between 0x0000 and 0x0063, inclusive.
        self.iPriority = flags2.readRemainingBits()
        if self.iPriority > 0x0063 {
            throw OfficeFileError.corrupted
        }
    }
}
