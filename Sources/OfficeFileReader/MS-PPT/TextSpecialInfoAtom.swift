//
//  TextSpecialInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.54 TextSpecialInfoAtom
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// An atom record that specifies additional text properties.
/// Let the corresponding text be specified by the TextHeaderAtom record that most closely precedes this record.
public struct TextSpecialInfoAtom {
    public let rh: RecordHeader
    public let rgSIRun: [TextSIRun]
    
    public init(dataStream: inout DataStream, textCount: Int) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TextSpecialInfoAtom.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        if rh.recInstance != 0x000 {
            throw OfficeFileError.corrupted
        }
        if rh.recType != .textSpecialInfoAtom {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh

        let startPosition = dataStream.position

        /// rgSIRun (variable): An array of TextSIRun structures that specifies additional text properties for the corresponding text. The count field of each
        /// TextSIRun specifies the number of characters to which the properties apply, starting with the character at the zero-based index equal to the
        /// sum of the count fields of all previous TextSIRun records in the array.
        /// The sum of the count fields of the TextSIRun items MUST be equal to the number of characters in the corresponding text. The length, in bytes,
        /// of the array is specified by rh.recLen.
        var rgSIRun: [TextSIRun] = []
        var rgSIRunSum: UInt32 = 0
        while rgSIRunSum <= textCount && dataStream.position - startPosition < rh.recLen {
            let run = try TextSIRun(dataStream: &dataStream)
            rgSIRun.append(run)
            rgSIRunSum += run.count
        }
        
        self.rgSIRun = rgSIRun
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
