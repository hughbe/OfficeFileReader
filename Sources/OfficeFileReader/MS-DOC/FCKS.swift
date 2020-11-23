//
//  FCKS.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.76 FCKS
/// The FCKS structure contains information about a grammar checker cookie. The grammar checker cookie itself is contained within the data that
/// corresponds to the fcCookieData member of FibRgFcLcb97.
public struct FCKS {
    public let dcp: Int16
    public let dcpSent: Int16
    public let icdb: UInt32
    public let cet: ErrorType
    public let fError: Bool
    public let lidSub: UInt8
    public let lidPrimary: UInt8
    public let fHeader: Bool
    
    public init(dataStream: inout DataStream) throws {
        /// dcp (2 bytes): An integer that specifies the number of characters that are spanned by the text corresponding to the given grammar
        /// checker cookie. If fHeader is equal to 0x01, this value MUST be ignored.
        self.dcp = try dataStream.read(endianess: .littleEndian)
        
        /// dcpSent (2 bytes): An integer that specifies the number of characters between the start of the text that corresponds to the given
        /// grammar checker cookie and the start of the sentence which contains the text. If fHeader is equal to 0x01, this value MUST be ignored.
        self.dcpSent = try dataStream.read(endianess: .littleEndian)
        
        /// icdb (4 bytes): An unsigned integer that specifies the byte offset within the RgCdb that is specified by the fcCookieData member of
        /// FibRgFcLcb97, at which the data corresponding to this grammar checker cookie is located.
        self.icdb = try dataStream.read(endianess: .littleEndian)
        
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// cet (2 bits): The error type that corresponds to the grammar checker cookie. The error types are interpreted as follows. If
        /// fHeader is equal to 0x1, this value MUST be ignored.
        let cetRaw: UInt8 = UInt8(flags.readBits(count: 2))
        guard let cet = ErrorType(rawValue: cetRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.cet = cet
        
        /// A - fError (1 bit): A bit that indicates whether the grammar checker cookie corresponds to a grammar checker error that is displayed
        /// to the user. If fHeader is equal to 0x1, this value MUST be ignored.
        self.fError = flags.readBit()
        
        /// lidSub (5 bits): The 10th through 14th least significant bits of the language ID component of the LCID of the grammar checker which
        /// created the given grammar checker cookie, as specified in [MSLCID].
        self.lidSub = UInt8(flags.readBits(count: 5))
        
        /// lidPrimary (7 bits): The 7 least significant bits of the language ID component of the LCID of the grammar checker which created the
        /// given grammar checker cookie, as specified in [MS-LCID].
        self.lidPrimary = UInt8(flags.readBits(count: 7))
        
        /// B - fHeader (1 bit): A bit indicating whether this is a special entry containing implementation-specific data for the grammar checker
        /// which created this grammar checker cookie. There MUST be only one entry with fHeader set to 0x1 by a given grammar checker
        /// in a document.
            self.fHeader = flags.readBit()
    }
    
    /// cet (2 bits): An error type that corresponds to the grammar checker cookie. The error types are interpreted as follows.
    /// If fHeader is equal to 0x1, this value MUST be ignored.
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
