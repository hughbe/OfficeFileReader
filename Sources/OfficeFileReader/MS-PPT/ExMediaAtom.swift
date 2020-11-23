//
//  ExMediaAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.6 ExMediaAtom
/// Referenced by: ExCDAudioContainer, ExMIDIAudioContainer, ExVideoContainer, ExWAVAudioEmbeddedContainer, ExWAVAudioLinkContainer
/// An atom record that specifies information about external audio or video data.
public struct ExMediaAtom {
    public let rh: RecordHeader
    public let exObjId: ExObjId
    public let fLoop: Bool
    public let fRewind: Bool
    public let fNarration: Bool
    public let reserved: UInt16
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalMediaAtom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalMediaAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// exObjId (4 bytes): An ExObjId (section 2.2.7) that specifies the identifier for the audio or video data.
        self.exObjId = try ExObjId(dataStream: &dataStream)
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fLoop (1 bit): A bit that specifies whether the audio or video data is repeated continuously during playback.
        self.fLoop = flags.readBit()
        
        /// B - fRewind (1 bit): A bit that specifies whether the audio or video data is rewound after playing.
        self.fRewind = flags.readBit()
        
        /// C - fNarration (1 bit): A bit that specifies whether the audio data is recorded narration for the slide show. It MUST be FALSE if this
        /// ExMediaAtom record is contained by an ExVideoContainer record.
        self.fNarration = flags.readBit()
        
        /// reserved (13 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
