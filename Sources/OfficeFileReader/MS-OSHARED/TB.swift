//
//  TB.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.6 TB
/// Structure that contains toolbar information.
public struct TB {
    public let bSignature: Int8
    public let bVersion: Int8
    public let cCL: Int16
    public let ltbid: Int32
    public let ltbtr: TBTRFlags
    public let cRowsDefault: UInt16
    public let bFlags: TBFlags
    public let name: WString
    
    public init(dataStream: inout DataStream) throws {
        /// bSignature (1 byte): Signed integer that specifies the toolbar signature number. MUST be 0x02.
        self.bSignature = try dataStream.read()
        if self.bSignature != 0x02 {
            throw OfficeFileError.corrupted
        }
        
        /// bVersion (1 byte): Signed integer that specifies the toolbar version number. MUST be 0x01.
        self.bVersion = try dataStream.read(endianess: .littleEndian)
        if self.bVersion != 0x01 {
            throw OfficeFileError.corrupted
        }
        
        /// cCL (2 bytes): Signed integer that SHOULD<2> specify the number of toolbar controls contained in this toolbar.
        self.cCL = try dataStream.read(endianess: .littleEndian)
        
        /// ltbid (4 bytes): Signed integer that specifies the toolbar ID. MUST be 0x00000001 (custom toolbar ID).
        self.ltbid = try dataStream.read(endianess: .littleEndian)
        if self.ltbid != 0x00000001 {
            throw OfficeFileError.corrupted
        }
        
        /// ltbtr (4 bytes): Unsigned integer of type TBTRFlags (section 2.3.1.7) that specifies the toolbar type and toolbar restrictions.
        self.ltbtr = try TBTRFlags(dataStream: &dataStream)
        
        /// cRowsDefault (2 bytes): Unsigned integer that specifies the number of preferred rows for the toolbar when the toolbar is not docked.
        /// MUST be less than or equal to 255.
        self.cRowsDefault = try dataStream.read(endianess: .littleEndian)
        if self.cRowsDefault > 255 {
            throw OfficeFileError.corrupted
        }
        
        /// bFlags (2 bytes): Unsigned integer of type TBFlags (section 2.3.1.8).
        self.bFlags = try TBFlags(dataStream: &dataStream)
        
        /// name (variable): Structure of type WString (section 2.3.1.4) that specifies the toolbar name.
        self.name = try WString(dataStream: &dataStream)
    }
}
