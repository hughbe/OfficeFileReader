//
//  BuildListSubContainer.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.5 BuildListSubContainer
/// Referenced by: BuildListContainer
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified in the following table.
public enum BuildListSubContainer {
    /// RT_ParaBuild A ParaBuildContainer record that specifies text build information.
    case paraBuild(data: ParaBuildContainer)

    /// RT_ChartBuild A ChartBuildContainer record that specifies chart build information.
    case chartBuild(data: ChartBuildContainer)

    /// RT_DiagramBuild A DiagramBuildContainer record that specifies diagram build information.
    case diagramBuild(data: DiagramBuildContainer)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .paraBuild:
            self = .paraBuild(data: try ParaBuildContainer(dataStream: &dataStream))
        case .chartBuild:
            self = .chartBuild(data: try ChartBuildContainer(dataStream: &dataStream))
        case .diagramBuild:
            self = .diagramBuild(data: try DiagramBuildContainer(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
