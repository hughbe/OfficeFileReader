//
//  SPLS.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.256 SPLS
/// The SPLS structure specifies the current state of a range of text with regard to one of the language checking features such as the spell-checker,
/// grammar-checker, language auto-detection, or smart tag recognizer.
public struct SPLS {
    public let splf: Splf
    public let fError: Bool
    public let fExtend: Bool
    public let fTypo: Bool
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var rawValue: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// splf (4 bits): This MUST be one of the following values.
        let splfRaw = UInt8(rawValue.readBits(count: 4))
        guard let splf = Splf(rawValue: splfRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.splf = splf
        
        /// A - fError (1 bit): The range is an error. This bit MUST be set when the splf value is splfErrorMin, splfRepeatWord, or splfUnknownWord. It can
        /// also be set when the splf value is splfDirty or splfEdit, which both indicate that the range is currently an error but is still subject to further
        /// checking. This bit MUST NOT be set for any other splf value.
        self.fError = rawValue.readBit()
        
        /// B - fExtend (1 bit): The range is an error. When rechecked, the surrounding text is also rechecked.
        self.fExtend = rawValue.readBit()
        
        /// C - fTypo (1 bit): The range is a spelling error that was caught by a grammar-checker.
        self.fTypo = rawValue.readBit()
        
        /// unused (9 bits): This field is not used. This value MUST be zero.
        self.unused = rawValue.readRemainingBits()
    }
    
    /// splf (4 bits): This MUST be one of the following values.
    public enum Splf: UInt8 {
        /// splfPending 0x1 Specifies that the text range is currently undergoing checking in another thread. Used only within the PlcfFactoid structure.
        /// On load, this is converted to splfDirty.
        case pending = 0x1
        
        /// splfMaybeDirty 0x2 Specifies that the text range was edited, and could be re-scanned. Having text ranges in the document with this value
        /// does not, by itself, cause a new scan. This value MUST only be used in the header document.
        case maybeDirty = 0x2
        
        /// splfDirty 0x3 Specifies that the text range was created or changed since the last scan, and that a new scan is needed to evaluate it. Additionally,
        /// the PlcfGram structure SHOULD<239> use this value for all grammatical errors, in which case fError is set to 1.
        case dirty = 0x3
        
        /// splfEdit 0x4 Specifies that the text range has been created or changed, and that the user is still editing in the vicinity. A scan is not needed for
        /// this text range until the user can be assumed to be finished making the edits.
        case edit = 0x4
        
        /// splfForeign 0x5 Specifies that the text range is a foreign language or phrase. When used by the language auto-detection, the language was
        /// explicitly set and no auto-detection is necessary. When used by the spell-checker or grammar-checker, the text range is not subject to further
        /// checking.
        case foreign = 5
        
        /// splfClean 0x7 Specifies that the text range was checked and contains no errors or other special states.
        case clean = 7
        
        /// splfNoLAD 0x8 Specifies that the text range is to be skipped by language autodetection. Used only within Plcflad.
        case noLad = 0x8
        
        /// splfErrorMin 0xA Specifies that the text range contains an error.
        case errorMin = 0xA
        
        /// splfRepeatWord 0xB Specifies that the text range contains a word or phrase that duplicates a preceding word or phrase. It is an error.
        case repeatWord = 0xB
        
        /// splfUnknownWord 0xC Specifies that the text range contains a word that is unknown to the language checker. It is an error.
        case unknownWord = 0xC
    }
}
