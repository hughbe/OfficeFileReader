//
//  DocumentTextInfoContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.1 DocumentTextInfoContainer
/// Referenced by: DocumentContainer
/// A container record that specifies default settings and user preferences for text.
public struct DocumentTextInfoContainer {
    public let rh: RecordHeader
    public let kinsoku: KinsokuContainer?
    public let fontCollection: FontCollectionContainer?
    public let textCFDefaultsAtom: TextCFExceptionAtom?
    public let textPFDefaultsAtom: TextPFExceptionAtom?
    public let defaultRulerAtom: DefaultRulerAtom?
    public let textSIDefaultsAtom: TextSIExceptionAtom?
    public let textMasterStyleAtom: TextMasterStyleAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_Environment.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .environment else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.kinsoku = nil
            self.fontCollection = nil
            self.textCFDefaultsAtom = nil
            self.textPFDefaultsAtom = nil
            self.defaultRulerAtom = nil
            self.textSIDefaultsAtom = nil
            self.textMasterStyleAtom = nil
            return
        }
        
        /// kinsoku (variable): An optional KinsokuContainer record (section 2.9.2) that specifies the user preferences for East Asian text line breaking
        /// settings.
        if try dataStream.peekRecordHeader().recType == .kinsoku {
            self.kinsoku = try KinsokuContainer(dataStream: &dataStream)
        } else {
            self.kinsoku = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.fontCollection = nil
            self.textCFDefaultsAtom = nil
            self.textPFDefaultsAtom = nil
            self.defaultRulerAtom = nil
            self.textSIDefaultsAtom = nil
            self.textMasterStyleAtom = nil
            return
        }
        
        /// fontCollection (variable): An optional FontCollectionContainer record (section 2.9.8) that specifies the collection of fonts used.
        if try dataStream.peekRecordHeader().recType == .fontCollection {
            self.fontCollection = try FontCollectionContainer(dataStream: &dataStream)
        } else {
            self.fontCollection = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.textCFDefaultsAtom = nil
            self.textPFDefaultsAtom = nil
            self.defaultRulerAtom = nil
            self.textSIDefaultsAtom = nil
            self.textMasterStyleAtom = nil
            return
        }
        
        /// textCFDefaultsAtom (variable): An optional TextCFExceptionAtom record that specifies default settings for character-level style and formatting.
        if try dataStream.peekRecordHeader().recType == .textCharFormatExceptionAtom {
            self.textCFDefaultsAtom = try TextCFExceptionAtom(dataStream: &dataStream)
        } else {
            self.textCFDefaultsAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.textPFDefaultsAtom = nil
            self.defaultRulerAtom = nil
            self.textSIDefaultsAtom = nil
            self.textMasterStyleAtom = nil
            return
        }
        
        /// textPFDefaultsAtom (variable): An optional TextPFExceptionAtom record that specifies default settings for paragraph-level style and formatting.
        if try dataStream.peekRecordHeader().recType == .textParagraphFormatExceptionAtom {
            self.textPFDefaultsAtom = try TextPFExceptionAtom(dataStream: &dataStream)
        } else {
            self.textPFDefaultsAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.defaultRulerAtom = nil
            self.textSIDefaultsAtom = nil
            self.textMasterStyleAtom = nil
            return
        }
        
        /// defaultRulerAtom (variable): An optional DefaultRulerAtom record that specifies the default ruler and corresponding options.
        if try dataStream.peekRecordHeader().recType == .defaultRulerAtom {
            self.defaultRulerAtom = try DefaultRulerAtom(dataStream: &dataStream)
        } else {
            self.defaultRulerAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.textSIDefaultsAtom = nil
            self.textMasterStyleAtom = nil
            return
        }
        
        /// textSIDefaultsAtom (variable): A TextSIExceptionAtom record that specifies default settings for language and spelling information.
        if try dataStream.peekRecordHeader().recType == .textSpecialInfoDefaultAtom {
            self.textSIDefaultsAtom = try TextSIExceptionAtom(dataStream: &dataStream)
        } else {
            self.textSIDefaultsAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.textMasterStyleAtom = nil
            return
        }
        
        /// textMasterStyleAtom (variable): A TextMasterStyleAtom record that specifies the character-level and paragraph-level formatting of a main
        /// master slide.
        if try dataStream.peekRecordHeader().recType == .textMasterStyleAtom {
            self.textMasterStyleAtom = try TextMasterStyleAtom(dataStream: &dataStream)
        } else {
            self.textMasterStyleAtom = nil
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
