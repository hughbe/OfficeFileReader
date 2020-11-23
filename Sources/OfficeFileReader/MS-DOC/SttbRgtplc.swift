//
//  SttbRgtplc.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.294 SttbRgtplc
/// The SttbRgtplc structure is an STTB structure in which each string specifies the bullet/numbering formats for a hybrid bulleted/numbered multi-level list.
/// Because such a list can have a maximum of 9 levels, each string, if not empty, is in fact an array of 9 32-bit Tplc elements. The first element in each array
/// specifies the format of the outermost level in the hybrid list.
/// SttbRgtplc is used parallel to PlfLst to specify the list formatting details. The index of each string inside SttbRgtplc corresponds to the LSTF of the same
/// index inside PlfLst, with each Tplc mapped to the corresponding LVL inside the LSTF.
/// If the fHybrid member of the LSTF corresponding to a string in SttbRgtplc is 1, then that string in SttbRgtplc is not used and thus can be empty. In that
/// case, the cchData of that string in the following table can be zero.
/// There is no extra data appended to the strings of this STTB.
public struct SttbRgtplc {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbRgtplc structure is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cData (2 bytes): This value MUST NOT exceed 0x7FF0.
        /// cbExtra (2 bytes): This value MUST be 0.
        /// cchData (2 bytes): This value MUST be either 0x0 or 0x12.
        /// Data (0 or 36 bytes): An array that contains 9 Tplc elements. This does not exist if cchData is 0x0.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cData > 0x7FF0 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cchData.contains(where: { $0 != 0x0 && $0 != 0x12 }) {
            throw OfficeFileError.corrupted
        }
    }
}
