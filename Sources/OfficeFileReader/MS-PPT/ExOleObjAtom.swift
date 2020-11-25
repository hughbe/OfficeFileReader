//
//  ExOleObjAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.12 ExOleObjAtom
/// Referenced by: ExControlContainer, ExOleEmbedContainer, ExOleLinkContainer
/// An atom record that specifies information about OLE objects. Each ExOleObjAtom MUST be referred to by exactly one ExObjRefAtom.
public struct ExOleObjAtom {
    public let rh: RecordHeader
    public let drawAspect: DataViewAspectEnum
    public let type: ExOleObjTypeEnum
    public let exObjId: ExObjId
    public let subType: ExOleObjSubTypeEnum
    public let persistIdRef: PersistIdRef
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x1.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalOleObjectAtom.
        /// rh.recLen MUST be 0x00000018.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x1 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalOleObjectAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000018 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// drawAspect (4 bytes): A DataViewAspectEnum ([MS-OSHARED] section 2.2.1.2) that specifies the view aspect used to display the OLE
        /// object.
        guard let drawAspect = DataViewAspectEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.drawAspect = drawAspect
        
        /// type (4 bytes): An ExOleObjTypeEnum enumeration that specifies the type of OLE object.
        guard let type = ExOleObjTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.type = type
        
        /// exObjId (4 bytes): An ExObjId (section 2.2.7) that specifies a unique identifier for the OLE object.
        self.exObjId = try ExObjId(dataStream: &dataStream)
        
        /// subType (4 bytes): An ExOleObjSubTypeEnum enumeration that specifies the sub-type of the OLE object.
        guard let subType = ExOleObjSubTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.subType = subType
        
        /// persistIdRef (4 bytes): A PersistIdRef (section 2.2.21) that specifies the value to look up in the persist object directory to find the offset of
        /// an ExOleObjStg (section 2.10.34) or an ExControlStg (section 2.10.37).
        self.persistIdRef = try PersistIdRef(dataStream: &dataStream)
        
        /// unused (4 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
