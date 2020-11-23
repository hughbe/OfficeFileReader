//
//  PChgTabsPapxOperand.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.183 PChgTabsPapxOperand
/// The PChgTabsPapxOperand structure is used by sprmPChgTabsPapx to specify custom tab stops to be added or ignored.
public struct PChgTabsPapxOperand {
    public let cb: UInt8
    public let pChgTabsDel: PChgTabsDel
    public let pChgTabsAdd: PChgTabsAdd
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size of the operand in bytes, not including cb. This value MUST be greater than or equal to 2
        /// and less than or equal to 255.
        self.cb = try dataStream.read()
        if self.cb < 2 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PChgTabsDel (variable): A PChgTabsDel structure that specifies the locations at which custom tab stops are ignored.
        self.pChgTabsDel = try PChgTabsDel(dataStream: &dataStream)
        
        /// PChgTabsAdd (variable): A PChgTabsAdd structure that specifies the locations and properties of custom tab stops to be added.
        self.pChgTabsAdd = try PChgTabsAdd(dataStream: &dataStream)
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
