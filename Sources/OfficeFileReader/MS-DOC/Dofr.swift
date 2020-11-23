//
//  Dofr.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.55 Dofr
/// The Dofr structure is a type that wraps a different data type for each type of record specified by Dofrh.dofrt. When Dofrh.dofrt specifies dofrtFs,
/// this type is not applicable, and MUST be left out.
/// dofrtFsn Contains a DofrFsn.
/// dofrtFsnp Contains a DofrFsnp.
/// dofrtFsnName Contains a DofrFsnName.
/// dofrtFsnFnm Contains a DofrFsnFnm.
/// dofrtFsnSpbd Contains a DofrFsnSpbd.
/// dofrtRglstsf Contains a DofrRglstsf.
public enum Dofr {
    case fs
    case fsn(data: DofrFsn)
    case fsnp(data: DofrFsnp)
    case fsnName(data: DofrFsnName)
    case fsnFnm(data: DofrFsnFnm)
    case fsnSpbd(data: DofrFsnSpbd)
    case rglstsf(data: DofrRglstsf)
    
    public init(dataStream: inout DataStream, dofrt: Dofrt) throws {
        switch dofrt {
        case .fs:
            self = .fs
        case .fsn:
            self = .fsn(data: try DofrFsn(dataStream: &dataStream))
        case .fsnp:
            self = .fsnp(data: try DofrFsnp(dataStream: &dataStream))
        case .fsnName:
            self = .fsnName(data: try DofrFsnName(dataStream: &dataStream))
        case .fsnFnm:
            self = .fsnFnm(data: try DofrFsnFnm(dataStream: &dataStream))
        case .fsnSpbd:
            self = .fsnSpbd(data: try DofrFsnSpbd(dataStream: &dataStream))
        case .rglstsf:
            self = .rglstsf(data: try DofrRglstsf(dataStream: &dataStream))
        }
    }
}
