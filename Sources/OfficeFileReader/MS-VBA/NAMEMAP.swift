//
//  NAMEMAP.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.3.1 NAMEMAP Record
/// Maps a MBCS module name to a Unicode module name.
public struct NAMEMAP {
    public let moduleName: String
    public let moduleNameUnicode: String
    
    public init(dataStream: inout DataStream) throws {
        /// ModuleName (variable): A null-terminated string that specifies a module name. MUST contain MBCS characters encoded using the code
        /// page specified by PROJECTCODEPAGE (section 2.3.4.2.1.4). MUST match a module name specified by MODULENAME (section
        /// 2.3.4.2.3.2.1). The first byte MUST NOT be 0x00.
        self.moduleName = try dataStream.readAsciiString()!
        
        /// ModuleNameUnicode (variable): A null-terminated string that specifies a module name. MUST contain UTF-16 encoded characters. The
        /// first two bytes MUST NOT be 0x0000. MUST contain the UTF-16 encoding of ModuleName.
        self.moduleNameUnicode = try dataStream.readAsciiString()!
    }
}
