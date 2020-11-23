//
//  PICF.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.190 PICF
/// The PICF structure specifies the type of a picture, as well as the size of the picture and information about its border.
public struct PICF {
    public let lcb: UInt32
    public let cbHeader: UInt16
    public let mfpf: MFPF
    public let innerHeader: PICF_Shape
    public let picmid: PICMID
    public let cProps: UInt16
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// lcb (4 bytes): A signed integer that specifies the size, in bytes, of this PICF structure and the subsequent data.
        self.lcb = try dataStream.read(endianess: .littleEndian)
        
        /// cbHeader (2 bytes): An unsigned integer that specifies the size, in bytes, of this PICF structure. This value MUST be 0x44.
        self.cbHeader = try dataStream.read(endianess: .littleEndian)
        if self.cbHeader != 0x44 {
            throw OfficeFileError.corrupted
        }
        
        /// mfpf (8 bytes): An MFPF structure that specifies the storage format of the picture.
        self.mfpf = try MFPF(dataStream: &dataStream)
        
        /// innerHeader (14 bytes): A PICF_Shape structure that specifies additional header information.
        self.innerHeader = try PICF_Shape(dataStream: &dataStream)
        
        /// picmid (38 bytes): A PICMID structure that specifies the size and border information of the picture.
        self.picmid = try PICMID(dataStream: &dataStream)
        
        /// cProps (2 bytes): This value MUST be 0 and MUST be ignored.
        self.cProps = try dataStream.read(endianess: .littleEndian)
        
        if dataStream.position - startPosition != self.lcb {
            throw OfficeFileError.corrupted
        }
    }
}
