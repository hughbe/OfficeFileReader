//
//  Dofrh.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.61 Dofrh
/// The Dofrh structure is the general record header that wraps each record type specified in the section Dofr. Every record begins with this header.
/// Records that specify a frame set MUST begin with a record containing a dofrt equal to dofrtFs, followed by any number of records of other types,
/// according to the rules defined in the section for each record type. Each frame MUST have one or more records that specify the attributes of the frame.
/// Similarly, an array of list specifications MUST begin with a record containing a dofrt equal to dofrtRglstsf, followed by any number of list records.
public struct Dofrh {
    public let cb: UInt32
    public let dofrt: Dofrt
    public let dofr: Dofr
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// cb (4 bytes): An unsigned integer that specifies the size of the Dofrh, including all contained variable or optional data such as the dofr.
        self.cb = try dataStream.read(endianess: .littleEndian)
        
        /// dofrt (4 bytes): A Dofrt that specifies the type of data contained in dofr.
        let dofrtRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let dofrt = Dofrt(rawValue: dofrtRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.dofrt = dofrt
        
        /// dofr (variable): A Dofr that contains data for each record type. If dofrt is dofrtFs, this field MUST NOT exist. For all other records, this
        /// field MUST exist.
        self.dofr = try Dofr(dataStream: &dataStream, dofrt: self.dofrt)
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
