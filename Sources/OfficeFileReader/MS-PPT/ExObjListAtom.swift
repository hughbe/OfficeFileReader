//
//  ExObjListAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.3 ExObjListAtom
/// Referenced by: ExObjListContainer
/// An atom record that specifies properties for the containing ExObjListContainer record (section 2.10.1).
public struct ExObjListAtom {
    public let rh: RecordHeader
    public let exObjIdSeed: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalObjectListAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalObjectListAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exObjIdSeed (4 bytes): A signed integer that specifies a seed for creating a new ExObjId (section 2.2.7) or ExHyperlinkId (section 2.2.5) value.
        /// It MUST be greater than or equal to the largest ExObjId value in the file as specified by the ExMediaAtom record (section 2.10.6) or
        /// ExOleObjAtom record (section 2.10.12) and MUST be greater than or equal to the largest ExHyperlinkId value in the file as specified by the
        /// ExHyperlinkAtom record (section 2.10.17). It MUST be greater than or equal to 0x00000001.
        self.exObjIdSeed = try dataStream.read(endianess: .littleEndian)
        guard self.exObjIdSeed >= 0x00000001 else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
