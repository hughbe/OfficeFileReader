//
//  PP10SlideBinaryTagExtension.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.24 PP10SlideBinaryTagExtension
/// Referenced by: SlideProgBinaryTagSubContainerOrAtom
/// A pair of atom records that specifies a programmable tag with additional slide data.
public struct PP10SlideBinaryTagExtension {
    public let rh: RecordHeader
    public let tagName: PrintableUnicodeString
    public let rhData: RecordHeader
    public let rgTextMasterStyleAtom: [TextMasterStyle10Atom]
    public let rgComment10Container: [Comment10Container]
    public let linkedSlideAtom: LinkedSlide10Atom?
    public let rgLinkedShape10Atom: [LinkedShape10Atom]
    public let slideFlagsAtom: SlideFlags10Atom?
    public let slideTimeAtom: SlideTime10Atom?
    public let hashCodeAtom: HashCode10Atom?
    public let extTimeNodeContainer: ExtTimeNodeContainer?
    public let buildListContainer: BuildListContainer?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_CString (section 2.13.24).
        /// rh.recLen MUST be 0x00000010.
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
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition1 = dataStream.position

        /// tagName (16 bytes): A PrintableUnicodeString (section 2.2.23) that specifies the programmable tag name. It MUST be "___PPT10".
        self.tagName = try PrintableUnicodeString(dataStream: &dataStream, byteCount: 16)
        if self.tagName != "___PPT10" {
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
            self.rgTextMasterStyleAtom = []
            self.rgComment10Container = []
            self.linkedSlideAtom = nil
            self.rgLinkedShape10Atom = []
            self.slideFlagsAtom = nil
            self.slideTimeAtom = nil
            self.hashCodeAtom = nil
            self.extTimeNodeContainer = nil
            self.buildListContainer = nil
            return
        }
        
        /// rgTextMasterStyleAtom (variable): An array of TextMasterStyle10Atom records that specifies additional character-level and paragraph-level
        /// formatting of master slides. The array continues while rh.recType of the TextMasterStyle10Atom item is equal to RT_TextMasterStyle10Atom.
        var rgTextMasterStyleAtom: [TextMasterStyle10Atom] = []
        while dataStream.position - startPosition2 < self.rhData.recLen {
            guard try dataStream.peekRecordHeader().recType == .textMasterStyle10Atom else {
                break
            }
            
            rgTextMasterStyleAtom.append(try TextMasterStyle10Atom(dataStream: &dataStream))
        }
        
        self.rgTextMasterStyleAtom = rgTextMasterStyleAtom
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.rgComment10Container = []
            self.linkedSlideAtom = nil
            self.rgLinkedShape10Atom = []
            self.slideFlagsAtom = nil
            self.slideTimeAtom = nil
            self.hashCodeAtom = nil
            self.extTimeNodeContainer = nil
            self.buildListContainer = nil
            return
        }
        
        /// rgComment10Container (variable): An array of Comment10Container records that specifies presentation comments. The array continues
        /// while rh.recType of the Comment10Container item is equal to RT_Comment10.
        var rgComment10Container: [Comment10Container] = []
        while dataStream.position - startPosition2 < self.rhData.recLen {
            guard try dataStream.peekRecordHeader().recType == .comment10 else {
                break
            }
            
            rgComment10Container.append(try Comment10Container(dataStream: &dataStream))
        }
        
        self.rgComment10Container = rgComment10Container
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.linkedSlideAtom = nil
            self.rgLinkedShape10Atom = []
            self.slideFlagsAtom = nil
            self.slideTimeAtom = nil
            self.hashCodeAtom = nil
            self.extTimeNodeContainer = nil
            self.buildListContainer = nil
            return
        }
        
        /// linkedSlideAtom (16 bytes): An optional LinkedSlide10Atom record that specifies a link to a slide used to display the changes to the slide
        /// made by a reviewer. It SHOULD<84> be ignored and SHOULD<85> be omitted.
        if try dataStream.peekRecordHeader().recType == .linkedSlide10Atom {
            self.linkedSlideAtom = try LinkedSlide10Atom(dataStream: &dataStream)
        } else {
            self.linkedSlideAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.rgLinkedShape10Atom = []
            self.slideFlagsAtom = nil
            self.slideTimeAtom = nil
            self.hashCodeAtom = nil
            self.extTimeNodeContainer = nil
            self.buildListContainer = nil
            return
        }
        
        /// rgLinkedShape10Atom (variable): An optional array of LinkedShape10Atom records. The count of items in the array is specified by
        /// linkedSlideAtom.cLinkedShapes. The array specifies links to shapes used to display the changes of the slide made by a reviewer.
        /// It SHOULD<86> be ignored and SHOULD<87> be omitted.
        var rgLinkedShape10Atom: [LinkedShape10Atom] = []
        while dataStream.position - startPosition2 < self.rhData.recLen {
            guard try dataStream.peekRecordHeader().recType == .linkedShape10Atom else {
                break
            }
            
            rgLinkedShape10Atom.append(try LinkedShape10Atom(dataStream: &dataStream))
        }
        
        self.rgLinkedShape10Atom = rgLinkedShape10Atom
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.slideFlagsAtom = nil
            self.slideTimeAtom = nil
            self.hashCodeAtom = nil
            self.extTimeNodeContainer = nil
            self.buildListContainer = nil
            return
        }
        
        /// slideFlagsAtom (12 bytes): An optional SlideFlags10Atom record that specifies slide-level flags.
        if try dataStream.peekRecordHeader().recType == .slideFlags10Atom {
            self.slideFlagsAtom = try SlideFlags10Atom(dataStream: &dataStream)
        } else {
            self.slideFlagsAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.slideTimeAtom = nil
            self.hashCodeAtom = nil
            self.extTimeNodeContainer = nil
            self.buildListContainer = nil
            return
        }
        
        /// slideTimeAtom (16 bytes): An optional SlideTime10Atom record that specifies the slide creation timestamp.
        if try dataStream.peekRecordHeader().recType == .slideTime10Atom {
            self.slideTimeAtom = try SlideTime10Atom(dataStream: &dataStream)
        } else {
            self.slideTimeAtom = nil
        }
        
        try dataStream.skipUnknownRecords(startPosition: startPosition2, length: Int(self.rhData.recLen))
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.hashCodeAtom = nil
            self.extTimeNodeContainer = nil
            self.buildListContainer = nil
            return
        }
        
        /// hashCodeAtom (12 bytes): An optional HashCode10Atom record that specifies a hash code for the animations on the slide.
        if try dataStream.peekRecordHeader().recType == .hashCodeAtom {
            self.hashCodeAtom = try HashCode10Atom(dataStream: &dataStream)
        } else {
            self.hashCodeAtom = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.extTimeNodeContainer = nil
            self.buildListContainer = nil
            return
        }
        
        /// extTimeNodeContainer (variable): An optional ExtTimeNodeContainer record (section 2.8.15) that specifies slide animation timing data.
        if try dataStream.peekRecordHeader().recType == .timeExtTimeNodeContainer {
            self.extTimeNodeContainer = try ExtTimeNodeContainer(dataStream: &dataStream)
        } else {
            self.extTimeNodeContainer = nil
        }
        
        if dataStream.position - startPosition2 == self.rhData.recLen {
            self.buildListContainer = nil
            return
        }
        
        /// buildListContainer (variable): An optional BuildListContainer record that specifies slide animation build data.
        if try dataStream.peekRecordHeader().recType == .buildList {
            self.buildListContainer = try BuildListContainer(dataStream: &dataStream)
        } else {
            self.buildListContainer = nil
        }
        
        guard dataStream.position - startPosition2 == self.rhData.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
