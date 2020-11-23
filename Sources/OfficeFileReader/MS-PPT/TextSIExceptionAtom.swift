//
//  TextSIExceptionAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.31 TextSIExceptionAtom
/// Referenced by: DocumentTextInfoContainer
/// An atom record that specifies default settings for language and spelling information.
public struct TextSIExceptionAtom {
    public let rh: RecordHeader
    public let textSIException: TextSIException
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TextSpecialInfoDefaultAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textSpecialInfoDefaultAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// textSIException (variable): A TextSIException structure that specifies default settings for language and spelling information. The length,
        /// in bytes, of the field is specified by rh.recLen. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// textSIException.fPp10ext MUST be zero.
        /// textSIException.fBidi MUST be zero.
        /// textSIException.smartTag MUST be zero.
        self.textSIException = try TextSIException(dataStream: &dataStream)
        guard !self.textSIException.fPp10ext &&
                !self.textSIException.fBidi &&
                !self.textSIException.smartTag else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
