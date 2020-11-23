//
//  BlipCollection9Container.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.72 BlipCollection9Container
/// Referenced by: PP9DocBinaryTagExtension
/// A container record that specifies information about picture bullet points
public struct BlipCollection9Container {
    public let rh: RecordHeader
    public let rgBlipEntityAtom: [BlipEntityAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_BlipCollection9.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .blipCollection9 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        
        /// rgBlipEntityAtom (variable): An array of BlipEntityAtom record that specifies picture bullets. It MUST NOT contain more than one
        /// BlipEntityAtom record with the same value of rh.recInstance. The size, in bytes, of the array is specified by rh.recLen.
        var rgBlipEntityAtom: [BlipEntityAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgBlipEntityAtom.append(try BlipEntityAtom(dataStream: &dataStream))
        }
        
        self.rgBlipEntityAtom = rgBlipEntityAtom
                
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
