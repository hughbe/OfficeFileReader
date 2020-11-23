//
//  MasterListWithTextContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.14.1 MasterListWithTextContainer
/// Referenced by: DocumentContainer
/// A container record that specifies a list of references to main master slides and title master slides.
public struct MasterListWithTextContainer {
    public let rh: RecordHeader
    public let rgMasterPersistAtom: [MasterPersistAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be RT_SlideListWithText.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideListWithText else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgMasterPersistAtom (variable): An array of MasterPersistAtom records (section 2.4.14.2) that specifies references to the main master slides
        /// and title master slides. The length, in bytes, of the array is specified by rh.recLen.
        var rgMasterPersistAtom: [MasterPersistAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgMasterPersistAtom.append(try MasterPersistAtom(dataStream: &dataStream))
        }
        self.rgMasterPersistAtom = rgMasterPersistAtom
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
