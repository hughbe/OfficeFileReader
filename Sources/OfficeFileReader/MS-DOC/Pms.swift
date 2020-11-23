//
//  Pms.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.205 Pms
/// The Pms data structure contains the print merge or mail merge state information.
public struct Pms {
    public let wpms: Wpms
    public let ipmfMF: UInt8
    public let ipmfFetch: UInt8
    public let iRecCur: UInt32
    public let rgpmfs: [Pmfs]
    public let rfs: Rfs
    public let cblszSqlStr: UInt16
    public let lxszSqlStr: String
    public let sttbfRfs: SttbfRfs?
    public let wpmsdt: Wpmsdt
    
    public init(dataStream: inout DataStream) throws {
        /// wpms (2 bytes): The mail merge state as a Wpms.
        self.wpms = try Wpms(dataStream: &dataStream)
        
        /// ipmfMF (1 byte): An unsigned integer that specifies the index in the array rgpmfs and MUST be 0 or 1. This value is used for the mail merge
        /// header field source from which the mail merge column names are obtained.
        let ipmfMF: UInt8 = try dataStream.read(endianess: .littleEndian)
        if ipmfMF != 0 && ipmfMF != 1 {
            throw OfficeFileError.corrupted
        }
        
        self.ipmfMF = ipmfMF
        
        /// ipmfFetch (1 byte): An unsigned integer that specifies the index in the array rgpmfs and MUST be 0 or 1. This value is used for the mail merge
        /// data fetch source from which the mail merge data is obtained.
        let ipmfFetch: UInt8 = try dataStream.read(endianess: .littleEndian)
        if ipmfFetch != 0 && ipmfFetch != 1 {
            throw OfficeFileError.corrupted
        }
        
        self.ipmfFetch = ipmfFetch
        
        /// iRecCur (4 bytes): An unsigned integer that specifies the index of the current mail merge record. This value MUST be between 0 and 0xFFFFFFF0
        /// as the record index, or it MUST be 0xFFFFFFFF as a nil value.
        let iRecCur: UInt32 = try dataStream.read(endianess: .littleEndian)
        if iRecCur > 0xFFFFFFF0 && iRecCur != 0xFFFFFFFF {
            throw OfficeFileError.corrupted
        }
        
        self.iRecCur = iRecCur
        
        /// rgpmfs (16 bytes): An array of two Pmfs elements.
        self.rgpmfs = [try Pmfs(dataStream: &dataStream), try Pmfs(dataStream: &dataStream)]
        
        /// rfs (4 bytes): The mail merge record filtering information. See Rfs.
        self.rfs = try Rfs(dataStream: &dataStream)
        
        /// cblszSqlStr (2 bytes): An unsigned integer that specifies the length, in bytes, of the string lxszSqlStr. Because lxszSqlStr is in Unicode, cblszSqlStr
        /// MUST be an even number. If cblszSqlStr is zero, lxszSqlStr does not exist; otherwise this value MUST be greater than 2 but
        /// MUST NOT exceed 512 bytes.
        let cblszSqlStr: UInt16 = try dataStream.read(endianess: .littleEndian)
        if cblszSqlStr != 0 && ((cblszSqlStr % 2) != 0 || cblszSqlStr <= 2 || cblszSqlStr > 512) {
            throw OfficeFileError.corrupted
        }
        
        self.cblszSqlStr = cblszSqlStr
        
        /// lxszSqlStr (variable): The null-terminated Unicode SQL Query string. For example, "SELECT * FROM [myTable] WHERE …", where myTable is
        /// the table name in the database that is connected. This field is not present if cblxszSqlStr is zero.
        if self.cblszSqlStr != 0 {
            self.lxszSqlStr = try dataStream.readString(count: Int(self.cblszSqlStr) - 2, encoding: .utf16LittleEndian)!
            if dataStream.position + 2 > dataStream.count {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position += 2
        } else {
            self.lxszSqlStr = ""
        }
        
        /// sttbfRfs (variable): The string table, STTB, that contains the strings for mail merge connection and record filtering. See the SttbfRfs structure.
        /// Pms.sttbfRfs does not exist if Pms.rfs.hsttbRfs is zero. See the Rfs structure.
        if self.rfs.hsttbRfs != 0 {
            self.sttbfRfs = try SttbfRfs(dataStream: &dataStream)
        } else {
            self.sttbfRfs = nil
        }
        
        /// wpmsdt (4 bytes): The mail merge document type. See the Wpmsdt structure.
        self.wpmsdt = try Wpmsdt(dataStream: &dataStream)
    }
}
