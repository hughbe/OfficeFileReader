//
//  ODT.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.165 ODT
/// The ODT structure stores information about an OLE object. Each OLE object in a Word Binary file is stored in a storage within the ObjectPool storage.
/// Each of these storages has an ObjInfo stream which contains an ODT structure.
public struct ODT {
    public let odtPersist1: ODTPersist1
    public let cf: UInt16
    public let odtPersist2: ODTPersist2?

    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position

        /// ODTPersist1 (2 bytes): An ODTPersist1 structure that specifies information about the OLE object.
        self.odtPersist1 = try ODTPersist1(dataStream: &dataStream)
        
        /// cf (2 bytes): An unsigned integer that specifies the format this OLE object uses to transmit data to the host application. Valid values and
        /// their meanings are:
        /// Value Meaning
        /// 0x0001 Rich Text Format
        /// 0x0002 Text format
        /// 0x0003 Metafile or Enhanced Metafile, depending on ODTPersist2.fStoredAsEMF
        /// 0x0004 Bitmap
        /// 0x0005 Device Independent Bitmap
        /// 0x000A HTML format
        /// 0x0014 Unicode text format
        self.cf = try dataStream.read(endianess: .littleEndian)
        
        /// ODTPersist2 (2 bytes): An ODTPersist2 structure that specifies additional information about the OLE object. This member does not exist
        /// if the ObjInfo stream containing this ODT structure is not large enough to accommodate it.
        if dataStream.position - startPosition == size {
            self.odtPersist2 = nil
            return
        }
        
        self.odtPersist2 = try ODTPersist2(dataStream: &dataStream)
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
