//
//  PrintOptionsAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.12 PrintOptionsAtom
/// Referenced by: DocumentContainer
/// An atom record that specifies user preferences for printing the document.
public struct PrintOptionsAtom {
    public let rh: RecordHeader
    public let printWhat: PrintWhatEnum
    public let colorMode: ColorModeEnum
    public let fPrintHidden: bool1
    public let fScaleToFitPaper: bool1
    public let fFrameSlides: bool1
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_PrintOptionsAtom.
        /// rh.recLen MUST be 0x00000005.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .printOptionsAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000005 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// printWhat (1 byte): A PrintWhatEnum enumeration that specifies what is printed.
        guard let printWhat = PrintWhatEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.printWhat = printWhat
        
        /// colorMode (1 byte): A ColorModeEnum enumeration that specifies how colors are printed.
        guard let colorMode = ColorModeEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.colorMode = colorMode
        
        /// fPrintHidden (1 byte): A bool1 (section 2.2.2) that specifies whether hidden slides are printed.
        self.fPrintHidden = try bool1(dataStream: &dataStream)
        
        /// fScaleToFitPaper (1 byte): A bool1 that specifies whether the slide is scaled as large as possible to fit the printable area of the page and
        /// maintain its aspect ratio.
        self.fScaleToFitPaper = try bool1(dataStream: &dataStream)
        
        /// fFrameSlides (1 byte): A bool1 that specifies whether a border is drawn around each slide.
        self.fFrameSlides = try bool1(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
