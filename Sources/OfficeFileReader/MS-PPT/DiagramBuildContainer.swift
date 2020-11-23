//
//  DiagramBuildContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.13 DiagramBuildContainer
/// Referenced by: BuildListSubContainer
/// A container record that specifies the build information for a diagram.
public struct DiagramBuildContainer {
    public let rh: RecordHeader
    public let buildAtom: BuildAtom
    public let diagramBuildAtom: DiagramBuildAtom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_DiagramBuild.
        /// rh.recLen MUST be 0x00000024.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .diagramBuild else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000024 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// buildAtom (24 bytes): A BuildAtom record that specifies the information for the build.
        self.buildAtom = try BuildAtom(dataStream: &dataStream)
        
        /// diagramBuildAtom (12 bytes): A DiagramBuildAtom record that specifies the information for the diagram build.
        self.diagramBuildAtom = try DiagramBuildAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
