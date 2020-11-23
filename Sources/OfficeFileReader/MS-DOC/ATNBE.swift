//
//  ATNBE.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.4 ATNBE
/// The ATNBE structure contains information about an annotation bookmark in the document.
public struct ATNBE {
    public let bmc: UInt16
    public let lTag: UInt32
    public let lTagOld: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// bmc (2 bytes): An unsigned integer specifying the bookmark (1) class that MUST be 0x0100, for annotation.
        self.bmc = try dataStream.read(endianess: .littleEndian)
        if self.bmc != 0x0100 {
            throw OfficeFileError.corrupted
        }
        
        /// lTag (4 bytes): An unsigned integer that specifies a unique value used by the lTagBkmk member of ATRDPre10 structures inside the PlcfandRef
        /// at offset fcPlcfandRef in lTag’s nearest parent FibRgFcLcb97 to reference the annotation associated with this ATNBE. This MUST be unique for all
        /// ATNBEs inside a given SttbfAtnBkmk.
        self.lTag = try dataStream.read(endianess: .littleEndian)
        
        /// lTagOld (4 bytes): Unused. This value MUST be -1, and MUST be ignored.
        self.lTagOld = try dataStream.read(endianess: .littleEndian)
    }
}
