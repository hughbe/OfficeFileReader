//
//  SDTI.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.239 SDTI
/// The SDTI structure contains information about a structured document tag bookmark in the document.
public struct SDTI {
    public let dwId: UInt32
    public let tiq: TIQ
    public let sdtt: SDTT
    public let cfsdap: UInt32
    public let cbPlaceholder: UInt32
    public let fsdaparray: [FSDAP]
    public let xszPlaceholder: String
    
    public init(dataStream: inout DataStream) throws {
        /// dwId (4 bytes): An unsigned integer that specifies a unique value which is used to reference the structured document tag bookmark
        /// associated with this SDTI structure. This value MUST be unique for all SDTI structures that are contained in a given SttbfBkmkSdt.
        /// This value MUST NOT be 0.
        self.dwId = try dataStream.read(endianess: .littleEndian)
        
        /// tiq (8 bytes): A TIQ that specifies further information about the structured document tag bookmark that is associated with this SDTI
        /// structure.
        self.tiq = try TIQ(dataStream: &dataStream)
        
        /// sdtt (4 bytes): An SDTT structure that specifies further information about the structured document tag bookmark that is associated
        /// with this SDTI. The SDTT structure MUST NOT be sdttUnknown.
        let sdttRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let sdtt = SDTT(rawValue: sdttRaw) else {
            throw OfficeFileError.corrupted
        }
        guard sdtt != .unknown else {
            throw OfficeFileError.corrupted
        }
        
        self.sdtt = sdtt
        
        /// cfsdap (4 bytes): An unsigned integer value that specifies the number of elements in fsdaparray.
        self.cfsdap = try dataStream.read(endianess: .littleEndian)
        
        /// cbPlaceholder (4 bytes): An unsigned integer that specifies the count of bytes, including the terminating NULL character, in xszPlaceholder.
        self.cbPlaceholder = try dataStream.read(endianess: .littleEndian)
        
        /// fsdaparray (variable): An array of FSDAP structures, each of which specifies further information about the structured document tag
        /// bookmark that is associated with this SDTI structure.
        var fsdaparray: [FSDAP] = []
        fsdaparray.reserveCapacity(Int(self.cfsdap))
        for _ in 0..<self.cfsdap {
            fsdaparray.append(try FSDAP(dataStream: &dataStream))
        }
        
        self.fsdaparray = fsdaparray
        
        /// xszPlaceholder (variable): A null-terminated sequence of Unicode characters that specifies the text to show when the structured
        /// document tag that is denoted by this structured document tag bookmark is empty and XML tag characters themselves are not being
        /// shown.
        self.xszPlaceholder = try dataStream.readString(count: Int(self.cbPlaceholder) - 2, encoding: .utf16LittleEndian)!
        let _: UInt16 = try dataStream.read(endianess: .littleEndian)
    }
}

extension SDTI: STTBData {
    public init(dataStream: inout DataStream, size: UInt16, extend: Bool) throws {
        if !extend {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        try self.init(dataStream: &dataStream)
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
