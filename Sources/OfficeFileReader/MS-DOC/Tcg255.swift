//
//  Tcg255.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.316 Tcg255
/// The Tcg255 structure contains a sequence of structures that specify command-related customizations. The type of each structure is specified
/// by its first byte with a special value that acts as a terminator.
public struct Tcg255 {
    public let rgtcgData: [Any]
    public let chTerminator: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// rgtcgData (variable): A sequence of structures. Each structure is identified by its first byte, as follows.
        /// 0x01 A PlfMcd structure that specifies macro commands.
        /// 0x02 A PlfAcd structure that specifies allocated commands.
        /// 0x03 A PlfKme structure that contains key map entries (Kme). Each key map entry MUST specify at least a primary key code, and
        /// the entries MUST be unique with regards to the key codes they specify.
        /// 0x04 A PlfKme structure that contains key map entries (Kme). Unlike when the first byte is equal to 3, there are no restrictions on the
        /// Kme.kcm or Kme.kcm2 of each entry. If a keyboard key map entry does not specify at least a primary key code, that entry MUST be
        /// ignored. If two or more entries specify the same key codes, all except the first such entry MUST be ignored.
        /// 0x10 A TcgSttbf structure whose string table contains macro names and allocated command arguments.
        /// 0x11 A MacroNames structure that contains macro names.
        /// 0x12 A CTBWRAPPER structure that specifies toolbar customizations.
        var rgtcgData: [Any] = []
        var chTerminator: UInt8 = 0x40
        whileLabel: while true {
            let byte: UInt8 = try dataStream.read()
            switch byte {
            case 0x01:
                rgtcgData.append(try PlfMcd(dataStream: &dataStream))
            case 0x02:
                rgtcgData.append(try PlfAcd(dataStream: &dataStream))
            case 0x03:
                rgtcgData.append(try PlfKme(dataStream: &dataStream))
            case 0x04:
                rgtcgData.append(try PlfKme(dataStream: &dataStream))
            case 0x10:
                rgtcgData.append(try TcgSttbf(dataStream: &dataStream))
            case 0x11:
                rgtcgData.append(try MacroNames(dataStream: &dataStream))
            case 0x12:
                rgtcgData.append(try CTBWRAPPER(dataStream: &dataStream))
            case 0x40:
                chTerminator = byte
                break whileLabel
            default:
                throw OfficeFileError.corrupted
            }
        }
        
        self.rgtcgData = rgtcgData
        self.chTerminator = chTerminator
    }
}
