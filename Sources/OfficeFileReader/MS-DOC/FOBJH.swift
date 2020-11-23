//
//  FOBJH.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.94 FOBJH
/// The FOBJH structure specifies size and compression information about the OLE object storage that immediately follows it in the Data stream of a
/// file that is encrypted with Office Binary Document RC4 CryptoAPI Encryption (section 2.2.6.3). Every OLE object storage in the Data stream MUST be
/// preceded by an FOBJH.
/// If fCompressed is 1, the bytes of the OLE object storage are compressed by the algorithm specified in [RFC1950].
public struct FOBJH {
    public let cbHeader: Int16
    public let fCompressed: Bool
    public let unused: UInt16
    public let cbObj: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// cbHeader (2 bytes): A signed integer that specifies the size, in bytes, of the FOBJH. This value MUST be 8.
        self.cbHeader = try dataStream.read(endianess: .littleEndian)
        if self.cbHeader != 8 {
            throw OfficeFileError.corrupted
        }
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fCompressed (1 bit): Specifies whether the OLE object storage that follows this FOBJH is compressed.
        self.fCompressed = flags.readBit()
        
        /// unused (15 bits): This field is undefined and MUST be ignored.
        self.unused = flags.readRemainingBits()
        
        /// cbObj (4 bytes): A signed integer that specifies the size, in bytes, of the FOBJH and the OLE object storage that follows it.
        self.cbObj = try dataStream.read(endianess: .littleEndian)
    }
}
