//
//  TIQ.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.325 TIQ
/// The TIQ structure specifies information about a structured document tag node, or an attribute on a structured document tag node, in the document.
public struct TIQ {
    public let ixsdr: UInt32
    public let ixstElement: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// ixsdr (4 bytes): An unsigned integer that specifies the STTB which is the namespace of the structured document tag node or attribute
        /// that is represented by the structure containing this TIQ structure. This value MUST be less than 0x7FFFFFFF. This STTB can be found
        /// by using the following algorithm:
        /// 1. The structure that contains this TIQ is contained in an SttbfBkmkSdt which is located at the offset specified by the fcSttbfBkmkSdt
        /// field of a FibRgFcLcb2002 structure.
        /// 2. The fcHpIxsdr field of that FibRgFcLcb2002 structure specifies the location of an Hplxsdr.
        /// 3. ixsdr is the zero-based index of an XSDR within the rgXSDR array of that Hplxsdr.
        /// 4. If this TIQ is a field of an FSDAP structure, the string table that is specified by this ixsdr is the SttbElements field of the XSDR in step
        /// 3. If this TIQ is a field of an SDTI structure, the string table is the SttbAttributes field.
        self.ixsdr = try dataStream.read(endianess: .littleEndian)
        
        /// ixstElement (4 bytes): An integer that specifies a zero-based index into the STTB namespace that is denoted by ixsdr. The string that is
        /// found at offset ixstElement is the name of the structured document tag node or attribute associated with the structure containing this TIQ.
        self.ixstElement = try dataStream.read(endianess: .littleEndian)
    }
}
