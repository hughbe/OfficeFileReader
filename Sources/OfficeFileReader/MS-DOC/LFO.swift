//
//  LFO.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.131 LFO
/// The LFO structure specifies the LSTF element that corresponds to a list that contains a paragraph. An LFO can also specify formatting information that
/// overrides the LSTF element to which it corresponds.
public struct LFO {
    public let lsid: Int32
    public let unused1: UInt32
    public let unused2: UInt32
    public let clfolvl: UInt8
    public let ibstFltAutoNum: LFOField
    public let grfhic: grfhic
    public let unused3: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// lsid (4 bytes): A signed integer that specifies the list identifier of an LSTF. This LFO corresponds to the LSTF in PlfLst.rgLstf that has an lsid
        /// whose value is equal to this value.
        self.lsid = try dataStream.read(endianess: .littleEndian)
        
        /// unused1 (4 bytes): This field MUST be ignored.
        self.unused1 = try dataStream.read(endianess: .littleEndian)
        
        /// unused2 (4 bytes): This field MUST be ignored.
        self.unused2 = try dataStream.read(endianess: .littleEndian)
        
        /// clfolvl (1 byte): An unsigned integer that specifies the count of LFOLVL elements that are stored in the rgLfoLvl field of the LFOData element
        /// that corresponds to this LFO structure.
        self.clfolvl = try dataStream.read()
        
        /// ibstFltAutoNum (1 byte): An unsigned integer that specifies the field that this LFO represents. This MUST be one of the following values.
        let ibstFltAutoNumRaw: UInt8 = try dataStream.read(endianess: .littleEndian)
        guard let ibstFltAutoNum = LFOField(rawValue: ibstFltAutoNumRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.ibstFltAutoNum = ibstFltAutoNum
        
        /// grfhic (1 byte): A grfhic that specifies HTML incompatibilities.
        self.grfhic = try OfficeFileReader.grfhic(dataStream: &dataStream)
        
        /// unused3 (1 byte): This field MUST be ignored.
        self.unused3 = try dataStream.read(endianess: .littleEndian)
    }
    
    /// ibstFltAutoNum (1 byte): An unsigned integer that specifies the field that this LFO represents. This MUST be one of the following values.
    public enum LFOField: UInt8 {
        /// 0x00 This LFO is not used for any field. The fAutoNum of the related LSTF MUST be set to 0.
        case notUsedForAnyField1 = 0
        
        /// 0xFC This LFO is used for the AUTONUMLGL field (see AUTONUMLGL in flt). The fAutoNum of the related LSTF MUST be set to 1.
        case autoNumLgl = 0xFC
        
        /// 0xFD This LFO is used for the AUTONUMOUT field (see AUTONUMOUT in flt). The fAutoNum of the related LSTF MUST be set to 1.
        case autoNumOut = 0xFD
        
        /// 0xFE This LFO is used for the AUTONUM field (see AUTONUM in flt). The fAutoNum of the related LSTF MUST be set to 1.
        case autoNum = 0xFE
        
        /// 0xFF This LFO is not used for any field. The fAutoNum of the related LSTF MUST be set to 0.
        case notUsedForAnyField2 = 0xFF
    }
}
