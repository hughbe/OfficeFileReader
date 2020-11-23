//
//  FNIF.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.92 FNIF
/// The FNIF structure contains information about a file name (see SttbFnm) so that the path, type, and file system of the file can be determined.
public struct FNIF {
    public let fnpi: FNPI
    public let ichRelative: UInt8
    public let fnfb: FNFB
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// fnpi (2 bytes): An FNPI that specifies the type and the identifier of the file name, which is unique within the scope of fnpi.fnpt.
        /// This is used to define these values, not to reference a file name.
        self.fnpi = try FNPI(dataStream: &dataStream)
        
        /// ichRelative (1 byte): An unsigned integer that specifies a character offset into the file name string. The segment of the file name string
        /// that starts at this character offset specifies the path of the file relative to the folder that contains the document. If the file name does
        /// not contain such a path, this value MUST be 0xFF.
        self.ichRelative = try dataStream.read()
        
        /// fnfb (1 byte): An FNFB that specifies on what file systems the file name is valid.
        self.fnfb = try FNFB(dataStream: &dataStream)
        
        /// unused (4 bytes): This field is undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
    }
}
