//
//  ATRDPre10.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.7 ATRDPre10
/// The ATRDPre10 structure contains information about a comment in the document including the initials of the author, an index to a string table with the name
/// of the author, and a bookmark (1) identifier. More information about the comment can be specified in a corresponding ATRDPost10 in the AtrdExtra at position
/// fcAtrdExtra.
public struct ATRDPre10 {
    public let xstUsrInitl: LPXCharBuffer9
    public let ibst: UInt16
    public let bitsNotUsed: UInt16
    public let grfNotused: UInt16
    public let lTagBkmk: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// xstUsrInitl (20 bytes): An LPXCharBuffer9 containing the initials of the user who left the annotation.
        self.xstUsrInitl = try LPXCharBuffer9(dataStream: &dataStream)
        
        /// ibst (2 bytes): An index into the string table of comment author names. MUST be greater than or equal to zero, and MUST be less than the
        /// number of XSTs at position fcGrpXstAtnOwners.
        self.ibst = try dataStream.read(endianess: .littleEndian)
        
        /// bitsNotUsed (2 bytes): This value MUST be zero, and MUST be ignored.
        self.bitsNotUsed = try dataStream.read(endianess: .littleEndian)
        
        /// grfNotused (2 bytes): This value MUST be zero, and MUST be ignored.
        self.grfNotused = try dataStream.read(endianess: .littleEndian)
        
        /// TagBkmk (4 bytes): A 4-byte value that identifies a bookmark (1) identifier. This value MUST be equal to -1 if and only if this comment is on a
        /// length zero text range in the Main Document. Otherwise MUST be equal to the lTag of one of the ATNBE structures in the SttbfAtnBkmk
        /// structure at position fcSttbfAtnBkmk.
        self.lTagBkmk = try dataStream.read(endianess: .littleEndian)
    }
}
