//
//  HresiOperand.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.118 HresiOperand
/// The HresiOperand structure specifies how word-breaking is handled.
public struct HresiOperand {
    public let hres: WordBreakingMethod
    public let chHres: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// Hres (1 byte): An unsigned integer that specifies the word-breaking method. This property MUST specify one of the following values.
        /// By default, normal word-breaking is used.
        let hresRaw: UInt8 = try dataStream.read()
        guard let hres = WordBreakingMethod(rawValue: hresRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.hres = hres
        
        /// ChHres (1 byte): An unsigned integer that specifies the ASCII character to be added to the text in addition to the hyphen. If Hres is set to
        /// hresNormal, ChHres MUST be 0x00; otherwise it MUST be a valid character.
        self.chHres = try dataStream.read(endianess: .littleEndian)
        if self.hres == .normal && self.chHres != 0x00 {
            throw OfficeFileError.corrupted
        }
    }
    
    public enum WordBreakingMethod: UInt8 {
        /// 0x01 hresNormal Normal word-breaking: Insert a hyphen and continue word on the next line.
        case normal = 0x01
        
        /// 0x02 hresAddBefore Similar to Normal but also add ChHres before the hyphen.
        case addBefore = 0x02
        
        /// 0x03 hresChangeBefore Similar to Normal but also change the character before the hyphen to ChHres.
        case changeBefore = 0x03
        
        /// 0x04 hresDeleteBefore Similar to Normal but also delete the character before the hyphen.
        case deleteBefore = 0x04
        
        /// 0x05 hresChangeAfter Similar to Normal but also change the character after the hyphen to ChHres.
        case changeAfter = 0x05
        
        /// 0x06 hresDelAndChange Similar to Normal but also delete two characters before the hyphen and replace them both with ChHres.
        case delAndChange = 0x06
    }
}
