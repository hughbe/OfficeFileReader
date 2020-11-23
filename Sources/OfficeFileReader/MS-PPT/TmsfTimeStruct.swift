//
//  TmsfTimeStruct.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.12.10 TmsfTimeStruct
/// Referenced by: ExCDAudioAtom
/// A structure that specifies CD (compact disc) audio time in terms of tracks, minutes, seconds, and frames.
public struct TmsfTimeStruct {
    public let track: UInt8
    public let minute: UInt8
    public let second: UInt8
    public let frame: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// track (1 byte): An unsigned integer that specifies the track number. It MUST be greater than 0x00 and less than or equal to 0x64.
        let track: UInt8 = try dataStream.read(endianess: .littleEndian)
        guard track > 0 && track <= 0x64 else {
            throw OfficeFileError.corrupted
        }
        
        self.track = track
        
        /// minute (1 byte): An unsigned integer that specifies the number of minutes. It MUST be less than or equal to 0x3C.
        self.minute = try dataStream.read(endianess: .littleEndian)
        guard self.minute <= 0x3C else {
            throw OfficeFileError.corrupted
        }
        
        /// second (1 byte): An unsigned integer that specifies the number of seconds. It MUST be less than 0x3C.
        self.second = try dataStream.read(endianess: .littleEndian)
        guard self.second <= 0x3C else {
            throw OfficeFileError.corrupted
        }
        
        /// frame (1 byte): An unsigned integer that specifies the frame number. It MUST be less than 0x4A.
        self.frame = try dataStream.read(endianess: .littleEndian)
        guard self.frame <= 0x4A else {
            throw OfficeFileError.corrupted
        }
    }
}
