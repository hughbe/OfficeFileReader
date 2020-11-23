//
//  BrushStyle.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-WMF] 2.1.1.4 BrushStyle Enumeration
/// The BrushStyle Enumeration specifies the different possible brush types that can be used in graphics operations. For more information, see the specification
/// of the Brush Object (section 2.2.1.1).
/// typedef enum
/// {
///  BS_SOLID = 0x0000,
///  BS_NULL = 0x0001,
///  BS_HATCHED = 0x0002,
///  BS_PATTERN = 0x0003,
///  BS_INDEXED = 0x0004,
///  BS_DIBPATTERN = 0x0005,
///  BS_DIBPATTERNPT = 0x0006,
///  BS_PATTERN8X8 = 0x0007,
///  BS_DIBPATTERN8X8 = 0x0008,
///  BS_MONOPATTERN = 0x0009
/// } BrushStyle;
public enum BrushStyle: UInt16 {
    /// BS_SOLID: A brush that paints a single, constant color, either solid or dithered.
    case solid = 0x0000
    
    /// BS_NULL: A brush that does nothing. Using a BS_NULL brush in a graphics operation MUST have the same effect as using no brush at all.<5>
    case null = 0x0001
    
    /// BS_HATCHED: A brush that paints a predefined simple pattern, or "hatch", onto a solid background.
    case hatched = 0x0002
    
    /// BS_PATTERN: A brush that paints a pattern defined by a bitmap, which can be a Bitmap16 Object (section 2.2.2.1) or a DeviceIndependentBitmap
    /// Object (section 2.2.2.9).
    case pattern = 0x0003
    
    /// BS_INDEXED: Not supported.
    case indexed = 0x0004
    
    /// BS_DIBPATTERN: A pattern brush specified by a DIB.
    case dibPattern = 0x0005
    
    /// BS_DIBPATTERNPT: A pattern brush specified by a DIB.
    case dibPatternPt = 0x0006
    
    /// BS_PATTERN8X8: Not supported.
    case pattern8X8 = 0x0007
    
    /// BS_DIBPATTERN8X8: Not supported.
    case dibPattern8X8 = 0x0008
    
    /// BS_MONOPATTERN: Not supported.
    case monoPattern = 0x0009
}
