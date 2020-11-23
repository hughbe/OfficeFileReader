//
//  TextMasterStyleAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.35 TextMasterStyleAtom
/// Referenced by: DocumentTextInfoContainer, MainMasterContainer
/// An atom record that specifies the character-level and paragraph-level formatting of a main master slide.
/// If this TextMasterStyleAtom is contained in a MainMasterContainer record (section 2.5.3), character-level and paragraph-level formatting not specified
/// by this TextMasterStyleAtom record inherit from the TextMasterStyleAtom record contained in the DocumentTextInfoContainer record (section 2.9.1).
public struct TextMasterStyleAtom {
    public let rh: RecordHeader
    public let textType: TextTypeEnum
    public let cLevels: UInt16
    public let lstLvl1: TextMasterStyleLevel?
    public let lstLvl2: TextMasterStyleLevel?
    public let lstLvl3: TextMasterStyleLevel?
    public let lstLvl4: TextMasterStyleLevel?
    public let lstLvl5: TextMasterStyleLevel?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance Specifies the type of text to which the formatting applies. It MUST be a TextTypeEnum enumeration value.
        /// rh.recType MUST be an RT_TextMasterStyleAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard let textType = TextTypeEnum(rawValue: UInt32(self.rh.recInstance)) else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textMasterStyleAtom else {
            throw OfficeFileError.corrupted
        }
        
        self.textType = textType
        
        let startPosition = dataStream.position
        
        /// cLevels (2 bytes): An unsigned integer that specifies the number of style levels. It MUST be less than or equal to 0x0005.
        self.cLevels = try dataStream.read(endianess: .littleEndian)
        guard self.cLevels <= 0x0005 else {
            throw OfficeFileError.corrupted
        }
        
        /// lstLvl1 (variable): An optional TextMasterStyleLevel structure that specifies the master formatting for text that has an IndentLevel equal to
        /// 0x0000. It MUST exist if and only if cLevels is greater than 0x0000.
        if self.cLevels > 0x0000 {
            self.lstLvl1 = try TextMasterStyleLevel(dataStream: &dataStream, textType: self.textType)
        } else {
            self.lstLvl1 = nil
            self.lstLvl2 = nil
            self.lstLvl3 = nil
            self.lstLvl4 = nil
            self.lstLvl5 = nil
            return
        }

        /// lstLvl2 (variable): An optional TextMasterStyleLevel structure that specifies the master formatting for text that has an IndentLevel equal to
        /// 0x0001. It MUST exist if and only if cLevels is greater than 0x0001.
        if self.cLevels > 0x0001 {
            self.lstLvl2 = try TextMasterStyleLevel(dataStream: &dataStream, textType: self.textType)
        } else {
            self.lstLvl2 = nil
            self.lstLvl3 = nil
            self.lstLvl4 = nil
            self.lstLvl5 = nil
            return
        }
        
        /// lstLvl3 (variable): An optional TextMasterStyleLevel structure that specifies the master formatting for text that has an IndentLevel equal to
        /// 0x0002. It MUST exist if and only if cLevels is greater than 0x0002.
        if self.cLevels > 0x0002 {
            self.lstLvl3 = try TextMasterStyleLevel(dataStream: &dataStream, textType: self.textType)
        } else {
            self.lstLvl3 = nil
            self.lstLvl4 = nil
            self.lstLvl5 = nil
            return
        }
        
        /// lstLvl4 (variable): An optional TextMasterStyleLevel structure that specifies the master formatting for text that has an IndentLevel equal to
        /// 0x0003. It MUST exist if and only if cLevels is greater than 0x0003.
        if self.cLevels > 0x0003 {
            self.lstLvl4 = try TextMasterStyleLevel(dataStream: &dataStream, textType: self.textType)
        } else {
            self.lstLvl4 = nil
            self.lstLvl5 = nil
            return
        }
        
        /// lstLvl5 (variable): An optional TextMasterStyleLevel structure that specifies the master formatting for text that has an IndentLevel equal to
        /// 0x0004. It MUST exist if and only if cLevels is greater than 0x0004.
        if self.cLevels > 0x0004 {
            self.lstLvl5 = try TextMasterStyleLevel(dataStream: &dataStream, textType: self.textType)
        } else {
            self.lstLvl5 = nil
            return
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
