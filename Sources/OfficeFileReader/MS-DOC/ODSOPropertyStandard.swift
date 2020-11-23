//
//  ODSOPropertyStandard.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.164 ODSOPropertyStandard
/// The ODSOPropertyStandard structure contains an ODSO property that is less than 0xFFFF bytes in size. See descriptions of the ODSO
/// property types under ODSOPropertyBase.id.
public struct ODSOPropertyStandard {
    public let odsoPropStd: [UInt8]
    
    public init(dataStream: inout DataStream, size: UInt16) throws {
        self.odsoPropStd = try dataStream.readBytes(count: Int(size))
    }
}
