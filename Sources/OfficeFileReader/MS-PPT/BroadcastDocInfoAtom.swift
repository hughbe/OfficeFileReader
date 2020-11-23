//
//  BroadcastDocInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.17.22 BroadcastDocInfoAtom
/// Referenced by: BroadcastDocInfo9Container
/// An atom record that specifies properties of a presentation broadcast.
/// Let the corresponding presentation broadcast be specified by the BroadcastDocInfo9Container record that contains this BroadcastDocInfoAtom record.
public struct BroadcastDocInfoAtom {
    public let rh: RecordHeader
    public let fSendAudio: Bool
    public let fSendVideo: Bool
    public let fCameraRemote: Bool
    public let fUseNetShow: Bool
    public let fUseOtherServer: Bool
    public let fCanEmail: Bool
    public let fCanChat: Bool
    public let fDoArchive: Bool
    public let fSpeakerNotes: Bool
    public let fQuarterScreen: Bool
    public let fShowTools: Bool
    public let fRecordOnly: Bool
    public let reserved: UInt8
    public let startTime: DateTimeStruct
    public let endTime: DateTimeStruct
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_BroadcastDocInfo9Atom.
        /// rh.recLen MUST be 0x00000022.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .broadcastDocInfo9Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000022 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fSendAudio (1 bit): A bit that specifies whether to include an audio stream.
        self.fSendAudio = flags.readBit()
        
        /// B - fSendVideo (1 bit): A bit that specifies whether to include a video stream.
        self.fSendVideo = flags.readBit()
        
        /// C - fCameraRemote (1 bit): A bit that specifies whether the camera is located on a computer other than the computer giving the
        /// corresponding presentation broadcast.
        self.fCameraRemote = flags.readBit()
        
        /// D - fUseNetShow (1 bit): A bit that specifies whether to use NetShow server technology described in [MSFT-UMWNSNS].
        self.fUseNetShow = flags.readBit()
        
        /// E - fUseOtherServer (1 bit): A bit that specifies whether to use a third-party server for the corresponding presentation broadcast.
        self.fUseOtherServer = flags.readBit()
        
        /// F - fCanEmail (1 bit): A bit that specifies whether an e-mail address is provided to the audience.
        self.fCanEmail = flags.readBit()
        
        /// G - fCanChat (1 bit): A bit that specifies whether a chat URL is provided to the audience.
        self.fCanChat = flags.readBit()
        
        /// H - fDoArchive (1 bit): A bit that specifies whether the corresponding presentation broadcast is archived.
        self.fDoArchive = flags.readBit()
        
        /// I - fSpeakerNotes (1 bit): A bit that specifies whether the audience can see the speaker notes.
        self.fSpeakerNotes = flags.readBit()
        
        /// J - fQuarterScreen (1 bit): A bit that specifies whether the slide show is displayed to the presenter in a resizable window.
        self.fQuarterScreen = flags.readBit()
        
        /// K - fShowTools (1 bit): A bit that specifies whether to show speaker notes to the presenter.
        self.fShowTools = flags.readBit()
        
        /// L - fRecordOnly (1 bit): A bit that specifies whether the corresponding presentation broadcast is for recording only.
        self.fRecordOnly = flags.readBit()
        
        /// M - reserved (4 bits): MUST be zero and MUST be ignored.
        self.reserved = UInt8(flags.readRemainingBits())
        
        /// startTime (16 bytes): A DateTimeStruct structure that specifies the time the corresponding presentation broadcast is scheduled to begin.
        self.startTime = try DateTimeStruct(dataStream: &dataStream)
        
        /// endTime (16 bytes): A DateTimeStruct structure that specifies the time the corresponding presentation broadcast is scheduled to end.
        self.endTime = try DateTimeStruct(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

