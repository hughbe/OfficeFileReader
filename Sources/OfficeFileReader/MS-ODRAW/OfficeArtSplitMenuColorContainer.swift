//
//  OfficeArtSplitMenuColorContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.45 OfficeArtSplitMenuColorContainer
/// Referenced by: OfficeArtDggContainer
/// The OfficeArtSplitMenuColorContainer record specifies a container for the colors that were most recently used to format shapes.
public struct OfficeArtSplitMenuColorContainer {
    public let rh: OfficeArtRecordHeader
    public let smca: [MSOCR]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1 that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x0.
        /// rh.recInstance A value that MUST be 0x004.
        /// rh.recType A value that MUST be 0xF11E.
        /// rh.recLen A value that MUST be 0x00000010.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x004 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF11E else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// smca (variable): An array of MSOCR records, as defined in section 2.2.44, that specifies the colors that were most recently used to format shapes.
        /// The number of elements in the array MUST be four. The elements specify, in order, the fill color, the line color, the shadow color, and the 3-D color.
        var smca: [MSOCR] = []
        smca.reserveCapacity(Int(self.rh.recInstance))
        for _ in 0..<self.rh.recInstance {
            smca.append(try MSOCR(dataStream: &dataStream))
        }
        
        self.smca = smca
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
