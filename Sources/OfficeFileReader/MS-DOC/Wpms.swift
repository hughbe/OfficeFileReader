//
//  Wpms.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.347 Wpms
/// The Wpms structure specifies the current state of the mail merge.
public struct Wpms {
    public let wpmsMainDoc: Bool
    public let wpmsDF: Bool
    public let wpmsHF: Bool
    public let wpmsType: DocumentType
    public let unused1: Bool
    public let wpmsAuto: Bool
    public let unused2: Bool
    public let wpmsSuppression: Bool
    public let wpmsRecSelect: Bool
    public let unused3: Bool
    public let wpmsDest: Destination
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - wpmsMainDoc (1 bit): Specifies whether the main document was selected for the mail merge.
        self.wpmsMainDoc = flags.readBit()
        
        /// B - wpmsDF (1 bit): Specifies whether the data source was selected for the mail merge.
        self.wpmsDF = flags.readBit()
        
        /// C - wpmsHF (1 bit): Specifies whether the mail merge obtains the merge field names from a header file.
        self.wpmsHF = flags.readBit()
        
        /// D - wpmsType (4 bits): An unsigned integer that specifies the document type of the mail merge. This value MUST be one of the following.
        let wpmsTypeRaw = UInt8(flags.readBits(count: 4))
        guard let wpmsType = DocumentType(rawValue: wpmsTypeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.wpmsType = wpmsType
        
        /// E - unused1 (1 bit): This bit is undefined and MUST be ignored.
        self.unused1 = flags.readBit()
        
        /// F - wpmsAuto (1 bit): Specifies whether this is an automatic label or envelope mail merge.
        self.wpmsAuto = flags.readBit()
        
        /// G - unused2 (1 bit): This value MUST be zero and MUST be ignored.
        self.unused2 = flags.readBit()
        
        /// H - wpmsSuppression (1 bit): Specifies whether the blank lines in the data files MUST be suppressed.
        self.wpmsSuppression = flags.readBit()
        
        /// I - wpmsRecSelect (1 bit): Specifies whether record selection is enabled.
        self.wpmsRecSelect = flags.readBit()
        
        /// J - unused3 (1 bit): This value MUST be zero and MUST be ignored.
        self.unused3 = flags.readBit()
        
        /// K - wpmsDest (3 bits): An unsigned integer that specifies the destination of the mail merge. This MUST be one of the following values.
        let wpmsDestRaw = UInt8(flags.readBits(count: 3))
        guard let wpmsDest = Destination(rawValue: wpmsDestRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.wpmsDest = wpmsDest
    }
    
    /// D - wpmsType (4 bits): An unsigned integer that specifies the document type of the mail merge. This value MUST be one of the following.
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
    }
    
    /// K - wpmsDest (3 bits): An unsigned integer that specifies the destination of the mail merge. This MUST be one of the following values.
    public enum Destination: UInt8 {
        /// 0x0 None
        case none
        
        /// 0x1 Printer
        case printer = 0x1
        
        /// 0x2 E-mail
        case email = 0x2
        
        /// 0x4 Fax
        case fax = 0x4
    }
}
