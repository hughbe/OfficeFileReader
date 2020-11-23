//
//  BCBroadcastDateTimeAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.17.18 BCBroadcastDateTimeAtom
/// Referenced by: BroadcastDocInfo9Container
/// An atom record that specifies the directory name to create under the base directory of a presentation broadcast.
/// Let the corresponding presentation broadcast be specified by the BroadcastDocInfo9Container record that contains this BCBroadcastDateTimeAtom
/// record.
public struct BCBroadcastDateTimeAtom {
    public let rh: RecordHeader
    public let broadcastDateTime: FileOrDirNameFragment
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x011.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be an even number. It MUST be less than or equal to 510.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x011 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (rh.recLen % 2) == 0 && rh.recLen <= 510 else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// broadcastDateTime (variable): A FileOrDirNameFragment that specifies the directory name to create under the base directory specified in
        /// the bcPptFilesBaseDirAtom field of the corresponding presentation broadcast. The length, in bytes, of the field is specified by rh.recLen.
        self.broadcastDateTime = try FileOrDirNameFragment(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

