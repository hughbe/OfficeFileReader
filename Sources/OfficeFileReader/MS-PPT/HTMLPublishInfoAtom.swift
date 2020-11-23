//
//  HTMLPublishInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.18.5 HTMLPublishInfoAtom
/// Referenced by: HTMLPublishInfo9Container
/// An atom record that specifies the settings to publish the document to a Web page.
public struct HTMLPublishInfoAtom {
    public let rh: RecordHeader
    public let startSlide: Int32
    public let endSlide: Int32
    public let outputType: WebOutputEnum
    public let fUseSlideRangeX: Bool
    public let fUseNamedShowX: Bool
    public let fLoadInBrowserX: Bool
    public let fShowSpeakerNote: Bool
    public let reserved: UInt8
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_HTMLPublishInfoAtom (section 2.13.24).
        /// rh.recLen MUST be 0x0000000C.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .htmlPublishInfoAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000000C else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        
        /// startSlide (4 bytes): A signed integer that specifies the first slide in the range of slides to publish. It MUST be greater than or equal to zero.
        self.startSlide = try dataStream.read(endianess: .littleEndian)
        guard self.startSlide >= 0 else {
            throw OfficeFileError.corrupted
        }
        
        /// endSlide (4 bytes): A signed integer that specifies the last slide in the range of slides to publish. It MUST be greater than or equal to zero.
        self.endSlide = try dataStream.read(endianess: .littleEndian)
        guard self.endSlide >= 0 else {
            throw OfficeFileError.corrupted
        }
        
        /// outputType (1 byte): A WebOutputEnum enumeration that specifies the Web browser support that this publication ought to be optimized for.
        guard let outputType = WebOutputEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.outputType = outputType
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fUseSlideRangeX (1 bit): A bit that specifies whether to publish the range of slides defined by startSlide and endSlide.
        self.fUseSlideRangeX = flags.readBit()
        
        /// B - fUseNamedShowX (1 bit): A bit that specifies whether to publish the slides defined by the namedShowAtom field of the
        /// HTMLPublishInfo9Container record that contains this HTMLPublishInfoAtom record.
        self.fUseNamedShowX = flags.readBit()
        
        /// C - fLoadInBrowserX (1 bit): A bit that specifies whether to automatically display the Web page in the Web browser.
        self.fLoadInBrowserX = flags.readBit()
        
        /// D - fShowSpeakerNote (1 bit): A bit that specifies whether to display the notes pane when viewing the Web page in a Web browser.
        self.fShowSpeakerNote = flags.readBit()
        
        /// E - reserved (4 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
