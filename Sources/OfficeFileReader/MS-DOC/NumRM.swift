//
//  NumRM.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.159 NumRM
/// The NumRM structure is a numbering revision mark that specifies information about a numbering revision for a paragraph.
public struct NumRM {
    public let fNumRM: Bool8
    public let fIgnored: Bool8
    public let ibstNumRM: UInt16
    public let dttmNumRM: DTTM
    public let rgbxchNums: [UInt8]
    public let rgnfc: [MSONFC]
    public let ignored: UInt16
    public let pnbr: [UInt32]
    public let xst: [UInt16]
    
    public init(dataStream: inout DataStream) throws {
        /// fNumRM (1 byte): A Bool8 value that specifies whether the paragraph was already numbered when revision mark tracking was turned on.
        self.fNumRM = try dataStream.read()
        
        /// fIgnored (1 byte): This field MUST be ignored
        self.fIgnored = try dataStream.read()
        
        /// ibstNumRM (2 bytes): An integer that specifies an index for the numbering revision in the revision mark author array that is contained in
        /// the SttbfRMark structure.
        self.ibstNumRM = try dataStream.read(endianess: .littleEndian)
        
        /// dttmNumRM (4 bytes): A DTTM structure that specifies the date and time at which the numbering revision occurred.
        self.dttmNumRM = try DTTM(dataStream: &dataStream)
        
        /// rgbxchNums (9 bytes): An array of BYTE elements. Each unsigned integer in the array specifies an index into xst. The index is the
        /// location of a paragraph number placeholder for the numbering level that corresponds to the index. For example, xst[rgbxchNums[0]]
        /// is the location in xst of the first level placeholder. The text to display at the location depends on the numeric value of the level of the
        /// paragraph, as specified by pnbr[0] and the numbering format at rgnfc[0]. A value of zero specifies that the numbering level at the
        /// corresponding index is not in use.
        self.rgbxchNums = try dataStream.readBytes(count: 9)
        
        /// rgnfc (9 bytes): An array of 8-bit MSONFC elements, as specified in [MS-OSHARED] section 2.2.1.3. Each MSONFC element that is
        /// contained in the array specifies the format of the numeric value for the corresponding level placeholder in xst. For example, for the
        /// second numbering level, the value of rgnfc[1] specifies the format of pnbr[1], which is inserted into xst at the level placeholder
        /// location that is specified by rgbxchNums[1].
        var rgnfc: [MSONFC] = []
        rgnfc.reserveCapacity(9)
        for _ in 0..<9 {
            let rawValue: UInt8 = try dataStream.read()
            guard let nfc = MSONFC(rawValue: rawValue) else {
                throw OfficeFileError.corrupted
            }

            rgnfc.append(nfc)
        }
        
        self.rgnfc = rgnfc
        
        /// ignored (2 bytes): This field MUST be ignored.
        self.ignored = try dataStream.read(endianess: .littleEndian)
        
        /// pnbr (36 bytes): An array of LONG elements. Each unsigned integer in the array specifies the numeric value for the corresponding
        /// level placeholder in xst.
        var pnbr: [UInt32] = []
        pnbr.reserveCapacity(9)
        for _ in 0..<9 {
            pnbr.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.pnbr = pnbr

        /// xst (64 bytes): An array of USHORT elements. A string that specifies the format of the numbering for the paragraph. The first position
        /// in the array is an integer that specifies the length of the format string. The format string begins at the second position and contains
        /// level placeholders for the numbering level text to be inserted. The locations of level placeholders are specified by rgbxchNums. To
        /// create the final display string, the text is specified by rgnfc, and pnbr is inserted at the corresponding location in xst.
        var xst: [UInt16] = []
        xst.reserveCapacity(32)
        for _ in 0..<32 {
            xst.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.xst = xst
    }
}
