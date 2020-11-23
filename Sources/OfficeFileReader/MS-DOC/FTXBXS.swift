//
//  FTXBXS.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

public struct FTXBXS {
    public let ftxbxsunion: FTXBXSUnion
    public let fReusable: UInt16
    public let itxbxsDest: UInt32
    public let lid: UInt32
    public let txidUndo: UInt32
    
    public init(dataStream: inout DataStream, last: Bool) throws {
        /// fReusable (2 bytes): An integer that specifies whether this structure describes an actual textbox or an extra structure that is available for reuse
        /// by the application. fReusable MUST be either zero ("false"), or it MUST have the 0x0001 bit set. When nonzero ("true"), bits other than 0x0001
        /// MUST be ignored.
        /// When fReusable is zero, this FTXBXS structure describes an actual textbox. The bounding CPs in PlcftxbxTxt or PlcfHdrtxbxTxt MUST be
        /// more than one character position apart, except when this is the last FTXBXS structure in the PLC. In that case there is no restriction on the
        /// character range specified by the bounding CPs in PlcftxbxTxt or PlcfHdrtxbxTxt. Text within this CP range MUST be ignored.
        /// When fReusable is nonzero, this FTXBXS structure describes a reusable spare textbox structure. The bounding CPs in PlcftxbxTxt or
        /// PlcfHdrtxbxTxt MUST be one character position apart. When this is the last FTXBXS structure in the PLC, fReusable MUST be ignored and
        /// treated as if it were set to 0x0001 for the purposes of ftxbxsunion and lid.
        let position = dataStream.position
        if dataStream.position + 8 > dataStream.count {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position += 8
        let fReusable: UInt16 = try dataStream.read(endianess: .littleEndian)
        self.fReusable = fReusable
        dataStream.position = position
        
        /// ftxbxsunion (8 bytes): If fReusable is "true", ftxbsunion is an FTXBXSReusable structure. Also, if this is the last FTXBXS structure in the PLC,
        /// ftxbsunion is an FTXBXSReusable structure, regardless of the fReusable flag. Otherwise, ftxbsunion is an FTXBXNonReusable structure.
        if last || fReusable == 0 {
            self.ftxbxsunion = .nonReusable(data: try FTXBXNonReusable(dataStream: &dataStream))
        } else {
            self.ftxbxsunion = .reusable(data: try FTXBXSReusable(dataStream: &dataStream))
        }
        
        /// Skip fReusable (2 bytes)
        dataStream.position += 2
        
        /// itxbxsDest (4 bytes): This field MUST be ignored.
        self.itxbxsDest = try dataStream.read(endianess: .littleEndian)
        
        /// lid (4 bytes): An integer that specifies which shape object the textbox text begins in. When fReusable is "true", lid MUST be zero and MUST
        /// be ignored.
        /// When fReusable is "false", lid MUST match the OfficeArtFSP.spid shape identifier in an OfficeArtSpContainer structure as specified by
        /// [MS-ODRAW] section 2.2.14. Furthermore, the MSOPSText_lTxid property of the OfficeArtSpContainer, as specified in [MS-ODRAW] section
        /// 2.3.21.1, MUST be a 4-byte integer where the high 2 bytes divided by 0x10000 gives the 1-based index of this FTXBXS structure in its PLC,
        /// and where the low 2 bytes are 0x0000.
        self.lid = try dataStream.read(endianess: .littleEndian)
        
        /// txidUndo (4 bytes): This value MUST be zero and MUST be ignored.
        self.txidUndo = try dataStream.read(endianess: .littleEndian)
    }
    
    public enum FTXBXSUnion {
        case reusable(data: FTXBXSReusable)
        case nonReusable(data: FTXBXNonReusable)
    }
}
