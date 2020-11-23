//
//  LinkedShape10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.33 LinkedShape10Atom
/// Referenced by: PP10SlideBinaryTagExtension
/// An atom record that specifies a shape in a presentation slide that contains this LinkedShape10Atom record and its associated shape from the
/// associated presentation slide that is contained within the associated document.
/// Let the corresponding slide be specified by the SlideContainer record (section 2.5.1) that contains this LinkedShape10Atom record.
/// Let the associated document be as specified by the LinkedSlide10Atom record contained within the PP10SlideBinaryTagExtension record pair that
/// contains this LinkedShape10Atom record.
/// Let the associated presentation slide contained within the associated document be specified by the linkedSlideIdRef field of the LinkedSlide10Atom
/// record in the PP10SlideBinaryTagExtension record pair that contains this LinkedShape10Atom record.
/// Let the associated shape contained within the associated presentation slide be specified by the linkedShapeIdRef field of this LinedShape10Atom.
public struct LinkedShape10Atom {
    public let rh: RecordHeader
    public let shapeIdRef: UInt32
    public let linkedShapeIdRef: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_LinkedShape10Atom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .linkedShape10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// shapeIdRef (4 bytes): An unsigned integer that specifies a reference to the OfficeArtSpContainer ([MS-ODRAW] section 2.2.14) contained
        /// within the corresponding slide such that the shapeProp.spid field matches the value of this field.
        self.shapeIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// linkedShapeIdRef (4 bytes): An unsigned integer that specifies a reference to the OfficeArtSpContainer ([MS-ODRAW] section 2.2.14)
        /// contained within the associated presentation slide such that the shapeProp.spid field matches the value of this field.
        self.linkedShapeIdRef = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
