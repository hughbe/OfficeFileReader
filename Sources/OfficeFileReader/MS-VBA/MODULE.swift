//
//  MODULE.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.3.2 MODULE Record
/// Specifies data for a module. Source code for the module can be found in the ModuleStream (section 2.3.4.3) named as specified in
/// StreamNameRecord. Every MODULE (section 2.3.4.2.3.2) MUST have a corresponding <ProjectModule> specified in PROJECT Stream
/// (section 2.3.1).
public struct MODULE {
    public let nameRecord: MODULENAME
    public let nameUnicodeRecord: MODULENAMEUNICODE?
    public let streamNameRecord: MODULESTREAMNAME
    public let docStringRecord: MODULEDOCSTRING
    public let offsetRecord: MODULEOFFSET
    public let helpContextRecord: MODULEHELPCONTEXT
    public let cookieRecord: MODULECOOKIE
    public let typeRecord: MODULETYPE
    public let readOnlyRecord: MODULEREADONLY?
    public let privateRecord: MODULEPRIVATE?
    public let terminator: UInt16
    public let reserved: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// NameRecord (variable): A MODULENAME Record (section 2.3.4.2.3.2.1).
        self.nameRecord = try MODULENAME(dataStream: &dataStream)
        
        /// NameUnicodeRecord (variable): A MODULENAMEUNICODE Record (section 2.3.4.2.3.2.2). This field is optional.
        if try dataStream.peek(endianess: .littleEndian) as UInt16 == 0x0047 {
            self.nameUnicodeRecord = try MODULENAMEUNICODE(dataStream: &dataStream)
        } else {
            self.nameUnicodeRecord = nil
        }
        
        /// StreamNameRecord (variable): A MODULESTREAMNAME Record (section 2.3.4.2.3.2.3).
        self.streamNameRecord = try MODULESTREAMNAME(dataStream: &dataStream)
        
        /// DocStringRecord (variable): A MODULEDOCSTRING Record (section 2.3.4.2.3.2.4).
        self.docStringRecord = try MODULEDOCSTRING(dataStream: &dataStream)
        
        /// OffsetRecord (10 bytes): A MODULEOFFSET Record (section 2.3.4.2.3.2.5).
        self.offsetRecord = try MODULEOFFSET(dataStream: &dataStream)
        
        /// HelpContextRecord (10 bytes): A MODULEHELPCONTEXT Record (section 2.3.4.2.3.2.6).
        self.helpContextRecord = try MODULEHELPCONTEXT(dataStream: &dataStream)
        
        /// CookieRecord (8 bytes): A MODULECOOKIE Record (section 2.3.4.2.3.2.7).
        self.cookieRecord = try MODULECOOKIE(dataStream: &dataStream)
        
        /// TypeRecord (6 bytes): A MODULETYPE Record (section 2.3.4.2.3.2.8).
        self.typeRecord = try MODULETYPE(dataStream: &dataStream)
        
        /// ReadOnlyRecord (6 bytes): A MODULEREADONLY Record (section 2.3.4.2.3.2.9). This field is optional.
        if try dataStream.peek(endianess: .littleEndian) as UInt16 == 0x0025 {
            self.readOnlyRecord = try MODULEREADONLY(dataStream: &dataStream)
        } else {
            self.readOnlyRecord = nil
        }
        
        /// PrivateRecord (6 bytes): A MODULEPRIVATE Record (section 2.3.4.2.3.2.10). This field is optional.
        if try dataStream.peek(endianess: .littleEndian) as UInt16 == 0x0028 {
            self.privateRecord = try MODULEPRIVATE(dataStream: &dataStream)
        } else {
            self.privateRecord = nil
        }

        
        /// Terminator (2 bytes): An unsigned integer that specifies the end of this record. MUST be 0x002B.
        self.terminator = try dataStream.read(endianess: .littleEndian)
        guard self.terminator == 0x002B else {
            throw OfficeFileError.corrupted
        }
        
        /// Reserved (4 bytes): MUST be 0x00000000. MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
