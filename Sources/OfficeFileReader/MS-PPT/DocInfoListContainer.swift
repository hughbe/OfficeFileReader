//
//  DocInfoListContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.4 DocInfoListContainer
/// Referenced by: DocumentContainer
/// A container record that specifies information about the document and document display settings.
public struct DocInfoListContainer {
    public let rh: RecordHeader
    public let rgChildRec: [DocInfoListSubContainerOrAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_List.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .list else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgChildRec (variable): An array of DocInfoListSubContainerOrAtom records (section 2.4.5) that specifies information about the document
        /// or how the document is displayed. The size, in bytes, of the array is specified by rh.recLen. The rh.recType of the
        /// DocInfoListSubcontainerOrAtom items MUST be one of the following record types: RT_ProgTags (section 2.13.24),
        /// RT_NormalViewSetInfo9 (section 2.13.24), RT_NotesTextViewInfo9 (section 2.13.24), RT_OutlineViewInfo (section 2.13.24),
        /// RT_SlideViewInfo (section 2.13.24), RT_SorterViewInfo (section 2.13.24), or RT_VbaInfo (section 2.13.24). Each record type MUST NOT
        /// occur more than once, except for the RT_SlideViewInfo record type, which MUST NOT occur more than twice. If the RT_SlideViewInfo
        /// record type occurs twice, one occurrence MUST refer to a SlideViewInfoContainer record (section 2.4.21.9) and the other occurrence
        /// MUST refer to a NotesViewInfoContainer record (section 2.4.21.12).
        var rgChildRec: [DocInfoListSubContainerOrAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgChildRec.append(try DocInfoListSubContainerOrAtom(dataStream: &dataStream))
        }
        self.rgChildRec = rgChildRec
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
