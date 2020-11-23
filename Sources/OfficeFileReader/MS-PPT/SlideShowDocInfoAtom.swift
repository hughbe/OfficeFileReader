//
//  SlideShowDocInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.6.1 SlideShowDocInfoAtom
/// Referenced by: DocumentContainer
/// An atom record that specifies how a slide show is displayed.
public struct SlideShowDocInfoAtom {
    public let rh: RecordHeader
    public let penColor: ColorIndexStruct
    public let restartTime: Int32
    public let startSlide: Int16
    public let endSlide: Int16
    public let namedShow: String
    public let fAutoAdvance: Bool
    public let fWillSkipBuilds: Bool
    public let fUseSlideRange: Bool
    public let fDocUseNamedShow: Bool
    public let fBrowseMode: Bool
    public let fKioskMode: Bool
    public let fWillSkipNarration: Bool
    public let fLoopContinuously: Bool
    public let fHideScrollBar: Bool
    public let reserved: UInt8
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x1.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlideShowDocInfoAtom.
        /// rh.recLen MUST be 0x00000050.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x1 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideShowDocInfoAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000050 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// penColor (4 bytes): A ColorIndexStruct structure that specifies a color used to annotate presentation slides during a slide show.
        self.penColor = try ColorIndexStruct(dataStream: &dataStream)
        
        /// restartTime (4 bytes): A signed integer that specifies an amount of time, in milliseconds, to wait during a period of inactivity before
        /// restarting a slide show in kiosk mode.
        self.restartTime = try dataStream.read(endianess: .littleEndian)
        
        /// startSlide (2 bytes): A signed integer that specifies the one-based index of the slide with which the slide show starts. It MUST be
        /// greater than or equal to 0x0000. If fUseSlideRange is TRUE, it MUST NOT be set to 0x0000.
        self.startSlide = try dataStream.read(endianess: .littleEndian)
        if self.startSlide < 0 {
            throw OfficeFileError.corrupted
        }

        /// endSlide (2 bytes): A signed integer that specifies the one-based index of the slide with which the slide show ends. It MUST be greater
        /// than or equal to 0x0000. If fUseSlideRange is TRUE, it MUST NOT be set to 0x0000.
        self.endSlide = try dataStream.read(endianess: .littleEndian)
        if self.endSlide < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// namedShow (64 bytes): A char2 that specifies the name of a named show to use when running the slide show.
        self.namedShow = try dataStream.readString(count: 64, encoding: .utf16LittleEndian)!.trimmingCharacters(in: ["\0"])
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fAutoAdvance (1 bit): A bit that specifies whether to automatically advance to the next slide during a slide show based on timing
        /// information on the slide.
        self.fAutoAdvance = flags.readBit()
        
        /// B - fWillSkipBuilds (1 bit): A bit that specifies whether to display animations during a slide show.
        self.fWillSkipBuilds = flags.readBit()
        
        /// C - fUseSlideRange (1 bit): A bit that specifies whether to display only the slide range specified by the startSlide and endSlide fields
        /// during a slide show.
        self.fUseSlideRange = flags.readBit()
        
        /// D - fDocUseNamedShow (1 bit): A bit that specifies whether the slides shown during a slide show are from the named show identified
        /// by namedShow. It MUST be ignored if fUseSlideRange is TRUE.
        self.fDocUseNamedShow = flags.readBit()
        
        /// E - fBrowseMode (1 bit): A bit that specifies whether the slide show is presented in a way optimized for browsing. If fBrowseMode is
        /// TRUE, fKioskMode MUST be FALSE.
        self.fBrowseMode = flags.readBit()
        
        /// F - fKioskMode (1 bit): A bit that specifies whether the slide show is presented in a way optimized to run at a kiosk. If fKioskMode is
        /// TRUE, fBrowseMode MUST be FALSE.
        self.fKioskMode = flags.readBit()
        
        /// G - fWillSkipNarration (1 bit): A bit that specifies whether to play slide audio narrations during a slide show.
        self.fWillSkipNarration = flags.readBit()
        
        /// H - fLoopContinuously (1 bit): A bit that specifies whether to restart the slide show at the beginning after advancing from the last slide.
        self.fLoopContinuously = flags.readBit()
        
        /// I - fHideScrollBar (1 bit): A bit that specifies whether to display the navigational scroll bar during a slide show.
        self.fHideScrollBar = flags.readBit()
        
        /// reserved (7 bits): MUST be zero and MUST be ignored.
        self.reserved = UInt8(flags.readRemainingBits())
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
