//
//  Dop2013.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.10 Dop2013
/// The Dop2013 structure contains document and compatibility settings. These settings influence the appearance and behavior of the current document
/// and store document-level state.
public struct Dop2013 {
    public let dop2010: Dop2010
    public let fChartTrackingRefBased: Bool
    public let empty: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// dop2010 (690 bytes): A Dop2010 structure (section 2.7.9) that specifies document and compatibility settings.
        self.dop2010 = try Dop2010(dataStream: &dataStream)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fChartTrackingRefBased (1 bit): Specifies how the data point properties and data labels in all charts in this document behave, as specified
        /// in [MS-DOCX] section 2.5.1.2 (chartTrackingRefBased).
        self.fChartTrackingRefBased = flags.readBit()
        
        /// empty (31 bits): This value MUST be 0 and MUST be ignored.
        self.empty = flags.readRemainingBits()
    }
}
