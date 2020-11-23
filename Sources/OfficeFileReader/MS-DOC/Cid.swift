//
//  Cid.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.34 Cid
/// The Cid structure is a command identifier—a 4-byte structure that specifies a command. This element is used in other structures to identify a
/// particular command to be executed. The 3 least significant bits of the first byte of the structure together form a Cmt value which specifies
/// the command type; the whole structure MUST be interpreted according to this command type, as follows.
public enum Cid {
    case fci(data: CidFci)
    case macro(data: CidMacro)
    case allocated(data: CidAllocated)
    case `nil`
    
    public var cmt: Cmt {
        switch self {
        case .fci(_):
            return .fci
        case .macro(_):
            return .macro
        case .allocated(_):
            return .allocated
        case .nil:
            return .nil
        }
    }
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.peekBits(endianess: .littleEndian)
        
        /// cmt (3 bits): A Cmt value that specifies the command type.
        let cmtRaw = UInt8(flags.readBits(count: 3))
        guard let cmt = Cmt(rawValue: cmtRaw) else {
            throw OfficeFileError.corrupted
        }
        
        switch cmt {
        case .fci:
            self = .fci(data: try CidFci(dataStream: &dataStream))
        case .macro:
            self = .macro(data: try CidMacro(dataStream: &dataStream))
        case .allocated:
            self = .allocated(data: try CidAllocated(dataStream: &dataStream))
        case .nil:
            let rawValue: UInt32 = try dataStream.read(endianess: .littleEndian)
            if rawValue != 0xFFFFFFFF {
                throw OfficeFileError.corrupted
            }

            self = .nil
        }
    }
}
