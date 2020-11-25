//
//  PROJECTlkStream.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.2 PROJECTlk Stream: ActiveX Control Information
/// Specifies license information for ActiveX controls.
public struct PROJECTlkStream {
    public let version: UInt16
    public let count: UInt32
    public let licenseInfoRecords: [LICENSEINFO]
    
    public init(dataStream: inout DataStream) throws {
        /// Version (2 bytes): An unsigned integer that specifies the version of this structure. MUST be 0x0001.
        self.version = try dataStream.read(endianess: .littleEndian)
        guard self.version == 0x0001 else {
            throw OfficeFileError.corrupted
        }
        
        /// Count (4 bytes): An unsigned integer that specifies the number of elements in LicenseInfoRecords.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// LicenseInfoRecords (variable): An array of LICENSEINFO (section 2.3.2.1).
        var licenseInfoRecords: [LICENSEINFO] = []
        licenseInfoRecords.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            licenseInfoRecords.append(try LICENSEINFO(dataStream: &dataStream))
        }
        
        self.licenseInfoRecords = licenseInfoRecords
    }
}
