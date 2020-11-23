//
//  OfficeArtFBSE.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.32 OfficeArtFBSE
/// Referenced by: OfficeArtBStoreContainerFileBlock
/// The OfficeArtFBSE record specifies a File BLIP Store Entry (FBSE) that contains information about the BLIP.
public struct OfficeArtFBSE {
    public let rh: OfficeArtRecordHeader
    public let btWin32: MSOBLIPTYPE
    public let btMacOS: MSOBLIPTYPE
    public let rgbUid: [UInt8]
    public let tag: UInt16
    public let size: UInt32
    public let cRef: UInt32
    public let foDelay: MSOFO
    public let unused1: UInt8
    public let cbName: UInt8
    public let unused2: UInt8
    public let unused3: UInt8
    public let nameData: String
    public let embeddedBlip: OfficeArtBlip?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x2.
        /// rh.recInstance An MSOBLIPTYPE enumeration value, as defined in section 2.4.1, that specifies the BLIP type and MUST match either btWin32 or
        /// btMacOS.
        /// rh.recType A value that MUST be 0xF007.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header. This value MUST be the size of nameData plus 36 if the
        /// BLIP is not embedded in this record, or the size of nameData plus size plus 36 if the BLIP is
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x2 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF007 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// btWin32 (1 byte): An MSOBLIPTYPE enumeration value, as defined in section 2.4.1, that specifies the Windows BLIP type. If the btMacOS value
        /// is supported by the Windows operating system, this value MUST match btMacOS. If the values of btWin32 and btMacOS are different, the BLIP
        /// that matches rh.recInstance MUST be present and the other MAY be present.
        let btWin32Raw: UInt8 = try dataStream.read()
        guard let btWin32 = MSOBLIPTYPE(rawValue: btWin32Raw) else {
            throw OfficeFileError.corrupted
        }
        
        self.btWin32 = btWin32
        
        /// btMacOS (1 byte): An MSOBLIPTYPE enumeration value, as defined in section 2.4.1, that specifies the Macintosh BLIP type. If the btWin32 value
        /// is supported by the Macintosh operating system, this value MUST match btWin32. If the values of btWin32 and btMacOS are different, the BLIP
        /// that matches rh.recInstance MUST be present and the other MAY be present.
        let btMacOSRaw: UInt8 = try dataStream.read()
        guard let btMacOS = MSOBLIPTYPE(rawValue: btMacOSRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.btMacOS = btMacOS
        
        /// rgbUid (16 bytes): An MD4 message digest, as specified in [RFC1320], that specifies the unique identifier of the pixel data in the BLIP.
        self.rgbUid = try dataStream.readBytes(count: 16)
        
        /// tag (2 bytes): An unsigned integer that specifies an application-defined internal resource tag. This value MUST be 0xFF for external files.
        self.tag = try dataStream.read(endianess: .littleEndian)
        
        /// size (4 bytes): An unsigned integer that specifies the size, in bytes, of the BLIP in the stream.
        self.size = try dataStream.read(endianess: .littleEndian)
        
        /// cRef (4 bytes): An unsigned integer that specifies the number of references to the BLIP. A value of 0x00000000 specifies an empty slot in the
        /// OfficeArtBStoreContainer record, as defined in section 2.2.20.
        let cRef: UInt32 = try dataStream.read(endianess: .littleEndian)
        self.cRef = cRef
        
        /// foDelay (4 bytes): An MSOFO structure, as defined in section 2.1.4, that specifies the file offset into the associated OfficeArtBStoreDelay record,
        /// as defined in section 2.2.21, (delay stream). A value of 0xFFFFFFFF specifies that the file is not in the delay stream, and in this case, cRef MUST
        /// be 0x00000000.
        self.foDelay = try dataStream.read(endianess: .littleEndian)
        if self.foDelay == 0xFFFFFFFF && cRef != 0x00000000 {
            throw OfficeFileError.corrupted
        }
        
        /// unused1 (1 byte): A value that is undefined and MUST be ignored.
        self.unused1 = try dataStream.read()
        
        /// cbName (1 byte): An unsigned integer that specifies the length, in bytes, of the nameData field, including the terminating NULL character.
        /// This value MUST be an even number and less than or equal to 0xFE. If the value is 0x00, nameData will not be written.
        let cbName: UInt8 = try dataStream.read()
        if (cbName % 2) != 0 || cbName > 0xFE {
            throw OfficeFileError.corrupted
        }
        
        self.cbName = cbName
        
        /// unused2 (1 byte): A value that is undefined and MUST be ignored.
        self.unused2 = try dataStream.read()
        
        /// unused3 (1 byte): A value that is undefined and MUST be ignored.
        self.unused3 = try dataStream.read()
        
        /// nameData (variable): A Unicode null-terminated string that specifies the name of the BLIP.
        if self.cbName == 0 {
            self.nameData = ""
        } else {
            self.nameData = try dataStream.readString(count: Int(self.cbName) - 2, encoding: .utf16LittleEndian)!
            if dataStream.position + 2 > dataStream.count {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position += 2
        }
        
        /// embeddedBlip (variable): An OfficeArtBlip record, as defined in section 2.2.23, specifying the BLIP file data that is embedded in this record. If
        /// this value is not 0, foDelay MUST be ignored.
        if self.foDelay == 0xFFFFFFFF {
            self.embeddedBlip = try OfficeArtBlip(dataStream: &dataStream)
        } else {
            self.embeddedBlip = nil
        }

        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
