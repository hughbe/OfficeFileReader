//
//  ExOleLinkAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.30 ExOleLinkAtom
/// Referenced by: ExOleLinkContainer
/// An atom record that specifies information about a linked OLE object
public struct ExOleLinkAtom {
    public let rh: RecordHeader
    public let slideIdRef: SlideIdRef
    public let oleUpdateMode: ObjectUpdateEnum
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalOleLinkAtom.
        /// rh.recLen MUST be 0x0000000C.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalOleLinkAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000000C else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// slideIdRef (4 bytes): A SlideIdRef (section 2.2.25) that specifies the presentation slide associated with this OLE object.
        self.slideIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// oleUpdateMode (4 bytes): An ObjectUpdateEnum ([MS-OSHARED] section 2.2.1.1) that specifies how the OLE object is updated.
        guard let oleUpdateMode = ObjectUpdateEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.oleUpdateMode = oleUpdateMode
        
        /// unused (4 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
