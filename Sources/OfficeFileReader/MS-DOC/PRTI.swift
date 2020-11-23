//
//  PRTI.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.220 PRTI
/// The PRTI structure contains information about a span of text that is delimited by a range-level protection bookmark in the document.
public struct PRTI {
    public let uidSel: UidSel
    public let iProt: ProtectionType
    public let i: UInt16
    public let fUseMe: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// uidSel (2 bytes): A UidSel that identifies the permitted editors for the text range that is associated with this PRTI.
        self.uidSel = try dataStream.read(endianess: .littleEndian)
        
        /// iProt (2 bytes): A ProtectionType that identifies the kind of protection for which exception is granted to the editors that are specified by uidSel
        /// within a span of text. The span of text is delimited by the bookmark that is associated with this PRTI. This MUST be iProtReadWrite.
        let iProtRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let iProt = ProtectionType(rawValue: iProtRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iProt = iProt
        
        /// i (2 bytes): This value is undefined and MUST be ignored.
        self.i = try dataStream.read(endianess: .littleEndian)
        
        /// fUseMe (2 bytes): This value is undefined and MUST be ignored.
        self.fUseMe = try dataStream.read(endianess: .littleEndian)
    }
}
