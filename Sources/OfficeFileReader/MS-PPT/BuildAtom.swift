//
//  BuildAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.7 BuildAtom
/// Referenced by: ChartBuildContainer, DiagramBuildContainer, ParaBuildContainer
/// An atom record that specifies the build information for a chart, diagram or text.
public struct BuildAtom {
    public let rh: RecordHeader
    public let buildType: BuildTypeEnum
    public let buildId: UInt32
    public let shapeIdRef: UInt32
    public let fExpanded: bool1
    public let fUIExpanded: bool1
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_BuildAtom.
        /// rh.recLen MUST be 0x00000010.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .buildAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// buildType (4 bytes): A BuildTypeEnum enumeration that specifies the build type.
        guard let buildType = BuildTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.buildType = buildType
        
        /// buildId (4 bytes): An unsigned integer that specifies the build identifier. The combination of buildId and shapeIdRef MUST be unique for
        /// all builds in the slide.
        self.buildId = try dataStream.read(endianess: .littleEndian)
        
        /// shapeIdRef (4 bytes): An unsigned integer that specifies the target shape that this build is applied to.
        self.shapeIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// fExpanded (1 byte): A bool1 (section 2.2.2) that specifies whether this build has been expanded into time nodes.
        self.fExpanded = try bool1(dataStream: &dataStream)
        
        /// fUIExpanded (1 byte): A bool1 that specifies whether this build is shown as expanded in the user interface.
        self.fUIExpanded = try bool1(dataStream: &dataStream)
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
