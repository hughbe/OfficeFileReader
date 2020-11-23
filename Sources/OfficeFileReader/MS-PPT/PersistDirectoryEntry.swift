//
//  PersistDirectoryEntry.swift
//  
//
//  Created by Hugh Bellamy on 23/11/2020.
//

import DataStream

/// [MS-PPT] 2.3.5 PersistDirectoryEntry
/// Referenced by: PersistDirectoryAtom
/// A structure that specifies a compressed table of sequential persist object identifiers and stream offsets to associated persist objects.
/// Let the corresponding user edit be specified by the UserEditAtom record (section 2.3.3) that most closely follows the PersistDirectoryAtom record
/// (section 2.3.4) that contains this structure.
/// Let the corresponding persist object directory be specified by the PersistDirectoryAtom record that contains this structure.
public struct PersistDirectoryEntry {
    public let persistId: UInt32
    public let cPersist: UInt16
    public let rgPersistOffset: [PersistOffsetEntry]
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// persistId (20 bits): An unsigned integer that specifies a starting persist object identifier. It MUST be less than or equal to 0xFFFFE. The first
        /// entry in rgPersistOffset is associated with persistId. The next entry, if present, is associated with persistId plus 1. Each entry in
        /// rgPersistOffset is associated with a persist object identifier in this manner, with the final entry associated with persistId + cPersist – 1.
        self.persistId = flags.readBits(count: 20)
        guard self.persistId <= 0xFFFFE else {
            throw OfficeFileError.corrupted
        }
        
        /// cPersist (12 bits): An unsigned integer that specifies the count of items in rgPersistOffset. It MUST be greater than or equal to 0x001.
        self.cPersist = UInt16(flags.readBits(count: 12))
        guard self.cPersist >= 0x001 else {
            throw OfficeFileError.corrupted
        }
        
        /// rgPersistOffset (variable): An array of PersistOffsetEntry (section 2.3.6) that specifies stream offsets to persist objects. The count of items
        /// in the array is specified by cPersist. The value of each item MUST be greater than or equal to offsetLastEdit in the corresponding user
        /// edit and MUST be less than the offset, in bytes, of the corresponding persist object directory.
        var rgPersistOffset: [PersistOffsetEntry] = []
        rgPersistOffset.reserveCapacity(Int(self.cPersist))
        for _ in 0..<self.cPersist {
            rgPersistOffset.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.rgPersistOffset = rgPersistOffset
    }
}
