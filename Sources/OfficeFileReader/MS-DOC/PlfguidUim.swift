//
//  PlfguidUim.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-DOC] 2.9.198 PlfguidUim
/// The PlfguidUim structure specifies an array of GUIDs which are referenced by the UIM structures of PlcfUim.
public struct PlfguidUim {
    public let iMac: Int32
    public let rrgguidUim: [GUID]
    
    public init(dataStream: inout DataStream) throws {
        /// iMac (4 bytes): An unsigned integer that specifies the number of GUIDs in rgguidUim.
        self.iMac = try dataStream.read(endianess: .littleEndian)
        if self.iMac < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rrgguidUim (variable): An array of 16-byte GUIDs that specify the service category or CLSID of the service providing data referenced
        /// by a UIM structure.
        var rrgguidUim: [GUID] = []
        rrgguidUim.reserveCapacity(Int(self.iMac))
        for _ in 0..<self.iMac {
            rrgguidUim.append(try GUID(dataStream: &dataStream))
        }
        
        self.rrgguidUim = rrgguidUim
    }
}
