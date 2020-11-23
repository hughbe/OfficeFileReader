//
//  DispFldRmOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.54 DispFldRmOperand
/// The DispFldRmOperand structure is an operand that is used by sprmCDispFldRMark and specifies whether the result of a LISTNUM display
/// field contains a revision.
public struct DispFldRmOperand {
    public let cb: UInt8
    public let f: UInt8
    public let ibstshort: UInt16
    public let dttm: DTTM
    public let xst: Xst
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size, in bytes, of the remainder of this structure. This value MUST be 39.
        self.cb = try dataStream.read()
        if self.cb != 39 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// f (1 byte): An unsigned integer that specifies whether there is a revision in the result of this LISTNUM display field. Any nonzero value
        /// specifies that there is a revision. A value of zero specifies that there are no revisions in the result of this field.
        self.f = try dataStream.read()
        
        /// ibstshort (2 bytes): An unsigned integer that specifies the index into SttbfRMark. The value in the string table at index istbshort specifies
        /// the author who made this revision.
        self.ibstshort = try dataStream.read(endianess: .littleEndian)
        
        /// dttm (4 bytes): A DTTM that specifies the time of the revision.
        self.dttm = try DTTM(dataStream: &dataStream)
        
        /// xst (32 bytes): A 15-character XST that specifies the previous result of this LISTNUM display field.
        self.xst = try Xst(dataStream: &dataStream)
        if self.xst.rgtchar.count != 15 {
            throw OfficeFileError.corrupted
        }
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
