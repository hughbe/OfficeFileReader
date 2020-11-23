//
//  BCAsdFileNameAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.17.20 BCAsdFileNameAtom
/// Referenced by: BroadcastDocInfo9Container
/// An atom record that specifies the location of an ASD file for a presentation broadcast. The ASD file is the description file for an Advanced Systems
/// Format (ASF) file, described in [ASF], used to stream audio and video content.
/// Let the corresponding presentation broadcast be specified by the BroadcastDocInfo9Container record that contains this BCAsdFileNameAtom record.
public struct BCAsdFileNameAtom {
    public let rh: RecordHeader
    public let asdFileName: UncPath
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x013.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be an even number. It MUST be less than or equal to 510.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x013 else {
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

        /// asdFileName (variable): A UncPath that specifies the location of an ASD file for the corresponding presentation broadcast. The length, in
        /// bytes, of the field is specified by rh.recLen.
        self.asdFileName = try UncPath(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

