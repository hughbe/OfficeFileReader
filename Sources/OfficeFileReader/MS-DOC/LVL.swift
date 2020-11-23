//
//  LVL.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

public struct LVL {
    public let lvlf: LVLF
    public let grpprlPapx: [Prl]
    public let grpprlChpx: [Prl]
    public let xst: Xst
    
    public init(dataStream: inout DataStream) throws {
        /// lvlf (28 bytes): An LVLF structure that specifies formatting information for this level.
        self.lvlf = try LVLF(dataStream: &dataStream)
        
        /// grpprlPapx (variable): An array of Prl elements that specifies the paragraph formatting of a paragraph in this level. The size of grpprlPapx
        /// is specified by lvlf.cbGrpprlPapx.
        var grpprlPapx: [Prl] = []
        grpprlPapx.reserveCapacity(Int(self.lvlf.cbGrpprlPapx))
        for _ in 0..<self.lvlf.cbGrpprlPapx {
            grpprlPapx.append(try Prl(dataStream: &dataStream))
        }
        
        self.grpprlPapx = grpprlPapx
        
        /// grpprlChpx (variable): An array of Prl elements that specifies the character formatting of the number text that begins each paragraph in this level.
        /// The size of grpprlChpx is specified by lvlf.cbGrpprlChpx.
        var grpprlChpx: [Prl] = []
        grpprlChpx.reserveCapacity(Int(self.lvlf.cbGrpprlChpx))
        for _ in 0..<self.lvlf.cbGrpprlChpx {
            grpprlChpx.append(try Prl(dataStream: &dataStream))
        }
        
        self.grpprlChpx = grpprlChpx
        
        /// xst (variable): An Xst that specifies the number text that begins each paragraph in this level. This can contain placeholders for level numbers
        /// that are inherited from the other paragraphs in the list. Any element in the rgtchar field of this Xst can be a placeholder. Each placeholder is
        /// an unsigned 2-byte integer that specifies the zero-based level that the placeholder is for. Each placeholder MUST have a value that is less
        /// than or equal to the zero-based level of the list that this LVL represents. The indexes of the placeholders are specified by lvlf.rgbxchNums.
        /// Placeholders that correspond to levels that do not have a number sequence (see lvlf.nfc) MUST be ignored. If this level uses bullets (see lvlf.nfc),
        /// the cch field of this Xst MUST be equal to 0x0001, and this MUST NOT contain any placeholders.
        self.xst = try Xst(dataStream: &dataStream)
    }
}
