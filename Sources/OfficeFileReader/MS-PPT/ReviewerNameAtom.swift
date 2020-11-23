//
//  ReviewerNameAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.6 ReviewerNameAtom
/// Referenced by: DiffTree10Container
/// An atom record that specifies the name of the reviewer who made changes to a copy of the document that was later merged into this document.
/// The name of the reviewer MUST be the value of the GKPIDSI_AUTHOR property ([MS-OSHARED] section 2.3.3.2.1.1) of the Summary Info Stream
/// (section 2.1.4) specified in the corresponding reviewer document.
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this ReviewerNameAtom record.
public struct ReviewerNameAtom {
    public let rh: RecordHeader
    public let reviewerName: PrintableUnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x003.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be an even number. It MUST be less than or equal to 104.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (rh.recLen % 2) == 0 && rh.recLen <= 104 else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// reviewerName (variable): A PrintableUnicodeString (section 2.2.23) that specifies the name of the reviewer. The length, in bytes, of the field
        /// is specified by rh.recLen.
        self.reviewerName = try PrintableUnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

