//
//  BlipEntityAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.73 BlipEntityAtom
/// Referenced by: BlipCollection9Container
/// An atom record that specifies a picture bullet.
public struct BlipEntityAtom {
    public let rh: RecordHeader
    public let winBlipType: BlipType
    public let unused: UInt8
    public let blip: OfficeArtBStoreContainerFileBlock
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance An unsigned integer that specifies a zero-based index of a picture bullet within the collection of picture bullets specified by
        /// BlipCollection9Container (section 2.9.72). It MUST be greater than or equal to 0x000 and less than or equal to 0x080.
        /// rh.recType MUST be an RT_BlipEntity9Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance <= 0x080 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .blipEntity9Atom else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        
        /// winBlipType (1 byte): An unsigned integer that specifies the preferred picture type. It MUST be one of the values in the following table.
        guard let winBlipType = BlipType(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.winBlipType = winBlipType
        
        /// unused (1 byte): Undefined and MUST be ignored.
        self.unused = try dataStream.read()
        
        /// blip (variable): An OfficeArtBStoreContainerFileBlock ([MS-ODRAW] section 2.2.22) that specifies the picture data for the picture bullet.
        self.blip = try OfficeArtBStoreContainerFileBlock(dataStream: &dataStream)
                
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// winBlipType (1 byte): An unsigned integer that specifies the preferred picture type. It MUST be one of the values in the following table.
    public enum BlipType: UInt8 {
        /// 0x02 Windows Enhanced Metafile [MS-EMF]
        case emf = 0x02
        
        /// 0x03 Windows Metafile [MS-WMF]
        case wmf = 0x03
        
        /// 0x05 JPEG [JFIF]
        case jpeg = 0x05
        
        /// 0x06 PNG [RFC2083]
        case png = 0x06
    }
}
