//
//  HFDBits.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.116 HFDBits
/// The HFDBits structure specifies how to handle a hyperlink when it is traversed.
public struct HFDBits {
    public let fNew: Bool
    public let fNoHist: Bool
    public let fImageMap: Bool
    public let fLocation: Bool
    public let fTooltip: Bool
    public let unused: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fNew (1 bit): A bit that specifies if the hyperlink is to be opened in a new window.
        self.fNew = flags.readBit()
        
        /// B - fNoHist (1 bit): A bit that specifies if the navigation history is preserved when traversing this hyperlink. This value is 1 if the navigation history
        /// is not preserved and 0 if the navigation history is preserved.
        self.fNoHist = flags.readBit()
        
        /// C - fImageMap (1 bit): A bit that specifies if the hyperlink is a location in an HTML image map.
        self.fImageMap = flags.readBit()
        
        /// D - fLocation (1 bit): A bit that specifies if the hyperlink contains a specific location in the target document.
        self.fLocation = flags.readBit()
        
        /// E - fTooltip (1 bit): A bit that specifies if the hyperlink contains a ScreenTip string.
        self.fTooltip = flags.readBit()
        
        /// F - unused (3 bits): This value MUST be zero and MUST be ignored.
        self.unused = flags.readRemainingBits()
    }
}
