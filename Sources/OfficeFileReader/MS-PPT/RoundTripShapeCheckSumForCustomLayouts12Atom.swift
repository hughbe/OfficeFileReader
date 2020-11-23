//
//  RoundTripShapeCheckSumForCustomLayouts12Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.21 RoundTripShapeCheckSumForCustomLayouts12Atom
/// Referenced by: ShapeClientRoundtripDataSubContainerOrAtom
/// An atom record that specifies application-defined IDs for a shape and its text. To be interoperable this record SHOULD<111> be preserved if
/// encountered but SHOULD<112> be omitted otherwise.
public struct RoundTripShapeCheckSumForCustomLayouts12Atom {
    public let rh: RecordHeader
    public let shapeCheckSum: UInt32
    public let textCheckSum: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripShapeCheckSumForCL12Atom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripShapeCheckSumForCL12Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// shapeCheckSum (4 bytes): An unsigned integer that specifies an application-defined identifier for quickly determining whether the shape
        /// properties specified by the OfficeArtSpContainer record ([MS-ODRAW] section 2.2.14) that contains this
        /// RoundTripShapeChecksumForCustomLayouts12Atom have changed since they were last saved.
        self.shapeCheckSum = try dataStream.read(endianess: .littleEndian)
        
        /// textCheckSum (4 bytes): An unsigned integer that specifies an application-defined identifier for quickly determining whether the text body
        /// specified by the OfficeArtClientTextbox record contained within the OfficeArtSpContainer record ([MS-ODRAW] section 2.2.14) that contains
        /// this RoundTripShapeChecksumForCustomLayouts12Atom has changed since it was last saved.
        self.textCheckSum = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
