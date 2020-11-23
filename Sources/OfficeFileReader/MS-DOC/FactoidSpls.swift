//
//  FactoidSpls.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.67 FactoidSpls
/// The FactoidSpls structure is an SPLS structure that specifies the state of the smart tag recognizer over a range of text. Some states that are possible in
/// a generic SPLS are not allowed in a FactoidSpls structure.
public struct FactoidSpls {
    public let spls: SPLS
    
    public init(dataStream: inout DataStream) throws {
        /// spls (2 bytes): An SPLS structure.
        /// The spls.fError, spls.fExtend, and spls.fTypo fields are not used and MUST be zero. The spls.splf field MUST be one of the following:
        ///  splfPending
        ///  splfMaybeDirty
        ///  splfDirty
        ///  splfEdit
        ///  splfClean
        self.spls = try SPLS(dataStream: &dataStream)
        if self.spls.splf != .pending &&
            self.spls.splf != .maybeDirty &&
            self.spls.splf != .dirty &&
            self.spls.splf != .edit &&
            self.spls.splf != .clean {
            throw OfficeFileError.corrupted
        }
    }
}
