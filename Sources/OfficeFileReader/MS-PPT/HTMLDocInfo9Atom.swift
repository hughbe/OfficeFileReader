//
//  HTMLDocInfo9Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.18.1 HTMLDocInfo9Atom
/// Referenced by: PP9DocBinaryTagExtension
/// An atom record that specifies settings for how to publish a document as a Web page.
public struct HTMLDocInfo9Atom {
    public let rh: RecordHeader
    public let unused1: UInt32
    public let encoding: UInt16
    public let frameColorType: WebFrameColorsEnum
    public let screenSize: WebScreenSizeEnum
    public let unused2: UInt8
    public let outputType: WebOutputEnum
    public let fShowFrame: Bool
    public let fResizeGraphics: Bool
    public let fOrganizeInFolder: Bool
    public let fUseLongFileNames: Bool
    public let fRelyOnVML: Bool
    public let fAllowPNG: Bool
    public let fShowSlideAnimation: Bool
    public let reserved: Bool
    public let unused3: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_HTMLDocInfo9Atom (section 2.13.24).
        /// rh.recLen MUST be 0x00000010.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .htmlDocInfo9Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        
        /// unused1 (4 bytes): Undefined and MUST be ignored.
        self.unused1 = try dataStream.read(endianess: .littleEndian)
        
        /// encoding (4 bytes): An unsigned integer that specifies the code page for character encoding used by the Web page. See [MSDN-CP] for
        /// a list of possible code pages.
        self.encoding = try dataStream.read(endianess: .littleEndian)
        
        /// frameColorType (2 bytes): A WebFrameColorsEnum enumeration that specifies color options for displaying the text and background for the
        /// Web page notes pane and outline pane.
        guard let frameColorType = WebFrameColorsEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.frameColorType = frameColorType
        
        /// screenSize (1 byte): A WebScreenSizeEnum as specified in [MS-OSHARED] section 2.2.1.4 that specifies the document window size for
        /// the monitor on which the Web page is displayed.
        guard let screenSize = WebScreenSizeEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.screenSize = screenSize
        
        /// unused2 (1 byte): Undefined and MUST be ignored.
        self.unused2 = try dataStream.read()
        
        /// outputType (1 byte): A WebOutputEnum enumeration that specifies the Web browser support that this publication ought to be optimized for.
        guard let outputType = WebOutputEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.outputType = outputType
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fShowFrame (1 bit): A bit that specifies whether to include the notes pane and outline pane representation in the Web page.
        self.fShowFrame = flags.readBit()
        
        /// B - fResizeGraphics (1 bit): A bit that specifies whether the graphics in the Web page are resizable.
        self.fResizeGraphics = flags.readBit()
        
        /// C - fOrganizeInFolder (1 bit): A bit that specifies whether any additional files created to represent Web page content in a Web browser are
        /// stored in a separate folder.
        self.fOrganizeInFolder = flags.readBit()
    
        /// D - fUseLongFileNames (1 bit): A bit that specifies whether a file name longer than eight characters is valid.
        self.fUseLongFileNames = flags.readBit()
        
        /// E - fRelyOnVML (1 bit): A bit that specifies whether the Web page requires Vector Markup Language (VML) to display in a Web browser.
        self.fRelyOnVML = flags.readBit()
        
        /// F - fAllowPNG (1 bit): A bit that specifies whether to save pictures supporting the Web page using Portable Network Graphics (PNG) format.
        self.fAllowPNG = flags.readBit()
        
        /// G - fShowSlideAnimation (1 bit): A bit that specifies whether the Web page contains object animation and slide transition effect information.
        self.fShowSlideAnimation = flags.readBit()
        
        /// H - reserved (1 bit): MUST be zero and MUST be ignored.
        self.reserved = flags.readBit()
        
        /// unused3 (2 bytes): Undefined and MUST be ignored.
        self.unused3 = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
