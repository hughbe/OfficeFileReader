//
//  OutlineTextPropsHeaderExAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.62 OutlineTextPropsHeaderExAtom
/// Referenced by: OutlineTextProps10Entry, OutlineTextProps11Entry, OutlineTextProps9Entry
/// An atom record that specifies a reference to text contained in the SlideListWithTextContainer record (section 2.4.14.3).
/// Let the corresponding slide persist be specified by the SlidePersistAtom record (section 2.4.14.5) contained in the SlideListWithTextContainer record
/// whose slideId field is equal to slideIdRef.
/// Let the corresponding text be specified by the TextHeaderAtom record referenced by rh.recInstance.
public struct OutlineTextPropsHeaderExAtom {
    public let rh: RecordHeader
    public let slideIdRef: SlideIdRef
    public let txType: TextTypeEnum
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance Specifies a zero-based index into the sequence of TextHeaderAtom records that follows the corresponding slide persist.
        /// It MUST be greater than or equal to 0x000 and less than the number of TextHeaderAtom records that follow the
        /// corresponding slide persist. It MUST be less than or equal to 0x005.
        /// rh.recType MUST be RT_OutlineTextPropsHeader9Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance <= 0x005 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .outlineTextPropsHeader9Atom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// slideIdRef (4 bytes): A SlideIdRef (section 2.2.25) that specifies the presentation slide that contains the corresponding text. If this field does
        /// not reference a valid presentation slide, the structure that contains this OutlineTextPropsHeaderExAtom MUST be ignored.
        self.slideIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// txType (4 bytes): A TextTypeEnum enumeration that specifies the type of text of the corresponding text.
        guard let txType = TextTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.txType = txType
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
