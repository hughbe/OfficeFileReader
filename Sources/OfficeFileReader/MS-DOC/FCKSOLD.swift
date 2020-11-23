//
//  FCKSOLD.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.77 FCKSOLD
/// The FCKSOLD structure contains information about a grammar checker cookie. The grammar checker cookie itself is contained within the data
/// that corresponds to the fcCookieData member of FibRgFcLcb97.
public struct FCKSOLD {
    public let lid: LID
    public let dcp: Int16
    public let dcpSent: Int16
    public let padding1: UInt16
    public let cet: ErrorType
    public let spare: UInt16
    public let fError: Bool
    public let padding2: UInt16
    public let icdb: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// lid (2 bytes): A LID that corresponds to the grammar checker that created the given grammar checker cookie.
        self.lid = try dataStream.read(endianess: .littleEndian)
        
        /// dcp (2 bytes): An integer that specifies the number of characters that are spanned by the text corresponding to the given grammar
        /// checker cookie. This value MUST be greater than or equal to zero.
        self.dcp = try dataStream.read(endianess: .littleEndian)
        if self.dcp < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// dcpSent (2 bytes): An integer that specifies the number of characters between the start of the text that corresponds to the given
        /// grammar checker cookie and the start of the sentence that contains the text. This value MUST be less than or equal to zero.
        self.dcpSent = try dataStream.read(endianess: .littleEndian)
        if self.dcpSent < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// padding1 (2 bytes): This value is undefined and MUST be ignored.
        self.padding1 = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// cet (2 bits): An error type that corresponds to the grammar checker cookie. The error types are interpreted as follows.
        let cetRaw: UInt8 = UInt8(flags.readBits(count: 2))
        guard let cet = ErrorType(rawValue: cetRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.cet = cet
        
        /// spare (13 bits): This value is undefined and MUST be ignored.
        self.spare = flags.readBits(count: 13)
        
        /// A - fError (1 bit): A bit that indicates whether the grammar checker cookie corresponds to a grammar checker error that is intended to
        /// be displayed to the user.
        self.fError = flags.readBit()
        
        /// padding2 (2 bytes): This value is undefined and MUST be ignored.
        self.padding2 = try dataStream.read(endianess: .littleEndian)
        
        /// icdb (4 bytes): An unsigned integer that specifies the byte offset within the RgCdb that is specified by the fcCookieData member of
        /// FibRgFcLcb97 at which the data corresponding to this grammar checker cookie is located.
        self.icdb = try dataStream.read(endianess: .littleEndian)
    }
    
    /// cet (2 bits): An error type that corresponds to the grammar checker cookie. The error types are interpreted as follows.
    public enum ErrorType: UInt8 {
        /// 0x0 Default (not typo, homonym, or consistency)
        case `default` = 0x0
        
        /// 0x1 Typo
        case typo = 0x1
        
        /// 0x2 Homonym
        case homonym = 0x2
        
        /// 0x3 Consistency
        case consistency = 0x3
    }
}
