//
//  ExHyperlinkFlagsAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.24 ExHyperlinkFlagsAtom
/// Referenced by: ExHyperlink9Container
/// An atom record that specifies additional information about a hyperlink.
public struct ExHyperlinkFlagsAtom {
    public let rh: RecordHeader
    public let fInsertHyperlinkDialog: Bool
    public let fLocationIsNamedShow: Bool
    public let fNamedShowReturnToSlide: Bool
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalHyperlinkFlagsAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalHyperlinkFlagsAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fInsertHyperlinkDialog (1 bit): A bit that specifies whether this hyperlink was created in the Insert Hyperlink dialog box.
        self.fInsertHyperlinkDialog = flags.readBit()
        
        /// B - fLocationIsNamedShow (1 bit): A bit that specifies whether the location of this hyperlink is a named show.
        self.fLocationIsNamedShow = flags.readBit()
        
        /// C - fNamedShowReturnToSlide (1 bit): A bit that specifies whether this hyperlink to a named show was set to return to the slide.
        self.fNamedShowReturnToSlide = flags.readBit()
        
        /// reserved (29 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
