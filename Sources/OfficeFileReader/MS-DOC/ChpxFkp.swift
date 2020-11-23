//
//  ChpxFkp.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.33 ChpxFkp
/// The ChpxFkp structure maps text to its character properties. A ChpxFkp structure is 512 bytes in size, with crun in the last byte. The elements
/// of rgb point to Chpxs that start at offsets between crun and the end of rgb.
public struct ChpxFkp {
    public let rgfc: [UInt32]
    public let rgb: ([UInt8], [Chpx])
    public let crun: UInt8
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        let cparaPosition = startPosition + 511
        if cparaPosition > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = cparaPosition
        
        /// crun (1 byte): An unsigned integer that specifies the number of runs of text this ChpxFkp describes. Crun is the last byte of the
        /// ChpxFkp. Crun MUST be at least 0x01, and MUST NOT exceed 0x65, as that would cause rgfc and rgb to grow too large for
        /// the ChpxFkp to be 512 bytes.
        let crun: UInt8 = try dataStream.read()
        if crun < 0x01 || crun > 0x65 {
            throw OfficeFileError.corrupted
        }
        
        self.crun = crun
        dataStream.position = startPosition
        
        /// rgfc (variable): An array of 4-byte unsigned integers. Each element of this array specifies an offset in the WordDocument Stream
        /// where a run of text begins. This array MUST be sorted in ascending order and MUST NOT contain duplicates. Each run ends at
        /// the beginning of the next run. This array contains crun+1 elements, where the last element specifies the end of the last run.
        var rgfc: [UInt32] = []
        rgfc.reserveCapacity(Int(self.crun + 1))
        for _ in 0..<self.crun + 1 {
            rgfc.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.rgfc = rgfc
        
        /// rgb (variable): An array of 1-byte unsigned integers, followed by an array of Chpx structures. The elements of this array, which has
        /// crun elements and parallels rgfc, each specify the offset of one of the Chpxs within this ChpxFkp. The offset is computed by
        /// multiplying the value of the byte by 2.
        /// For each i from 0 to crun, rgb[i]×2 MUST either specify an offset, in bytes, between the end of the array and crun, or be equal
        /// to zero, which specifies that there is no Chpx associated with this element of rgb.
        /// Each Chpx specifies the character properties for the run of text that is indicated by the corresponding element of rgfc.
        var rgb1: [UInt8] = []
        var rgb2: [Chpx] = []
        rgb1.reserveCapacity(Int(self.crun))
        rgb2.reserveCapacity(Int(self.crun))
        for _ in 0..<self.crun {
            rgb1.append(try dataStream.read())
        }
        for _ in 0..<self.crun {
            rgb2.append(try Chpx(dataStream: &dataStream))
        }
        
        self.rgb = (rgb1, rgb2)
    }
}
