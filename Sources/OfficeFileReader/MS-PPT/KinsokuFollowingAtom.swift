//
//  KinsokuFollowingAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.5 KinsokuFollowingAtom
/// Referenced by: Kinsoku9Container, KinsokuContainer
/// An atom record that specifies a list of characters that cannot appear immediately before a line break of East Asian text.
public struct KinsokuFollowingAtom {
    public let rh: RecordHeader
    public let kinsokuFollowing: String
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be an even number
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (self.rh.recLen % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// kinsokuFollowing (variable): An array of UTF-16 Unicode [RFC2781] characters that specifies the list of characters.
        self.kinsokuFollowing = try dataStream.readString(count: Int(self.rh.recLen), encoding: .utf16LittleEndian)!
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
