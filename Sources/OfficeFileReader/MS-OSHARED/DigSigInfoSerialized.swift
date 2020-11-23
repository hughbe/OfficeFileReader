//
//  DigSigInfoSerialized.swift
//  
//
//  Created by Hugh Bellamy on 10/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.2.1 DigSigInfoSerialized
/// Referenced by: DigSigBlob, WordSigBlob
/// Specifies the detailed data of a VBA digital signature.
public struct DigSigInfoSerialized {
    public let cbSignature: UInt32
    public let signatureOffset: UInt32
    public let cbSigningCertStore: UInt32
    public let certStoreOffset: UInt32
    public let cbProjectName: UInt32
    public let projectNameOffset: UInt32
    public let fTimestamp: UInt32
    public let cbTimestampUrl: UInt32
    public let timestampUrlOffset: UInt32
    public let pbSignatureBuffer: [UInt8]
    public let pbSigningCertStoreBuffer: VBASigSerializedCertStore
    public let rgchProjectNameBuffer: String
    public let rgchTimestampBuffer: String
    
    public init(dataStream: inout DataStream, startPosition: Int) throws {
        /// cbSignature (4 bytes): An unsigned integer that specifies the size of the pbSignatureBuffer field in bytes.
        self.cbSignature = try dataStream.read(endianess: .littleEndian)
        
        /// signatureOffset (4 bytes): An unsigned integer that specifies the offset of the pbSignatureBuffer field relative to the beginning of this
        /// structure’s parent DigSigBlob (section 2.3.2.2); or if the parent is a WordSigBlob (section 2.3.2.3), the offset is relative to the beginning
        /// of the parent’s cbSigInfo field.
        self.signatureOffset = try dataStream.read(endianess: .littleEndian)
        
        /// cbSigningCertStore (4 bytes): An unsigned integer that specifies the size of the pbSigningCertStoreBuffer field in bytes.
        self.cbSigningCertStore = try dataStream.read(endianess: .littleEndian)
        
        /// certStoreOffset (4 bytes): An unsigned integer that specifies the offset of the pbSigningCertStoreBuffer field relative to the start of this
        /// structure’s parent DigSigBlob (section 2.3.2.2); or if the parent is a WordSigBlob (section 2.3.2.3), the offset is relative to the start of the
        /// parent’s cbSigInfo field.
        self.certStoreOffset = try dataStream.read(endianess: .littleEndian)
        
        /// cbProjectName (4 bytes): An unsigned integer that specifies the count in bytes of the rgchProjectNameBuffer field, not including the
        /// null-terminating character. MUST be 0x00000000.
        self.cbProjectName = try dataStream.read(endianess: .littleEndian)
        if self.cbProjectName != 0x00000000 {
            throw OfficeFileError.corrupted
        }
        
        /// projectNameOffset (4 bytes): An unsigned integer that specifies the offset of the rgchProjectNameBuffer field relative to the beginning
        /// of this structure’s parent DigSigBlob (section 2.3.2.2); or if the parent is a WordSigBlob (section 2.3.2.3), the offset is relative to the
        /// beginning of the parent’s cbSigInfo field.
        self.projectNameOffset = try dataStream.read(endianess: .littleEndian)
        
        /// fTimestamp (4 bytes): This field is reserved and MUST be 0x00000000. MUST ignore on reading.
        self.fTimestamp = try dataStream.read(endianess: .littleEndian)
        if self.fTimestamp != 0x00000000 {
            throw OfficeFileError.corrupted
        }
        
        /// cbTimestampUrl (4 bytes): An unsigned integer that specifies the count in bytes of the rgchTimestampBuffer field, not including the
        /// null-terminating character. MUST be 0x00000000.
        self.cbTimestampUrl = try dataStream.read(endianess: .littleEndian)
        if self.cbTimestampUrl != 0x00000000 {
            throw OfficeFileError.corrupted
        }
        
        /// timestampUrlOffset (4 bytes): An unsigned integer that specifies the offset of the rgchTimestampBuffer field relative to the beginning of
        /// this structure’s parent DigSigBlob (section 2.3.2.2); or if the parent is a WordSigBlob (section 2.3.2.3), the offset is relative to the
        /// beginning of the parent’s cbSigInfo field.
        self.timestampUrlOffset = try dataStream.read(endianess: .littleEndian)
        
        /// pbSignatureBuffer (variable): An array of bytes that specifies the VBA Digital Signature (section 2.3.2.4) of the VBA project.
        let signaturePosition = startPosition + Int(self.signatureOffset)
        if signaturePosition > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = signaturePosition
        self.pbSignatureBuffer = try dataStream.readBytes(count: Int(self.cbSignature))
        
        /// pbSigningCertStoreBuffer (variable): A VBASigSerializedCertStore structure (section 2.3.2.5.5) containing the public digital certificate
        /// information of the certificate used to create the digital signature.
        let signingCertStorePosition = startPosition + Int(self.certStoreOffset)
        if signingCertStorePosition > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = signingCertStorePosition
        self.pbSigningCertStoreBuffer = try VBASigSerializedCertStore(dataStream: &dataStream)
        
        /// rgchProjectNameBuffer (variable): A null-terminated array of Unicode characters. The field is reserved and MUST be a single null
        /// Unicode character (0x0000).
        let projectNamePosition = startPosition + Int(self.projectNameOffset)
        if projectNamePosition > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = projectNamePosition
        self.rgchProjectNameBuffer = try dataStream.readString(count: Int(self.cbProjectName), encoding: .utf16LittleEndian)!
        if dataStream.position + 1 > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position += 1
        
        /// rgchTimestampBuffer (variable): A null-terminated array of Unicode characters. The field is reserved and MUST be a single null Unicode
        /// character (0x0000).
        let timestampPosition = startPosition + Int(self.timestampUrlOffset)
        if timestampPosition > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = timestampPosition
        self.rgchTimestampBuffer = try dataStream.readString(count: Int(self.cbTimestampUrl), encoding: .utf16LittleEndian)!
        if dataStream.position + 1 > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position += 1
    }
}
