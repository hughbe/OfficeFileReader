//
//  DofrFsnName.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.58 DofrFsnName
/// The DofrFsnName structure is a type that specifies the name of the frame. DofrFsnName applies to the frame that is associated with the most
/// recently read DofrFsn record.
public struct DofrFsnName {
    public let xstzFilename: Xstz
    
    public init(dataStream: inout DataStream) throws {
        /// xstzFilename (variable): An Xstz that specifies the name of the frame. The name MUST be between 0 and 255 characters in length.
        self.xstzFilename = try Xstz(dataStream: &dataStream)
        if self.xstzFilename.xst.rgtchar.count > 255 {
            throw OfficeFileError.corrupted
        }
    }
}
