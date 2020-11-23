//
//  TLP.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.326 TLP
/// The TLP structure specifies the table style options for the current table.
public struct TLP {
    public let itl: Int16
    public let grfatl: Fatl
    
    public init(dataStream: inout DataStream) throws {
        /// itl (2 bytes): A signed integer that MAY<264> specify the index of a predefined table auto-format. Formats applied through auto-formatting
        /// are distributed to all of the affected rows and cells, and can be changed independently of this value. As such, the value that is found here
        /// does not specify any formatting for the table as it exists now. The purpose of this data is to aid in the re-application of the auto-format in
        /// the future.
        /// The list of auto-formats is application specific. The special values for itl are as follows.
        /// Name Value Meaning
        /// itlNil -1 No predefined table auto-format was applied to this table row.
        /// itlNone 0 A predefined table auto-format where all border, shading, font, and best fit formats are the defaults.
        self.itl = try dataStream.read(endianess: .littleEndian)
        
        /// grfatl (2 bytes): A bit field of Fatl flags that SHOULD<265> specify which optional formats are in effect from the table style or table
        /// auto-format applied to the table.
        self.grfatl = try Fatl(dataStream: &dataStream)
    }
}
