//
//  RecordHeader.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.3.1 RecordHeader
/// A structure at the beginning of each container record and each atom record in the file. The values in the record header and the context of the
/// record are used to identify and interpret the record data that follows.
public struct RecordHeader {
    public let recVer: UInt8
    public let recInstance: UInt16
    public let recType: RecordType
    public let recLen: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)

        /// recVer (4 bits): An unsigned integer that specifies the version of the record data that follows the record header. A value of 0xF specifies
        /// that the record is a container record.
        self.recVer = UInt8(flags.readBits(count: 4))
        
        /// recInstance (12 bits): An unsigned integer that specifies the record instance data. Interpretation of the value is dependent on the particular
        /// record type.
        self.recInstance = flags.readRemainingBits()
        
        /// recType (2 bytes): A RecordType enumeration (section 2.13.24) that specifies the type of the record data that follows the record header.
        let recTypeRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        if let recType = RecordType(rawValue: recTypeRaw) {
            self.recType = recType
        } else {
            print("UNKNOWN: \(recTypeRaw.hexString)")
            self.recType = .unknown
        }
        
        /// recLen (4 bytes): An unsigned integer that specifies the length, in bytes, of the record data that follows the record header.
        self.recLen = try dataStream.read(endianess: .littleEndian)
    }
}
