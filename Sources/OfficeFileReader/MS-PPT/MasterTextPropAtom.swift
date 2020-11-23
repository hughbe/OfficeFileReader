//
//  MasterTextPropAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.79 MasterTextPropAtom
/// Referenced by: TextClientDataSubContainerOrAtom
/// An atom record that specifies the indent levels for the text.
/// Let the corresponding text be specified by the TextHeaderAtom record that most closely precedes this MasterTextPropAtom record.
public struct MasterTextPropAtom {
    public let rh: RecordHeader
    public let rgMasterTextPropRun: [MasterTextPropRun]
    
    public init(dataStream: inout DataStream, textCount: Int) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_MasterTextPropAtom.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        if rh.recInstance != 0x000 {
            throw OfficeFileError.corrupted
        }
        if rh.recType != .masterTextPropAtom {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// rgMasterTextPropRun (variable): An array of MasterTextPropRun structures that specifies indent levels. The count field of each MasterTextPropRun
        /// specifies the number of characters to which the indent level applies, starting with the character at the zero-based index equal to the sum of the
        /// count fields of all previous MasterTextPropRun items in the array.
        /// The sum of the count fields of the array items MUST be equal to the number of characters in the corresponding text. The length, in bytes, of the
        /// array is specified by rh.recLen.
        var rgMasterTextPropRun: [MasterTextPropRun] = []
        var rgMasterTextPropRunSum: UInt32 = 0
        while rgMasterTextPropRunSum < textCount && dataStream.position - startPosition < rh.recLen {
            let run = try MasterTextPropRun(dataStream: &dataStream)
            rgMasterTextPropRun.append(run)
            rgMasterTextPropRunSum += run.count
        }
        
        self.rgMasterTextPropRun = rgMasterTextPropRun
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
