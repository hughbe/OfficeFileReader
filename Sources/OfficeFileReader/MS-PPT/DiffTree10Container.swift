//
//  DiffTree10Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.5 DiffTree10Container
/// Referenced by: PP10DocBinaryTagExtension
/// A container record that specifies the name of a reviewer and how to display the changes to the document made by that reviewer.
/// Let the corresponding main master slide be specified by the MainMasterContainer record (section 2.5.3) that is specified by the first MasterPersistAtom
/// record (section 2.4.14.2) in the MasterListWithTextContainer record (section 2.4.14.1).
/// Let the corresponding shape be specified by the OfficeArtSpContainer record ([MS-ODRAW] section 2.2.14) such that the wzName_complex property
/// ([MS-ODRAW] section 2.3.4.2) matches the string "Reviewer". The corresponding shape is contained by the drawing field of the corresponding main
/// master slide.
/// Let the corresponding OLE object be specified by the ExOleEmbedContainer record (section 2.10.27) whose exOleObjAtom.exObjId field matches the
/// exObjIdRef field of the ExObjRefAtom record that is contained by the corresponding shape.
/// Let the corresponding reviewer document be specified by the corresponding OLE object.
public struct DiffTree10Container {
    public let rh: RecordHeader
    public let reviewerNameAtom: ReviewerNameAtom
    public let docDiff: DocDiff10Container
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_DiffTree10.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .diffTree10 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// reviewerNameAtom (variable): A ReviewerNameAtom record that specifies the name of the reviewer who made the changes to the
        /// corresponding reviewer document.
        self.reviewerNameAtom = try ReviewerNameAtom(dataStream: &dataStream)
        
        /// docDiff (variable): A DocDiff10Container record that specifies how to display the changes made by the reviewer to the corresponding reviewer
        /// document.
        self.docDiff = try DocDiff10Container(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
