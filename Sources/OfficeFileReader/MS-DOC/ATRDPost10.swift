//
//  ATRDPost10.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.6 ATRDPost10
/// The ATRDPost10 structure represents information about a comment that includes a date and time stamp, information about whether the comment was
/// inked, and the tree structure of the comments. See the description of AtrdExtra for more about the tree layout. The location of the comment about
/// which an ATRDPost10 contains information is specified by the CP corresponding to the ATRDPre10 in the PlcfandRef specified by fcPlcfandRef in
/// FibRgFcLcb97 with the same index as the ATRDPost10.
public struct ATRDPost10 {
    public let dttm: DTTM
    public let padding1: UInt16
    public let cDepth: UInt32
    public let diatrdParent: UInt32
    public let fOWSDiscussionItem: Bool
    public let fInkAtn: Bool
    public let padding2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// dttm (4 bytes): A DTTM specifying the date and time on which this comment was last created or modified.
        self.dttm = try DTTM(dataStream: &dataStream)
        
        /// padding1 (16 bits): This value MUST be zero, and MUST be ignored.
        self.padding1 = try dataStream.read(endianess: .littleEndian)
        
        /// cDepth (4 bytes): The depth of this comment in the tree. If cDepth is 0, this comment has no parent and diatrdParent MUST be equal to zero.
        /// If this comment has a parent then cDepth MUST be equal to the cDepth value of the parent incremented by 1.
        self.cDepth = try dataStream.read(endianess: .littleEndian)
        
        /// diatrdParent (4 bytes): The offset in the Table Stream of the parent of this comment in the tree. The parent is located 18*diatrdParent bytes from
        /// the position of this comment. If diatrdParent is negative, the parent is located earlier in the stream; if diatrdParent is positive, the parent is
        /// located later in the stream. If diatrdParent is 0, this comment has no parent and cDepth MUST be equal to zero.
        let diatrdParent: UInt32 = try dataStream.read(endianess: .littleEndian)
        if self.cDepth == 0 && diatrdParent != 0 {
            throw OfficeFileError.corrupted
        }
        
        self.diatrdParent = diatrdParent
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fOWSDiscussionItem (1 bit): This value MUST be zero, and MUST be ignored.
        self.fOWSDiscussionItem = flags.readBit()
        
        /// B - fInkAtn (1 bit): Denotes whether this comment is an ink annotation comment.
        self.fInkAtn = flags.readBit()
        
        /// padding2 (30 bits): This value MUST be zero, and MUST be ignored.
        self.padding2 = flags.readRemainingBits()
    }
}
