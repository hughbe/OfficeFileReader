//
//  Wpmsdt.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.348 Wpmsdt
/// A Wpmsdt structure specifies the document type of the mail merge.
public struct Wpmsdt {
    public let docType: DocumentType
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// docType (6 bits): An unsigned integer that specifies the document type of the mail merge. This MUST be one of the following values.
        let docTypeRaw = UInt8(flags.readBits(count: 6))
        guard let docType = DocumentType(rawValue: docTypeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.docType = docType
        
        /// unused (26 bits): This field is undefined and MUST be ignored.
        self.unused = flags.readRemainingBits()
    }
    
    /// docType (6 bits): An unsigned integer that specifies the document type of the mail merge. This MUST be one of the following values.
    public enum DocumentType: UInt8 {
        /// 0x00 No mail merge.
        case noMailMerge = 0x00
        
        /// 0x01 Letters.
        case letters = 0x01
        
        /// 0x02 Labels.
        case labels = 0x02
        
        /// 0x04 Envelopes.
        case envelopes = 0x04
        
        /// 0x08 Catalog or directory.
        case catalogOrDirectory = 0x08
        
        /// 0x10 E-mail messages.
        case emailMessages = 0x10
        
        /// 0x20 Fax.
        case fax = 0x20
    }
}
