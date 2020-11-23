//
//  TextDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.19 TextDiffContainer
/// Referenced by: ShapeDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to the text of a shape.
/// Let the corresponding shape be as specified in the ShapeDiffContainer record that contains this TextDiffContainer record.
/// Let the corresponding text be as specified in the OfficeArtClientTextbox record contained within the corresponding shape.
public struct TextDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved1: Bool
    public let wordList: Bool
    public let reserved2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_TextDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .textDiff else {
            throw OfficeFileError.corrupted
        }
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - reserved1 (2 bits): MUST be zero and MUST be ignored.
        self.reserved1 = flags.readBit()
        
        /// B - wordList (1 bit): A bit that specifies whether the changes made by the reviewer to the corresponding text are not displayed.
        self.wordList = flags.readBit()
        
        /// reserved2 (29 bits): MUST be zero and MUST be ignored.
        self.reserved2 = flags.readRemainingBits()
    }
}
