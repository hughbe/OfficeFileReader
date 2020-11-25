//
//  PersistObjectDirectory.swift
//  
//
//  Created by Hugh Bellamy on 24/11/2020.
//

import DataStream

public struct PersistObjectDirectory {
    private var dictionary: [PersistIdRef: PersistOffsetEntry]
    internal var userEditAtom: UserEditAtom
    
    public init(dataStream: inout DataStream) throws {
        var stack: [PersistDirectoryAtom] = []
        var userEditAtom: UserEditAtom
        repeat {
            /// 3. Read the UserEditAtom record at the current offset. Let this record be a live record.
            userEditAtom = try UserEditAtom(dataStream: &dataStream)
            
            /// 4. Seek to the offset specified by the offsetPersistDirectory field of the UserEditAtom record identified in step 3.
            guard userEditAtom.offsetPersistDirectory <= dataStream.count else {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position = Int(userEditAtom.offsetPersistDirectory)
            
            /// 5. Read the PersistDirectoryAtom record at the current offset. Let this record be a live record.
            let persistDirectoryAtom = try PersistDirectoryAtom(dataStream: &dataStream)
            stack.append(persistDirectoryAtom)
            
            /// 6. Seek to the offset specified by the offsetLastEdit field in the UserEditAtom record identified in step 3.
            guard userEditAtom.offsetLastEdit <= dataStream.count else {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position = Int(userEditAtom.offsetLastEdit)
            
            /// 7. Repeat steps 3 through 6 until offsetLastEdit is 0x00000000.
        } while userEditAtom.offsetLastEdit != 0x00000000
        
        /// 8. Construct the complete persist object directory for this file as follows:
        /// 1. For each PersistDirectoryAtom record previously identified in step 5, add the persist object identifier and persist object stream offset
        /// pairs to the persist object directory starting with the PersistDirectoryAtom record last identified, that is, the one closest to the
        /// beginning of the stream.
        /// 2. Continue adding these pairs to the persist object directory for each PersistDirectoryAtom record in the reverse order that they were
        /// identified in step 5; that is, the pairs from the PersistDirectoryAtom record closest to the end of the stream are added last.
        /// 3. When adding a new pair to the persist object directory, if the persist object identifier already exists in the persist object directory, the
        /// persist object stream offset from the new pair replaces the existing persist object stream offset for that persist object identifier.
        var dictionary: [PersistIdRef: PersistOffsetEntry] = [:]
        while stack.count > 0 {
            let atom = stack.removeLast()
            for entry in atom.rgPersistDirEntry {
                for (i, offset) in entry.rgPersistOffset.enumerated() {
                    let persistId = PersistIdRef(rawValue: entry.persistId + UInt32(i))
                    dictionary[persistId] = offset
                }
            }
        }
        
        self.userEditAtom = userEditAtom
        self.dictionary = dictionary
    }
    
    public func seek(dataStream: inout DataStream, to persistId: PersistIdRef) throws {
        guard let position = dictionary[persistId] else {
            throw OfficeFileError.corrupted
        }
        guard position <= dataStream.count else {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = Int(position)
    }
}
