//
//  LadSpls.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.128 LadSpls
/// The LadSpls structure is an SPLS structure that specifies the state of the language auto-detection over a range of text. Some states that are possible in
/// a generic SPLS are not allowed in a LadSpls structure.
public struct LadSpls {
    public let spls: SPLS
    
    public init(dataStream: inout DataStream) throws {
        /// spls (2 bytes): An SPLS structure. The spls.fExtend and spls.fTypo fields are not used and MUST be zero. The spls.splf field MUST be one
        /// of the following:
        ///  splfMaybeDirty
        ///  splfDirty
        ///  splfEdit
        ///  splfForeign
        ///  splfClean
        ///  splfNoLAD
        self.spls = try SPLS(dataStream: &dataStream)
        if self.spls.fExtend || self.spls.fTypo {
            throw OfficeFileError.corrupted
        }
        if self.spls.splf != .maybeDirty &&
            self.spls.splf != .dirty &&
            self.spls.splf != .edit &&
            self.spls.splf != .foreign &&
            self.spls.splf != .clean &&
            self.spls.splf != .noLad {
            throw OfficeFileError.corrupted
        }
    }
}
