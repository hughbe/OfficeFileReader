//
//  VBAInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.11 VBAInfoAtom
/// Referenced by: VBAInfoContainer
/// An atom record that specifies a reference to the VBA project storage.
public struct VBAInfoAtom {
    public let rh: RecordHeader
    public let persistIdRef: PersistIdRef
    public let fHasMacros: UInt32
    public let version: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x2.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_VbaInfoAtom.
        /// rh.recLen MUST be 0x0000000C.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x2 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .vbaInfoAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000000C else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// persistIdRef (4 bytes): A PersistIdRef (section 2.2.21) that specifies the value to look up in the persist object directory to find the offset of
        /// a VbaProjectStg record (section 2.10.40).
        self.persistIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// fHasMacros (4 bytes): An unsigned integer that specifies whether the VBA project storage contains data. It MUST be a value from the
        /// following table.
        /// Value Meaning
        /// 0x00000000 The VBA storage is empty.
        /// 0x00000001 The VBA storage contains data.
        self.fHasMacros = try dataStream.read(endianess: .littleEndian)
        
        /// version (4 bytes): An unsigned integer that specifies the VBA runtime version that generated the VBA project storage. It MUST be 0x00000002.
        self.version = try dataStream.read(endianess: .littleEndian)
        // Note: spec requires 0x00000002 but seen 0x00000001
        guard self.version == 0x00000002 || self.version == 0x00000001 else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
