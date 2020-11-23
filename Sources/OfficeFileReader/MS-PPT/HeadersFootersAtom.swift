//
//  HeadersFootersAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.15.2 HeadersFootersAtom
/// Referenced by: NotesHeadersFootersContainer, PerSlideHeadersFootersContainer, SlideHeadersFootersContainer
/// An atom record that specifies options for displaying headers and footers on a presentation slide or notes slide.
public struct HeadersFootersAtom {
    public let rh: RecordHeader
    public let formatId: Int16
    public let fHasDate: Bool
    public let fHasTodayDate: Bool
    public let fHasUserDate: Bool
    public let fHasSlideNumber: Bool
    public let fHasHeader: Bool
    public let fHasFooter: Bool
    public let reserved: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_HeadersFootersAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .headersFootersAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// formatId (2 bytes): A signed integer that specifies the format identifier to be used to style the date and time. It MUST be greater than or
        /// equal to 0x0000 and less than or equal to 0x000D. It SHOULD<12> be less than or equal to 0x000C. This value is converted into a string
        /// as specified by the index field of the DateTimeMCAtom record. It MUST be ignored unless fHasTodayDate is TRUE.
        let formatId: Int16 = try dataStream.read(endianess: .littleEndian)
        guard formatId >= 0x0000 && formatId <= 0x000D else {
            throw OfficeFileError.corrupted
        }
        
        self.formatId = formatId
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fHasDate (1 bit): A bit that specifies whether the date is displayed in the footer.
        self.fHasDate = flags.readBit()
        
        /// B - fHasTodayDate (1 bit): A bit that specifies whether the current datetime is used for displaying the datetime.
        self.fHasTodayDate = flags.readBit()
        
        /// C - fHasUserDate (1 bit): A bit that specifies whether the date specified in UserDateAtom record is used for displaying the datetime.
        self.fHasUserDate = flags.readBit()
        
        /// D - fHasSlideNumber (1 bit): A bit that specifies whether the slide number is displayed in the footer.
        self.fHasSlideNumber = flags.readBit()
        
        /// E - fHasHeader (1 bit): A bit that specifies whether the header text specified by HeaderAtom record is displayed.
        self.fHasHeader = flags.readBit()
        
        /// F - fHasFooter (1 bit): A bit that specifies whether the footer text specified by FooterAtom record is displayed.
        self.fHasFooter = flags.readBit()
        
        /// reserved (10 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
