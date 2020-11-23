//
//  GrLPUpxSw.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC]  2.9.113 GrLPUpxSw
/// The GrLPUpxSw structure is an array of variable-size structures that specify the formatting of the style.
/// The content of the GrLPUpxSw structure depends on the type of the style (the stk member of StdfBase); see the following.
/// Value Meaning
/// stkPara stk value 1; the GrLPUpxSw contains a StkParaGRLPUPX.
/// stkChar stk value 2; the GrLPUpxSw contains a StkCharGRLPUPX.
/// stkTable stk value 3; the GrLPUpxSw contains a StkTableGRLPUPX.
/// stkList stk value 4; the GrLPUpxSw contains a StkListGRLPUPX.
public enum GrLPUpxSw {
    case para(data: StkParaGRLPUPX)
    case char(data: StkCharGRLPUPX)
    case table(data: StkTableGRLPUPX)
    case list(data: StkListGRLPUPX)
    
    public init(dataStream: inout DataStream, stdfBase: StdfBase, size: Int) throws {
        switch stdfBase.stk {
        case .paragraph:
            self = .para(data: try StkParaGRLPUPX(dataStream: &dataStream, size: size))
        case .character:
            self = .char(data: try StkCharGRLPUPX(dataStream: &dataStream, size: size))
        case .table:
            self = .table(data: try StkTableGRLPUPX(dataStream: &dataStream, size: size))
        case .numbering:
            self = .list(data: try StkListGRLPUPX(dataStream: &dataStream, size: size))
        }
    }
}
