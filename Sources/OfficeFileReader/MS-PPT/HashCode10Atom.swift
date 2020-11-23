//
//  HashCode10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.3 HashCode10Atom
/// Referenced by: PP10SlideBinaryTagExtension
/// An atom record that specifies the hash code for the animation information for a slide.
public struct HashCode10Atom {
    public let rh: RecordHeader
    public let hash: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_HashCodeAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .hashCodeAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// hash (4 bytes): An unsigned integer that specifies a hash value for the animation information of all shapes in a slide. To calculate the hash value,
        /// a random array MUST be initialized first, as
        /// specified in the following pseudocode:
        ///  Define randomArray as an array of 256 rows and 256 columns
        ///  Initialize all elements of randomArray with 0x00000000
        ///  Set randomSeed to 0x00000001
        ///  FOR each row of randomArray
        ///  FOR each column of randomArray
        ///  Set r0 to randomSeed
        ///  Set r1 to ((r0 * 0x000343FD + 0x00269EC3) >> 16) & 0x00007FFF
        ///  Set r2 to ((r1 * 0x000343FD + 0x00269EC3) >> 16) & 0x00007FFF
        ///  Set r3 to ((r2 * 0x000343FD + 0x00269EC3) >> 16) & 0x00007FFF
        ///  Set r4 to ((r3 * 0x000343FD + 0x00269EC3) >> 16) & 0x00007FFF
        ///  Set randomSeed to r4
        ///  Set r1 to (r1 % 0x00000100)
        ///  Set r2 to (r2 % 0x00000100) << 8
        ///  Set r3 to (r3 % 0x00000100) << 16
        ///  Set r4 to (r4 % 0x00000100) << 24
        ///  Set randomArray position (row, column) to r4 | r3 | r2 | r1
        ///  END FOR
        ///  END FOR
        /// Then, the random array can be used to calculate hash values for all slides, as specified in the following
        /// pseudocode:
        ///  Set hash to 0x00000000
        ///  FOR each shape in the slide
        ///  Define animInfoAtom as AnimationInfoAtom
        ///  Initialize all bytes of animInfoAtom with zero
        ///  IF AnimationInfoAtom exists in the shape THEN
        ///  Read the animation information into animInfoAtom
        ///  END IF
        ///  Set shapeId to identifier of the shape
        ///  FOR each byte in animInfoAtom
        ///  Set byteIndex to the index of the byte in animInfoAtom
        ///  Set rowIndex to (shapeId * (byteIndex + 1)) % 256
        ///  Set hash to hash ^ randomArray[rowIndex][byte]
        ///  END FOR
        ///  END FOR
        self.hash = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
