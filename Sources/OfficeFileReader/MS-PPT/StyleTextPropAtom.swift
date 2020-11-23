//
//  StyleTextPropAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.44 StyleTextPropAtom
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// An atom record that specifies character-level and paragraph-level formatting.
/// Let the corresponding text be specified by the TextHeaderAtom record that most closely precedes this record.
/// Let the corresponding shape be as specified in the corresponding text.
/// Let the corresponding main master be as specified in the corresponding text.
/// If the corresponding shape is a placeholder shape, character-level and paragraph-level formatting not specified by this StyleTextPropAtom record inherit
/// from the TextMasterStyleAtom records contained in the corresponding main master.
public struct StyleTextPropAtom {
    public let rh: RecordHeader
    public let rgTextPFRun: [TextPFRun]
    public let rgTextCFRun: [TextCFRun]
    
    public init(dataStream: inout DataStream, textCount: Int) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_StyleTextPropAtom.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .styleTextPropAtom else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh

        let startPosition = dataStream.position

        /// rgTextPFRun (variable): An array of TextPFRun structures that specifies paragraph-level formatting for the corresponding text. The count field of
        /// each TextPFRun item specifies the number of characters to which the formatting applies, starting with the character at the zero-based index
        /// equal to the sum of the count fields of all previous TextPFRun records in the array.
        /// The sum of the count fields of the TextPFRun items MUST be equal to the number of characters in the corresponding text.
        var rgTextPFRun: [TextPFRun] = []
        var rgTextPFRunSum: UInt32 = 0
        while rgTextPFRunSum <= textCount {
            let run = try TextPFRun(dataStream: &dataStream)
            rgTextPFRun.append(run)
            rgTextPFRunSum += run.count
        }
        
        self.rgTextPFRun = rgTextPFRun
        
        /// rgTextCFRun (variable): An array of TextCFRun structures that specifies character-level formatting for the corresponding text. The count field
        /// of each TextCFRun specifies the number of characters to which the formatting applies, starting with the character at the zero-based index equal
        /// to the sum of the count fields of all previous TextCFRun records in the array.
        /// The sum of the count fields of the TextCFRun items MUST be equal to the number of characters in the corresponding text.
        var rgTextCFRun: [TextCFRun] = []
        var rgTextCFRunSum: UInt32 = 0
        while rgTextCFRunSum <= textCount {
            let run = try TextCFRun(dataStream: &dataStream)
            rgTextCFRun.append(run)
            rgTextCFRunSum += run.count
        }
        
        self.rgTextCFRun = rgTextCFRun
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
