//
//  TBC.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.309 TBC
/// The TBC structure specifies a toolbar control
public struct TBC {
    public let tbch: TBCHeader
    public let cid: Cid?
    public let tbcd: TBCData?
    
    public init(dataStream: inout DataStream) throws {
        /// tbch (variable): A structure of type TBCHeader, as specified in [MS-OSHARED], that contains toolbar control information.
        let tbch = try TBCHeader(dataStream: &dataStream)
        self.tbch = tbch
        
        /// cid (4 bytes): A structure of type Cid that specifies the command identifier for this toolbar control. This MUST only exist if tbch.tcid is
        /// not equal to 0x0001 and is not equal to 0x1051. Toolbar controls MUST have only Cid structures whose Cmt values are equal to 0x0001
        /// or 0x0003.
        if tbch.tcid != 0x0001 && tbch.tcid != 0x1051 {
            let cid = try Cid(dataStream: &dataStream)
            if cid.cmt != .fci && cid.cmt != .allocated {
                throw OfficeFileError.corrupted
            }
            
            self.cid = cid
        } else {
            self.cid = nil
        }
        
        /// tbcd (variable): A structure of type TBCData, as specified in [MS-OSHARED], that contains toolbar control data. This MUST exist if
        /// tbch.tct is not equal to 0x16. This MUST NOT exist if tbch.tct is equal to 0x016.
        if self.tbch.tcid == 0x016 {
            self.tbcd = try TBCData(dataStream: &dataStream, header: self.tbch)
        } else {
            self.tbcd = nil
        }
    }
}
