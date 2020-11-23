//
//  CidMacro.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.37 CidMacro
/// The CidMacro structure is a command identifier that specifies a command based on a macro.
public struct CidMacro {
    public let cmt: Cmt
    public let reserved: UInt16
    public let ibst: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// cmt (3 bits): This value MUST be cmtMacro.
        let cmtRaw = UInt8(flags.readBits(count: 3))
        guard let cmt = Cmt(rawValue: cmtRaw) else {
            throw OfficeFileError.corrupted
        }
        guard cmt != .macro else {
            throw OfficeFileError.corrupted
        }
        
        self.cmt = cmt
        
        /// reserved (13 bits): This value MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// ibst (2 bytes): An unsigned integer that specifies the name of the macro to be executed. The macro name is specified by MacroName.xstz
        /// of the MacroName entry in the MacroNames such that MacroName.ibst equals ibst. MacroNames MUST contain such an entry.
        self.ibst = try dataStream.read(endianess: .littleEndian)
    }
}
