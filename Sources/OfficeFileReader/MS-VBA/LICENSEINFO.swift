//
//  LICENSEINFO.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OVBA] 2.3.2.1 LICENSEINFO Record
/// Specifies the information saved for each ActiveX control in the VBA project.
public struct LICENSEINFO {
    public let classID: GUID
    public let sizeOfLicenseKey: UInt32
    public let licenseKey: [UInt8]
    public let licenseRequired: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// ClassID (16 bytes): A GUID that specifies the class identifier (CLSID) of an ActiveX control.
        self.classID = try GUID(dataStream: &dataStream)
        
        /// SizeOfLicenseKey (4 bytes): An unsigned integer that specifies the length of LicenseKey in bytes.
        self.sizeOfLicenseKey = try dataStream.read(endianess: .littleEndian)
        
        /// LicenseKey (variable): An array of SizeOfLicenseKey bytes that specifies the license key for the ActiveX control.
        self.licenseKey = try dataStream.readBytes(count: Int(self.sizeOfLicenseKey))
        
        /// LicenseRequired (4 bytes): An unsigned integer that specifies a Boolean value. Specifies that the ActiveX control can be instantiated only
        /// by using a license-aware object creation method. SHOULD be 0x00000001 when the value of SizeOfLicenseKey is not zero. Otherwise
        /// SHOULD be 0x00000000. If a document is originally created with an ActiveX control that requires licenseaware object creation, and then
        /// resaved after the ActiveX control removes that requirement, it can be 0x00000000 even though SizeOfLicenseKey is not zero.
        self.licenseRequired = try dataStream.read(endianess: .littleEndian)
    }
}
