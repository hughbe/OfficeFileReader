//
//  ChartBuildAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.12 ChartBuildAtom
/// Referenced by: ChartBuildContainer
/// An atom record that specifies the information for a chart build.
public struct ChartBuildAtom {
    public let rh: RecordHeader
    public let chartBuild: ChartBuildEnum
    public let fAnimBackground: bool1
    public let unused: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ChartBuildAtom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .chartBuildAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// chartBuild (4 bytes): A ChartBuildEnum enumeration that specifies the chart build type.
        guard let chartBuild = ChartBuildEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.chartBuild = chartBuild
        
        /// fAnimBackground (1 byte): A bool1 (section 2.2.2) that specifies whether the background of the chart animates separately. If chartBuild is
        /// TLCB_AsOneObject, fAnimBackground MUST be ignored. It MUST be a value from the following table.
        /// Value Meaning
        /// 0x00 Do not animate the background.
        /// 0x01 Animate the background.
        self.fAnimBackground = try bool1(dataStream: &dataStream)
        
        /// unused (3 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.readBytes(count: 3)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
