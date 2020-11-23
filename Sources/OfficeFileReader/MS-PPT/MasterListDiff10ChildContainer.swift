//
//  MasterListDiff10ChildContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.14 MasterListDiff10ChildContainer
/// Referenced by: MasterListDiffContainer
/// A variable type record whose type and meaning are dictated by the value of rhs.gmiTag as specified in the following table.
public enum MasterListDiff10ChildContainer {
    case slideDiff(data: SlideDiffContainer)
    case mainMasterDiff(data: MainMasterDiffContainer)

    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rhs = try DiffRecordHeaders(dataStream: &dataStream)
        dataStream.position = position
        
        switch rhs.gmiTag {
        case .slideDiff:
            self = .slideDiff(data: try SlideDiffContainer(dataStream: &dataStream))
        case .mainMasterDiff:
            self = .mainMasterDiff(data: try MainMasterDiffContainer(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
