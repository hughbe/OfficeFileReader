//
//  OutlineTextRefAtom.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.78 OutlineTextRefAtom
/// Referenced by: TextClientDataSubContainerOrAtom
/// An atom record that specifies a reference to text contained in the SlideListWithTextContainer record (section 2.4.14.3). Let the corresponding slide
/// persist be specified by the SlidePersistAtom record (section 2.4.14.5) contained in the SlideListWithTextContainer record whose persistIdRef
/// field refers to the SlideContainer record (section 2.5.1) that contains this OutlineTextRefAtom record.
public struct OutlineTextRefAtom {
    public let rh: RecordHeader
    public let index: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_OutlineTextRefAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .outlineTextRefAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// index (4 bytes): A signed integer that specifies a zero-based index into the sequence of TextHeaderAtom records that follows the
        /// corresponding slide persist. It MUST be greater than or equal to 0x00000000 and less than the number of TextHeaderAtom records
        /// that follow the corresponding slide persist.
        self.index = try dataStream.read(endianess: .littleEndian)
        if self.index < 0 {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
