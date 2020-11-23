//
//  MetafileBlob.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.6 MetafileBlob
/// Referenced by: ExControlContainer, ExOleEmbedContainer, ExOleLinkContainer
/// An atom record that specifies a metafile ([MS-WMF]).
public struct MetafileBlob {
    public let rh: RecordHeader
    public let mm: MapMode
    public let xExt: Int16
    public let yExt: Int16
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_MetaFile.
        /// rh.recLen MUST be greater than 0x00000010.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .metaFile else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen > 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// mm (2 bytes): A signed integer that specifies the mapping mode of the metafile as specified in [MSWMF] section 2.1.1.16.
        guard let mm = MapMode(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.mm = mm
        
        /// xExt (2 bytes): A signed integer that specifies the width of the metafile in units that correspond to the mapping mode specified by the
        /// mm field as specified in [MS-WMF] section 2.1.1.16.
        self.xExt = try dataStream.read(endianess: .littleEndian)
        
        /// yExt (2 bytes): A signed integer that specifies the height of the metafile in units that correspond to the mapping mode specified by the
        /// mm field as specified in [MS-WMF] section 2.1.1.16.
        self.yExt = try dataStream.read(endianess: .littleEndian)
        
        /// data (variable): A metafile as specified in [MS-WMF]. The length, in bytes, of the field is specified by the following formula:
        /// rh.recLen – 6.
        self.data = try dataStream.readBytes(count: Int(self.rh.recLen) - 6)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

