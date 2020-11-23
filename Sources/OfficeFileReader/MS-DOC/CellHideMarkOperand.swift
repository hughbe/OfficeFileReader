//
//  CellHideMarkOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.26 CellHideMarkOperand
/// The CellHideMarkOperand structure is an operand that is used by sprmTCellFHideMark. This operand specifies which cells are rendered
/// with no height when cells are empty.
public struct CellHideMarkOperand {
    public let cb: UInt8
    public let itc: ItcFirstLim
    public let bArg: Bool8
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size of this operand in bytes, not including cb. cb MUST be 3.
        self.cb = try dataStream.read()
        if self.cb != 3 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// itc (2 bytes): An ItcFirstLim that specifies which cells this CellHideMarkOperand applies to.
        self.itc = try ItcFirstLim(dataStream: &dataStream)
        
        /// bArg (1 byte): A Bool8 that specifies whether cells itc.itcFirst throug
        self.bArg = try dataStream.read()
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
