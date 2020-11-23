//
//  Spa.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.253 Spa
/// The Spa structure specifies information about the shapes and drawings that the document contains.
public struct Spa {
    public let lid: UInt32
    public let rca: Rca
    public let fHdr: Bool
    public let bx: HorizontalPosition
    public let by: VerticalPosition
    public let wr: WordWrappingStyle
    public let wrk: WordWrappingDetails
    public let fRcaSimple: Bool
    public let fBelowText: Bool
    public let fAnchorLock: Bool
    public let cTxbx: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// lid (4 bytes): An integer that specifies the identifier of a shape that is contained in the OfficeArtDggContainer structure. This value
        /// corresponds to the spid field of an OfficeArtFSP structure that specifies the data for this shape. OfficeArtDggContainer and OfficeArtFSP
        /// are specified in [MS-ODRAW] sections 2.2.12 and 2.2.40, respectively.
        self.lid = try dataStream.read(endianess: .littleEndian)
        
        /// rca (16 bytes): An Rca structure that specifies the rectangle where the drawing exists. The coordinates of rca are in twips.
        self.rca = try Rca(dataStream: &dataStream)
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fHdr (1 bit): This bit is undefined and MUST be ignored.
        self.fHdr = flags.readBit()
        
        /// bx (2 bits): An unsigned integer that specifies the horizontal position of the origin that is used to calculate the rca. This MUST be one
        /// of the following values.
        let bxRaw = UInt8(flags.readBits(count: 2))
        guard let bx = HorizontalPosition(rawValue: bxRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.bx = bx
        
        /// by (2 bits): An unsigned integer that specifies the vertical position of the origin that is used to calculate the rca. This MUST be one of
        /// the following values.
        let byRaw = UInt8(flags.readBits(count: 2))
        guard let by = VerticalPosition(rawValue: byRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.by = by
        
        /// wr (4 bits): An unsigned integer that specifies the style of text wrapping around this shape. This MUST be one of the following values.
        let wrRaw = UInt8(flags.readBits(count: 4))
        guard let wr = WordWrappingStyle(rawValue: wrRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.wr = wr
        
        /// wrk (4 bits): An unsigned integer that specifies the details of the text wrapping around this shape. This field MUST be ignored when wr
        /// is 1 or 3. This MUST be one of the following values.
        let wrkRaw = UInt8(flags.readBits(count: 4))
        guard let wrk = WordWrappingDetails(rawValue: wrkRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.wrk = wrk
        
        /// B - fRcaSimple (1 bit): MUST be zero.
        self.fRcaSimple = flags.readBit()
        if self.fRcaSimple {
            throw OfficeFileError.corrupted
        }
        
        /// C - fBelowText (1 bit): An unsigned integer that specifies whether this shape is behind the text. A value of 1 specifies that the shape
        /// appears behind the paragraph. A value of 0 specifies that the shape appears in front of the text and obscures it. If wr is not 3, this
        /// field MUST be ignored.
        self.fBelowText = flags.readBit()
        
        /// D - fAnchorLock (1 bit): An unsigned integer that specifies whether the anchor of the shape is locked to its current paragraph.
        self.fAnchorLock = flags.readBit()
        
        /// cTxbx (4 bytes): This value is undefined and MUST be ignored.
        self.cTxbx = try dataStream.read(endianess: .littleEndian)
    }
    
    /// bx (2 bits): An unsigned integer that specifies the horizontal position of the origin that is used to calculate the rca. This MUST be one of the
    /// following values.
    public enum HorizontalPosition: UInt8 {
        /// 0 Anchored at the leading margin of the page.
        case leadingMarginOfPage = 0
        
        /// 1 Anchored at the leading edge of the page.
        case leadingEdgeOfPage = 1
        
        /// 2 Anchored at the leading edge of the column.
        case leadingEdgeOfColumn = 2
    }
    
    /// by (2 bits): An unsigned integer that specifies the vertical position of the origin that is used to calculate the rca. This MUST be one of the
    /// following values.
    public enum VerticalPosition: UInt8 {
        /// 0 Anchored at the top margin of the page.
        case topMarginOfPage = 0
        
        /// 1 Anchored at the top edge of the page.
        case topEdgeOfPage = 1
        
        /// 2 Anchored at the top edge of the paragraph.
        case topEdgeOfParagraph = 2
    }
    
    /// wr (4 bits): An unsigned integer that specifies the style of text wrapping around this shape. This MUST be one of the following values.
    public enum WordWrappingStyle: UInt8 {
        /// 0 Wrap text around the object.
        case aroundObject = 0
        
        /// 1 No text wrapping around the object. No text appears on either side of the shape (top and bottom wrapping).
        case none = 1
        
        /// 2 Wrap text around an absolutely positioned object (square wrapping).
        case square = 2
        
        /// 3 Display as if the shape is not there. The shape appears either in front of or behind the text, based on fBelowText.
        case inFrontOrBehind = 3
                
        /// 4 Wrap text tightly around this shape, following its contour only on the left and right sides (tight wrapping).
        case tight = 4
        
        /// 5 Wrap text tightly around this shape, following its contour on all sides (through wrapping).
        case through = 5
    }
    
    /// wrk (4 bits): An unsigned integer that specifies the details of the text wrapping around this shape. This field MUST be ignored when wr is 1 or 3.
    /// This MUST be one of the following values.
    public enum WordWrappingDetails: UInt8 {
        /// 0 Allow text wrapping on both sides of the shape.
        case bothSides = 0
        
        /// 1 Allow text wrapping only on the left side of the shape.
        case leftSide = 1
        
        /// 2 Allow text wrapping only on the right side of the shape.
        case rightSide = 2
        
        /// 3 Allow text wrapping only on the largest side of the shape.
        case largestSide = 3
    }
}
