//
//  PChgTabsOperand.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.182 PChgTabsOperand
/// The PChgTabsOperand structure is used by sprmPChgTabs to specify a list of custom tab stops to add and another list of custom tab stops to ignore.
public struct PChgTabsOperand {
    public let cb: UInt8
    public let pChgTabsDelClose: PChgTabsDelClose
    public let pChgTabsAdd: PChgTabsAdd
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size of the operand. This value MUST be greater than or equal to 2 and less than or equal to 255.
        /// A value that is less than 255 specifies the size of the operand in bytes, not including cb. A value of 255 specifies that this instance of
        /// sprmPChgTabs MAY<232> be ignored and that the size of the remainder of this operand, in bytes, is calculated by using the following formula:
        self.cb = try dataStream.read()
        if self.cb < 2 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// PChgTabsDelClose (variable): A PchgTabsDelClose that specifies the locations of custom tab stops to ignore.
        self.pChgTabsDelClose = try PChgTabsDelClose(dataStream: &dataStream)
        
        /// PChgTabsAdd (variable): A PChgTabsAdd that specifies the locations and properties of custom tab stops to add.
        self.pChgTabsAdd = try PChgTabsAdd(dataStream: &dataStream)
        
        if self.cb != 0xFF {
            if dataStream.position - startPosition != self.cb {
                throw OfficeFileError.corrupted
            }
        } else {
            if dataStream.position - startPosition != 4 * self.pChgTabsDelClose.cTabs + 3 * self.pChgTabsAdd.cTabs {
                throw OfficeFileError.corrupted
            }
        }
    }
}
