//
//  ChartBuildContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.11 ChartBuildContainer
/// Referenced by: BuildListSubContainer
/// A container record that specifies the build information for a chart.
public struct ChartBuildContainer {
    public let rh: RecordHeader
    public let buildAtom: BuildAtom
    public let chartBuildAtom: ChartBuildAtom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ChartBuild.
        /// rh.recLen MUST be 0x00000028.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .chartBuild else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000028 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// buildAtom (24 bytes): A BuildAtom record that specifies the information for the build.
        self.buildAtom = try BuildAtom(dataStream: &dataStream)
        
        /// chartBuildAtom (16 bytes): A ChartBuildAtom record that specifies the information for the chart build.
        self.chartBuildAtom = try ChartBuildAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
