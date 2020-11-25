//
//  PersistIdRef.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.21 PersistIdRef
/// Referenced by: DocumentAtom, ExOleObjAtom, MasterPersistAtom, NotesPersistAtom, SlidePersistAtom, UserEditAtom, VBAInfoAtom
/// A 4-byte unsigned integer that specifies a reference to a persist object. It MUST be 0x00000000 or equal to a persist object identifier specified by a
/// PersistDirectoryAtom record (section 2.3.4).
/// The value 0x00000000 specifies a null reference.
public struct PersistIdRef: RawRepresentable, Hashable {
    public let rawValue: UInt32
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    public init(dataStream: inout DataStream) throws {
        self.rawValue = try dataStream.read(endianess: .littleEndian)
    }
    
    public var isNullReference: Bool { return rawValue == 0x00000000 }
}
