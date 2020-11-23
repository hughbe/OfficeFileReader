//
//  DateTimeStruct.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-PPT] 2.12.4 DateTimeStruct
/// Referenced by: BroadcastDocInfoAtom, Comment10Atom, SlideSyncInfoAtom12
/// A structure that specifies the date and time.
public struct DateTimeStruct {
    public let datetime: SYSTEMTIME
    
    public init(dataStream: inout DataStream) throws {
        /// datetime (16 bytes): A SYSTEMTIME structure, as specified in [MS-DTYP] section 2.3.13, that specifies the date and time.
        self.datetime = try SYSTEMTIME(dataStream: &dataStream)
    }
}
