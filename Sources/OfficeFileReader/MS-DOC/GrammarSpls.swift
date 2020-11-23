//
//  GrammarSpls.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.109 GrammarSpls
/// The GrammarSpls structure is an SPLS structure that specifies the state of the grammar checker over a range of text. Some states that are
/// possible in a generic SPLS are not allowed in a GrammarSpls structure.
public struct GrammarSpls {
    public let spls: SPLS
    
    public init(dataStream: inout DataStream) throws {
        /// spls (2 bytes): An SPLS structure. The spls.fExtend field MUST be zero if the spls.fError field is zero. The spls.splf field MUST be one
        /// of the following:
        ///  splfMaybeDirty
        ///  splfDirty
        ///  splfEdit
        ///  splfForeign
        ///  splfClean
        ///  splfErrorMin
        ///  splfRepeatWord
        ///  splfUnknownWord
        self.spls = try SPLS(dataStream: &dataStream)
        if self.spls.fExtend || self.spls.fError {
            throw OfficeFileError.corrupted
        }
        if self.spls.splf != .maybeDirty &&
            self.spls.splf != .dirty &&
            self.spls.splf != .edit &&
            self.spls.splf != .foreign &&
            self.spls.splf != .clean &&
            self.spls.splf != .errorMin &&
            self.spls.splf != .repeatWord &&
            self.spls.splf != .unknownWord {
            throw OfficeFileError.corrupted
        }
    }
}
