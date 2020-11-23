//
//  PP9DocBinaryTagExtension.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.23.5 PP9DocBinaryTagExtension
/// Referenced by: DocProgBinaryTagSubContainerOrAtom
/// A pair of atom records that specifies a programmable tag with additional document data.
public struct PP9DocBinaryTagExtension {
    public let rh: RecordHeader
    public let tagName: PrintableUnicodeString
    public let rhData: RecordHeader
    public let rgTextMasterStyle9: [TextMasterStyle9Atom]
    public let blipCollectionContainer: BlipCollection9Container?
    public let textDefaultsAtom: TextDefaults9Atom?
    public let kinsokuContainer: Kinsoku9Container?
    public let rgExternalHyperlink9: [ExHyperlink9Container]
    public let presAdvisorFlagsAtom: PresAdvisorFlags9Atom?
    public let envelopeDataAtom: EnvelopeData9Atom?
    public let envelopeFlagsAtom: EnvelopeFlags9Atom?
    public let htmlDocInfoAtom: HTMLDocInfo9Atom?
    public let htmlPublishInfoAtom: HTMLPublishInfo9Container?
    public let rgBroadcastDocInfo9: [BroadcastDocInfo9Container]
    public let outlineTextPropsContainer: OutlineTextProps9Container?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_CString (section 2.13.24).
        /// rh.recLen MUST be 0x0000000E.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000000E else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition1 = dataStream.position

        /// tagName (14 bytes): A PrintableUnicodeString (section 2.2.23) that specifies the programmable tag name. It MUST be "___PPT9".
        self.tagName = try PrintableUnicodeString(dataStream: &dataStream, byteCount: 14)
        if self.tagName != "___PPT9" {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition1 == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
        
        /// rhData (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for the second record. Sub-fields are further specified in
        /// the following table:
        /// Field Meaning
        /// rhData.recVer MUST be 0x0.
        /// rhData.recInstance MUST be 0x000.
        /// rhData.recType MUST be RT_BinaryTagDataBlob.
        self.rhData = try RecordHeader(dataStream: &dataStream)
        guard self.rhData.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rhData.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rhData.recType == .binaryTagDataBlob else {
            throw OfficeFileError.corrupted
        }

        let startPosition2 = dataStream.position
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.rgTextMasterStyle9 = []
            self.blipCollectionContainer = nil
            self.textDefaultsAtom = nil
            self.kinsokuContainer = nil
            self.rgExternalHyperlink9 = []
            self.presAdvisorFlagsAtom = nil
            self.envelopeDataAtom = nil
            self.envelopeFlagsAtom = nil
            self.htmlDocInfoAtom = nil
            self.htmlPublishInfoAtom = nil
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// rgTextMasterStyle9 (variable): An array of TextMasterStyle9Atom records that specifies additional character-level and paragraph-level
        /// formatting of main master slides. The array continues while rh.recType of the TextMasterStyle9Atom is equal to RT_TextMasterStyle9Atom.
        var rgTextMasterStyle9: [TextMasterStyle9Atom] = []
        while dataStream.position - startPosition2 < self.rhData.recLen {
            guard try dataStream.peekRecordHeader().recType == .textMasterStyle9Atom else {
                break
            }
            
            rgTextMasterStyle9.append(try TextMasterStyle9Atom(dataStream: &dataStream))
        }
        
        self.rgTextMasterStyle9 = rgTextMasterStyle9
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.blipCollectionContainer = nil
            self.textDefaultsAtom = nil
            self.kinsokuContainer = nil
            self.rgExternalHyperlink9 = []
            self.presAdvisorFlagsAtom = nil
            self.envelopeDataAtom = nil
            self.envelopeFlagsAtom = nil
            self.htmlDocInfoAtom = nil
            self.htmlPublishInfoAtom = nil
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// blipCollectionContainer (variable): An optional BlipCollection9Container record (section 2.9.72) that specifies information about picture
        /// bullet points.
        if try dataStream.peekRecordHeader().recType == .blipCollection9 {
            self.blipCollectionContainer = try BlipCollection9Container(dataStream: &dataStream)
        } else {
            self.blipCollectionContainer = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.textDefaultsAtom = nil
            self.kinsokuContainer = nil
            self.rgExternalHyperlink9 = []
            self.presAdvisorFlagsAtom = nil
            self.envelopeDataAtom = nil
            self.envelopeFlagsAtom = nil
            self.htmlDocInfoAtom = nil
            self.htmlPublishInfoAtom = nil
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// textDefaultsAtom (variable): An optional TextDefaults9Atom record that specifies additional default character-level and paragraph-level
        /// formatting.
        if try dataStream.peekRecordHeader().recType == .textDefaults9Atom {
            self.textDefaultsAtom = try TextDefaults9Atom(dataStream: &dataStream)
        } else {
            self.textDefaultsAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.kinsokuContainer = nil
            self.rgExternalHyperlink9 = []
            self.presAdvisorFlagsAtom = nil
            self.envelopeDataAtom = nil
            self.envelopeFlagsAtom = nil
            self.htmlDocInfoAtom = nil
            self.htmlPublishInfoAtom = nil
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// kinsokuContainer (variable): An optional Kinsoku9Container (section 2.9.6) that specifies the user preferences for East Asian text
        /// line break settings.
        if try dataStream.peekRecordHeader().recType == .kinsoku {
            self.kinsokuContainer = try Kinsoku9Container(dataStream: &dataStream)
        } else {
            self.kinsokuContainer = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.rgExternalHyperlink9 = []
            self.presAdvisorFlagsAtom = nil
            self.envelopeDataAtom = nil
            self.envelopeFlagsAtom = nil
            self.htmlDocInfoAtom = nil
            self.htmlPublishInfoAtom = nil
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// rgExternalHyperlink9 (variable): An array of ExHyperlink9Container records that specifies additional information about hyperlinks.
        /// The array continues while rh.recType of the ExHyperlink9Container record is equal to RT_ExternalHyperlink9.
        var rgExternalHyperlink9: [ExHyperlink9Container] = []
        while dataStream.position - startPosition2 < self.rhData.recLen {
            guard try dataStream.peekRecordHeader().recType == .externalHyperlink9 else {
                break
            }
            
            rgExternalHyperlink9.append(try ExHyperlink9Container(dataStream: &dataStream))
        }
        
        self.rgExternalHyperlink9 = rgExternalHyperlink9
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.presAdvisorFlagsAtom = nil
            self.envelopeDataAtom = nil
            self.envelopeFlagsAtom = nil
            self.htmlDocInfoAtom = nil
            self.htmlPublishInfoAtom = nil
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
    
        /// presAdvisorFlagsAtom (12 bytes): An optional PresAdvisorFlags9Atom record that specifies Presentation Assistant settings. It SHOULD<20>
        /// be ignored.
        if try dataStream.peekRecordHeader().recType == .presentationAdvisorFlags9Atom {
            self.presAdvisorFlagsAtom = try PresAdvisorFlags9Atom(dataStream: &dataStream)
        } else {
            self.presAdvisorFlagsAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.envelopeDataAtom = nil
            self.envelopeFlagsAtom = nil
            self.htmlDocInfoAtom = nil
            self.htmlPublishInfoAtom = nil
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// envelopeDataAtom (variable): An optional EnvelopeData9Atom record that specifies data for an envelope. It SHOULD<21> be ignored.
        if try dataStream.peekRecordHeader().recType == .envelopeData9Atom {
            self.envelopeDataAtom = try EnvelopeData9Atom(dataStream: &dataStream)
        } else {
            self.envelopeDataAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.envelopeFlagsAtom = nil
            self.htmlDocInfoAtom = nil
            self.htmlPublishInfoAtom = nil
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// envelopeFlagsAtom (12 bytes): An optional EnvelopeFlags9Atom record that specifies information about an envelope. It SHOULD<22>
        /// be ignored.
        if try dataStream.peekRecordHeader().recType == .envelopeFlags9Atom {
            self.envelopeFlagsAtom = try EnvelopeFlags9Atom(dataStream: &dataStream)
        } else {
            self.envelopeFlagsAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.htmlDocInfoAtom = nil
            self.htmlPublishInfoAtom = nil
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// htmlDocInfoAtom (24 bytes): An optional HTMLDocInfo9Atom record that specifies settings how to publish a document as a Web page.
        if try dataStream.peekRecordHeader().recType == .htmlDocInfo9Atom {
            self.htmlDocInfoAtom = try HTMLDocInfo9Atom(dataStream: &dataStream)
        } else {
            self.htmlDocInfoAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.htmlPublishInfoAtom = nil
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// htmlPublishInfoAtom (variable): An optional HTMLPublishInfo9Container record that contains additional information specifying how to
        /// publish a document as a Web page.
        if try dataStream.peekRecordHeader().recType == .htmlPublishInfo9 {
            self.htmlPublishInfoAtom = try HTMLPublishInfo9Container(dataStream: &dataStream)
        } else {
            self.htmlPublishInfoAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.rgBroadcastDocInfo9 = []
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// rgBroadcastDocInfo9 (variable): An array of BroadcastDocInfo9Container records that specifies settings for a presentation broadcast.
        /// The array continues while rh.recType of the BroadcastDocInfo9Container is equal to RT_BroadcastDocInfo9. It SHOULD<23> be ignored.
        var rgBroadcastDocInfo9: [BroadcastDocInfo9Container] = []
        while dataStream.position - startPosition2 < self.rhData.recLen {
            guard try dataStream.peekRecordHeader().recType == .broadcastDocInfo9 else {
                break
            }
             
            rgBroadcastDocInfo9.append(try BroadcastDocInfo9Container(dataStream: &dataStream))
        }
        
        self.rgBroadcastDocInfo9 = rgBroadcastDocInfo9
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.outlineTextPropsContainer = nil
            return
        }
        
        /// outlineTextPropsContainer (variable): An optional OutlineTextProps9Container record that specifies additional text properties for outline text.
        if try dataStream.peekRecordHeader().recType == .outlineTextProps9 {
            self.outlineTextPropsContainer = try OutlineTextProps9Container(dataStream: &dataStream)
        } else {
            self.outlineTextPropsContainer = nil
        }
        
        guard dataStream.position - startPosition2 == self.rhData.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
