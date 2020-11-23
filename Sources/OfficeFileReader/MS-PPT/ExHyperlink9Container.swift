//
//  ExHyperlink9Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.21 ExHyperlink9Container
/// Referenced by: PP9DocBinaryTagExtension
/// A container record that specifies additional information about a hyperlink.
public struct ExHyperlink9Container {
    public let rh: RecordHeader
    public let exHyperlinkRefAtom: ExHyperlinkRefAtom
    public let screenTipAtom: ScreenTipAtom?
    public let exHyperlinkFlagsAtom: ExHyperlinkFlagsAtom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalHyperlink9.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalHyperlink9 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exHyperlinkRefAtom (12 bytes): An ExHyperlinkRefAtom record that specifies a reference to the corresponding hyperlink.
        self.exHyperlinkRefAtom = try ExHyperlinkRefAtom(dataStream: &dataStream)
        
        /// screenTipAtom (variable): An optional ScreenTipAtom record that specifies the screen tip of the corresponding hyperlink.
        if try dataStream.peekRecordHeader().recType == .cString {
            self.screenTipAtom = try ScreenTipAtom(dataStream: &dataStream)
        } else {
            self.screenTipAtom = nil
        }
        
        /// exHyperlinkFlagsAtom (12 bytes): An ExHyperlinkFlagsAtom record that specifies additional information about the corresponding hyperlink.
        self.exHyperlinkFlagsAtom = try ExHyperlinkFlagsAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
