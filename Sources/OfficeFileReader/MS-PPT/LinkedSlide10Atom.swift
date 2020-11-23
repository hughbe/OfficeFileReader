//
//  LinkedSlide10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.32 LinkedSlide10Atom
/// Referenced by: PP10SlideBinaryTagExtension
/// An atom record that specifies a reference to a presentation slide and a count of LinkedShape10Atom records.
/// Let the corresponding main document be specified by the document that contains both the corresponding linked document and the corresponding
/// reviewer document.
/// Let the corresponding linked document be specified as follows:
///  Let the corresponding main master slide be specified by the MainMasterContainer record (section 2.5.3) that is specified by the first
/// MasterPersistAtom record (section 2.4.14.2) in the MasterListWithTextContainer record (section 2.4.14.1) in the corresponding main document.
///  Let the corresponding shape be specified by the OfficeArtSpContainer record ([MS-ODRAW] section 2.2.14) such that the wzName_complex
/// property ([MS-ODRAW] section 2.3.4.2) matches the string "Linked". The corresponding shape is contained by the drawing field of the
/// corresponding main master slide.
///  Let the corresponding OLE object be specified by the ExOleEmbedContainer record (section 2.10.27 ) whose exOleObjAtom.exObjId field matches
/// the exObjIdRef field of the ExObjRefAtom record that is contained within the corresponding shape. Let the corresponding linked document be the
/// corresponding OLE object so specified.
/// Let the corresponding reviewer document be specified as follows:
///  Let the corresponding main master slide be specified by the MainMasterContainer record that is specified by the first MasterPersistAtom record
/// (section 2.4.14.2) in the MasterListWithTextContainer record (section 2.4.14.1) in the corresponding main document.
///  Let the corresponding shape be specified by the OfficeArtSpContainer record ([MS-ODRAW] section 2.2.14) such that the wzName_complex
/// property ([MS-ODRAW] section 2.3.4.2) matches the string "Reviewer". The corresponding shape is contained by the drawing field of the
/// corresponding main master slide.
///  Let the corresponding OLE object be specified by the ExOleEmbedContainer record whose exOleObjAtom.exObjId field matches the exObjIdRef
/// field of the ExObjRefAtom record that is contained within the corresponding shape. Let the corresponding reviewer document be the corresponding
/// OLE object so specified.
/// Let the corresponding base document be specified as follows:
///  Let the corresponding main master slide be specified by the MainMasterContainer record that is specified by the first MasterPersistAtom record
/// (section 2.4.14.2) in the MasterListWithTextContainer record (section 2.4.14.1) in the corresponding reviewer document.
///  Let the corresponding shape be specified by the OfficeArtSpContainer record ([MS-ODRAW] section 2.2.14) such that the wzName_complex
/// property ([MS-ODRAW] section 2.3.4.2) matches the string "Base". The corresponding shape is contained by the drawing field of the corresponding
/// main master slide.
///  Let the corresponding OLE object be specified by the ExOleEmbedContainer record whose exOleObjAtom.exObjId field matches the exObjIdRef
/// field of the ExObjRefAtom record that is contained within the corresponding shape. Let the corresponding base document be the corresponding
/// OLE object so specified.
/// If this LinkedSlide10Atom record is contained within the corresponding main document, let the associated document be specified by the corresponding
/// linked document; or if this LinkedSlide10Atom record is contained within the corresponding reviewer document, let the associated document be
/// specified by the corresponding main document; or if this LinkedSlide10Atom record is contained within the corresponding base document, let the
/// associated document be specified by the corresponding linked document.
public struct LinkedSlide10Atom {
    public let rh: RecordHeader
    public let linkedSlideIdRef: SlideIdRef
    public let cLinkedShapes: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_LinkedSlide10Atom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .linkedSlide10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// linkedSlideIdRef (4 bytes): A SlideIdRef (section 2.2.25) that specifies a reference to a presentation slide in the associated document.
        self.linkedSlideIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// cLinkedShapes (4 bytes): A signed integer that specifies the count of LinkedShape10Atom records in the rgLinkedShape10Atom field of
        /// the PP10SlideBinaryTagExtension record that contains this LinkedSlide10Atom record.
        self.cLinkedShapes = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
