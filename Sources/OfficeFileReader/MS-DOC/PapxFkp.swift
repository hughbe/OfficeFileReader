//
//  PapxFkp.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.174 PapxFkp
/// The PapxFkp structure maps paragraphs, table rows, and table cells to their properties. A PapxFkp structure is 512 bytes in size, with cpara
/// in the last byte. The elements of rgbx specify the locations of PapxInFkp structures that start at offsets between the end of rgbx and cpara
/// within this PapxFkp structure.
public struct PapxFkp {
    public let rgfc: [UInt32]
    public let rgbx: [BxPap]
    public let cpara: UInt8
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        let cparaPosition = startPosition + 511
        if cparaPosition > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = cparaPosition
        
        /// cpara (1 byte): An unsigned integer that specifies the total number of paragraphs, table rows, or table cells for which this PapxFkp
        /// structure specifies formatting. This field occupies the last byte of the PapxFkp structure The value of this field MUST be at least 0x01,
        /// and MUST NOT exceed 0x1D because that would cause rgfc and rgb to expand and PapxFkp to exceed 512 bytes.
        let cpara: UInt8 = try dataStream.read()
        if cpara < 0x01 || cpara > 0x1D {
            throw OfficeFileError.corrupted
        }
        
        self.cpara = cpara
        dataStream.position = startPosition
        
        /// rgfc (variable): An array of 4-byte unsigned integers. Each element of this array specifies an offset in the WordDocument Stream
        /// where a paragraph of text begins, or where an end of row mark exists. This array MUST be sorted in ascending order and MUST
        /// NOT contain duplicates. Each paragraph begins immediately after the end of the previous paragraph. The count of elements that
        /// this array contains is cpara incremented by 1. The last element does not specify the beginning of a paragraph; instead it specifies
        /// the end of the last paragraph.
        var rgfc: [UInt32] = []
        rgfc.reserveCapacity(Int(self.cpara + 1))
        for _ in 0..<self.cpara + 1 {
            rgfc.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.rgfc = rgfc
        
        /// rgbx (variable): An array of BxPap, followed by PapxInFkp structures. The elements of this array, which has cpara elements and
        /// parallels rgfc, each specify the offset of one of the PapxInFkp structures in this PapxFkp structure.
        /// Each PapxInFkp specifies the paragraph properties for the paragraph at the corresponding offset in rgfc or the table properties
        /// for the table row whose end of row mark is located at the corresponding offset in rgfc.
        var rgbx: [BxPap] = []
        rgbx.reserveCapacity(Int(self.cpara))
        for _ in 0..<self.cpara {
            rgbx.append(try BxPap(dataStream: &dataStream))
        }
        
        self.rgbx = rgbx
    }
}
