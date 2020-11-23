//
//  OfficeArtSolverContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.18 OfficeArtSolverContainer
/// Referenced by: OfficeArtDgContainer
/// The OfficeArtSolverContainer record specifies a container for the rules that are applicable to the shapes contained in an OfficeArtDgContainer record,
/// as defined in section 2.2.13.
public struct OfficeArtSolverContainer {
    public let rh: OfficeArtRecordHeader
    public let rgfb: [OfficeArtSolverContainerFileBlock]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1 that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0xF.
        /// rh.recInstance An unsigned integer that specifies the number of contained OfficeArtSolverContainerFileBlock records, as defined in section 2.2.19.
        /// rh.recType A value that MUST be 0xF005.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header that contain OfficeArtSolverContainerFileBlock records,
        /// as defined in section 2.2.19. This value MUST be the size, in bytes, of rgfb.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF005 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgfb (variable): An array of OfficeArtSolverContainerFileBlock records, as defined in section 2.2.19, specifying a collection of rules that are
        /// applicable to the shapes contained in an OfficeArtDgContainer record, as defined in section 2.2.13.
        var rgfb: [OfficeArtSolverContainerFileBlock] = []
        rgfb.reserveCapacity(Int(self.rh.recInstance))
        for _ in 0..<self.rh.recInstance {
            rgfb.append(try OfficeArtSolverContainerFileBlock(dataStream: &dataStream))
        }
        
        self.rgfb = rgfb
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
