//
//  TBFlags.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.8 TBFlags
/// Referenced by: TB
/// Toolbar flags. The bit description begins from the least significant bit.
public struct TBFlags {
    public let fDisabled: Bool
    public let reserved1: Bool
    public let fCtlModified: Bool
    public let fNoAdaptiveMenus: Bool
    public let fNeedsPositioning: Bool
    public let reserved2: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fDisabled (1 bit): A bit that specifies whether this toolbar is disabled. A value of 1 specifies that this toolbar is disabled.
        self.fDisabled = flags.readBit()
        
        /// B - reserved1 (1 bit): Undefined and MUST be ignored.
        self.reserved1 = flags.readBit()
        
        /// C - fCtlModified (1 bit): A bit that specifies whether the toolbar controls of this toolbar have to be saved to the file. A value of 1 specifies
        /// that the toolbar controls of this toolbar have to be saved to the file. MAY be 0 and the toolbar MAY still save its toolbar controls to the
        /// file.<3>
        self.fCtlModified = flags.readBit()
        
        /// D - fNoAdaptiveMenus (1 bit): A bit that specifies whether adaptive menus are disabled for this toolbar. A value of 1 specifies that adaptive
        /// menus are disabled for this toolbar.
        self.fNoAdaptiveMenus = flags.readBit()
        
        /// E - fNeedsPositioning (1 bit): A bit that specifies whether the toolbar’s non-docked position needs to be updated for display on multiple
        /// monitors. A value of 1 specifies that the toolbar's nondocked position needs to be updated for display on multiple monitors.
        self.fNeedsPositioning = flags.readBit()
        
        /// reserved2 (11 bits): Reserved bits. MUST be 0.
        self.reserved2 = flags.readRemainingBits()
    }
}
