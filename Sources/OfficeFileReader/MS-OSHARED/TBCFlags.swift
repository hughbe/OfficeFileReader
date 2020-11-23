//
//  TBCFlags.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.3.1.11 TBCFlags
/// Referenced by: TBCHeader
/// Toolbar control flags. The bit description begins from the least significant bit
public struct TBCFlags {
    public let fHidden: Bool
    public let fBeginGroup: Bool
    public let fOwnLine: Bool
    public let fNoCustomize: Bool
    public let fSaveDxy: Bool
    public let reserved1: Bool
    public let fBeginLine: Bool
    public let reserved2: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fHidden (1 bit): A bit that specifies whether this toolbar control is visible. A value of 1 specifies that the toolbar control is not visible.
        self.fHidden = flags.readBit()
        
        /// B - fBeginGroup (1 bit): A bit that specifies whether a toolbar control separator appears before this toolbar control. A value of 1 specifies
        /// that a toolbar control separator appears before the toolbar control.
        self.fBeginGroup = flags.readBit()
    
        /// C - fOwnLine (1 bit): A bit that specifies whether the toolbar control requires its own row. A value of 1 specifies that the toolbar control
        /// requires its own row in the toolbar.
        self.fOwnLine = flags.readBit()
        
        /// D - fNoCustomize (1 bit): A bit that specifies whether this toolbar control can be altered by customization. A value of 1 specifies that
        /// the toolbar control cannot be altered by customization.
        self.fNoCustomize = flags.readBit()
        
        /// E - fSaveDxy (1 bit): A bit that specifies whether the width and height of the toolbar control have been saved to the file. A value of 1
        /// specifies that the width and height fields of the TBCHeader structure (section 2.3.1.10) that contains this structure MUST exist.
        self.fSaveDxy = flags.readBit()
        
        /// F - reserved1 (1 bit): Reserved bit. Undefined and MUST be ignored.
        self.reserved1 = flags.readBit()
        
        /// G - fBeginLine (1 bit): A bit that specifies whether the toolbar control begins a new row in the toolbar. A value of 1 specifies that the
        /// toolbar control begins a new row in the toolbar.
        self.fBeginLine = flags.readBit()
        
        /// H - reserved2 (1 bit): Reserved bit. MUST be 0.
        self.reserved2 = flags.readBit()
    }
}
