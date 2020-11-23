//
//  DofrFsnFnm.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.57 DofrFsnFnm
/// The DofrFsnFnm structure is an Xstz that specifies the file name of the file that is loaded into the frame. DofrFsnFnm applies to the frame that is
/// associated with the most recently read DofrFsn record.
public struct DofrFsnFnm {
    public let xstzFilename: Xstz
    
    public init(dataStream: inout DataStream) throws {
        /// xstzFilename (variable): An Xstz that specifies the file name and path of the frame. The string MUST be between 0 and 258
        /// characters in length.
        self.xstzFilename = try Xstz(dataStream: &dataStream)
        if self.xstzFilename.xst.rgtchar.count > 258 {
            throw OfficeFileError.corrupted
        }
    }
}
