//
//  MapMode.swift
//  
//
//  Created by Hugh Bellamy on 17/11/2020.
//

/// [MS-WMF] 2.1.1.16 MapMode Enumeration
/// The MapMode Enumeration defines how logical units are mapped to physical units; that is, assuming that the origins in both the logical and physical
/// coordinate systems are at the same point on the drawing surface, what is the physical coordinate (x',y') that corresponds to logical coordinate (x,y).
/// For example, suppose the mapping mode is MM_TEXT. Given the following definition of that mapping mode, and an origin (0,0) at the top left corner
/// of the drawing surface, logical coordinate (4,5) would map to physical coordinate (4,5) in pixels.
/// Now suppose the mapping mode is MM_LOENGLISH, with the same origin as the previous example.
/// Given the following definition of that mapping mode, logical coordinate (4,-5) would map to physical coordinate (0.04,0.05) in inches.
/// typedef enum
/// {
///  MM_TEXT = 0x0001,
///  MM_LOMETRIC = 0x0002,
///  MM_HIMETRIC = 0x0003,
///  MM_LOENGLISH = 0x0004,
///  MM_HIENGLISH = 0x0005,
///  MM_TWIPS = 0x0006,
///  MM_ISOTROPIC = 0x0007,
///  MM_ANISOTROPIC = 0x0008
/// } MapMode;
public enum MapMode: UInt16 {
    /// MM_TEXT: Each logical unit is mapped to one device pixel. Positive x is to the right; positive y is down.
    case text = 0x0001
    
    /// MM_LOMETRIC: Each logical unit is mapped to 0.1 millimeter. Positive x is to the right; positive y is up.
    case loMetric = 0x0002
    
    /// MM_HIMETRIC: Each logical unit is mapped to 0.01 millimeter. Positive x is to the right; positive y is up.
    case hiMetric = 0x0003
    
    /// MM_LOENGLISH: Each logical unit is mapped to 0.01 inch. Positive x is to the right; positive y is up.
    case loEnglish = 0x0004
    
    /// MM_HIENGLISH: Each logical unit is mapped to 0.001 inch. Positive x is to the right; positive y is up.
    case hiEnglish = 0x0005
    
    /// MM_TWIPS: Each logical unit is mapped to one twentieth (1/20) of a point. In printing, a point is 1/72 of an inch; therefore, 1/20 of a point is
    /// 1/1440 of an inch. This unit is also known as a "twip".
    /// Positive x is to the right; positive y is up.
    case twips = 0x0006
    
    /// MM_ISOTROPIC: Logical units are mapped to arbitrary device units with equally scaled axes; that is, one unit along the x-axis is equal to one
    /// unit along the y-axis. The META_SETWINDOWEXT (section 2.3.5.30) and META_SETVIEWPORTEXT (section 2.3.5.28) records specify the units
    /// and the orientation of the axes.
    /// The processing application SHOULD make adjustments as necessary to ensure the x and y units remain the same size. For example, when the
    /// window extent is set, the viewport SHOULD be adjusted to keep the units isotropic.
    case isotropic = 0x0007
    
    /// MM_ANISOTROPIC: Logical units are mapped to arbitrary units with arbitrarily scaled axes.
    case anisotropic = 0x0008
}
