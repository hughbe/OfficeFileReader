//
//  BroadcastDocInfo9Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.17.1 BroadcastDocInfo9Container
/// Referenced by: PP9DocBinaryTagExtension
/// A container record that specifies settings for a presentation broadcast. It SHOULD<14> be ignored. Some settings refer to NetShow; see
/// [MSFT-UMWNSNS] for more information.
public struct BroadcastDocInfo9Container {
    public let rh: RecordHeader
    public let bcTitleAtom: BCTitleAtom?
    public let bcDescrAtom: BCDescriptionAtom?
    public let bcSpeakerAtom: BCSpeakerAtom?
    public let bcContactAtom: BCContactAtom?
    public let bcRexServerNameAtom: BCRexServerNameAtom?
    public let bcEmailAddressAtom: BCEmailAddressAtom?
    public let bcEmailNameAtom: BCEmailNameAtom?
    public let bcChatUrlAtom: BCChatUrlAtom?
    public let bcArchiveDirAtom: BCArchiveDirAtom?
    public let bcNSFilesBaseDirAtom: BCNetShowFilesBaseDirAtom?
    public let bcNSFilesDirAtom: BCNetShowFilesDirAtom?
    public let bcNSServerNameAtom: BCNetShowServerNameAtom?
    public let bcPptFilesBaseDirAtom: BCPptFilesBaseDirAtom?
    public let bcPptFilesDirAtom: BCPptFilesDirAtom?
    public let bcPptFilesBaseUrlAtom: BCPptFilesBaseUrlAtom?
    public let bcUserNameAtom: BCUserNameAtom?
    public let bcBroadcastDateTimeAtom: BCBroadcastDateTimeAtom?
    public let bcPresentationNameAtom: BCPresentationNameAtom?
    public let bcAsdFileNameAtom: BCAsdFileNameAtom?
    public let bcEntryIdAtom: BCEntryIDAtom?
    public let bcDocInfoAtom: BroadcastDocInfoAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_BroadcastDocInfo9.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .broadcastDocInfo9 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcTitleAtom = nil
            self.bcDescrAtom = nil
            self.bcSpeakerAtom = nil
            self.bcContactAtom = nil
            self.bcRexServerNameAtom = nil
            self.bcEmailAddressAtom = nil
            self.bcEmailNameAtom = nil
            self.bcChatUrlAtom = nil
            self.bcArchiveDirAtom = nil
            self.bcNSFilesBaseDirAtom = nil
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcTitleAtom (variable): An optional BCTitleAtom record that specifies the title.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .cString && nextAtom1.recInstance == 0x0001 {
            self.bcTitleAtom = try BCTitleAtom(dataStream: &dataStream)
        } else {
            self.bcTitleAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcDescrAtom = nil
            self.bcSpeakerAtom = nil
            self.bcContactAtom = nil
            self.bcRexServerNameAtom = nil
            self.bcEmailAddressAtom = nil
            self.bcEmailNameAtom = nil
            self.bcChatUrlAtom = nil
            self.bcArchiveDirAtom = nil
            self.bcNSFilesBaseDirAtom = nil
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcDescrAtom (variable): An optional BCDescriptionAtom record that specifies the description.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .cString && nextAtom2.recInstance == 0x0002 {
            self.bcDescrAtom = try BCDescriptionAtom(dataStream: &dataStream)
        } else {
            self.bcDescrAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcSpeakerAtom = nil
            self.bcContactAtom = nil
            self.bcRexServerNameAtom = nil
            self.bcEmailAddressAtom = nil
            self.bcEmailNameAtom = nil
            self.bcChatUrlAtom = nil
            self.bcArchiveDirAtom = nil
            self.bcNSFilesBaseDirAtom = nil
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcSpeakerAtom (variable): An optional BCSpeakerAtom record that specifies the name of the speaker.
        let nextAtom3 = try dataStream.peekRecordHeader()
        if nextAtom3.recType == .cString && nextAtom3.recInstance == 0x0003 {
            self.bcSpeakerAtom = try BCSpeakerAtom(dataStream: &dataStream)
        } else {
            self.bcSpeakerAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcContactAtom = nil
            self.bcRexServerNameAtom = nil
            self.bcEmailAddressAtom = nil
            self.bcEmailNameAtom = nil
            self.bcChatUrlAtom = nil
            self.bcArchiveDirAtom = nil
            self.bcNSFilesBaseDirAtom = nil
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcContactAtom (variable): An optional BCContactAtom record that specifies the name of the contact person.
        let nextAtom4 = try dataStream.peekRecordHeader()
        if nextAtom4.recType == .cString && nextAtom4.recInstance == 0x0004 {
            self.bcContactAtom = try BCContactAtom(dataStream: &dataStream)
        } else {
            self.bcContactAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcRexServerNameAtom = nil
            self.bcEmailAddressAtom = nil
            self.bcEmailNameAtom = nil
            self.bcChatUrlAtom = nil
            self.bcArchiveDirAtom = nil
            self.bcNSFilesBaseDirAtom = nil
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcRexServerNameAtom (variable): An optional BCRexServerNameAtom record that specifies the name of the remote computer to which a
        /// camera or microphone is connected to record the video or audio. It MUST exist if the fCameraRemote field of the BroadcastDocInfoAtom
        /// record is set to TRUE.
        let nextAtom5 = try dataStream.peekRecordHeader()
        if nextAtom5.recType == .cString && nextAtom5.recInstance == 0x0005 {
            self.bcRexServerNameAtom = try BCRexServerNameAtom(dataStream: &dataStream)
        } else {
            self.bcRexServerNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcEmailAddressAtom = nil
            self.bcEmailNameAtom = nil
            self.bcChatUrlAtom = nil
            self.bcArchiveDirAtom = nil
            self.bcNSFilesBaseDirAtom = nil
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcEmailAddressAtom (variable): An optional BCEmailAddressAtom record that specifies the e-mail address for audience feedback.
        let nextAtom6 = try dataStream.peekRecordHeader()
        if nextAtom6.recType == .cString && nextAtom6.recInstance == 0x0006 {
            self.bcEmailAddressAtom = try BCEmailAddressAtom(dataStream: &dataStream)
        } else {
            self.bcEmailAddressAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcEmailNameAtom = nil
            self.bcChatUrlAtom = nil
            self.bcArchiveDirAtom = nil
            self.bcNSFilesBaseDirAtom = nil
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcEmailNameAtom (variable): An optional BCEmailNameAtom record that specifies the e-mail name for audience feedback. It MUST exist
        /// if bcDocInfoAtom.fCanEmail is TRUE.
        let nextAtom7 = try dataStream.peekRecordHeader()
        if nextAtom7.recType == .cString && nextAtom7.recInstance == 0x0007 {
            self.bcEmailNameAtom = try BCEmailNameAtom(dataStream: &dataStream)
        } else {
            self.bcEmailNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcChatUrlAtom = nil
            self.bcArchiveDirAtom = nil
            self.bcNSFilesBaseDirAtom = nil
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcChatUrlAtom (variable): An optional BCChatUrlAtom record that specifies the URL of a chat server.
        let nextAtom8 = try dataStream.peekRecordHeader()
        if nextAtom8.recType == .cString && nextAtom8.recInstance == 0x0008 {
            self.bcChatUrlAtom = try BCChatUrlAtom(dataStream: &dataStream)
        } else {
            self.bcChatUrlAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcArchiveDirAtom = nil
            self.bcNSFilesBaseDirAtom = nil
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcArchiveDirAtom (variable): An optional BCArchiveDirAtom record that specifies the directory location to archive this presentation
        /// broadcast.
        let nextAtom9 = try dataStream.peekRecordHeader()
        if nextAtom9.recType == .cString && nextAtom9.recInstance == 0x0009 {
            self.bcArchiveDirAtom = try BCArchiveDirAtom(dataStream: &dataStream)
        } else {
            self.bcArchiveDirAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcNSFilesBaseDirAtom = nil
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcNSFilesBaseDirAtom (variable): An optional BCNetShowFilesBaseDirAtom record that specifies the UNC base directory to store
        /// presentation broadcast files for NetShow.
        let nextAtom10 = try dataStream.peekRecordHeader()
        if nextAtom10.recType == .cString && nextAtom10.recInstance == 0x000A {
            self.bcNSFilesBaseDirAtom = try BCNetShowFilesBaseDirAtom(dataStream: &dataStream)
        } else {
            self.bcNSFilesBaseDirAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcNSFilesDirAtom = nil
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcNSFilesDirAtom (variable): An optional BCNetShowFilesDirAtom record that specifies the UNC directory location to store presentation
        /// broadcast files for NetShow. It MUST exist if bcDocInfoAtom.fUseNetShow is TRUE.
        let nextAtom11 = try dataStream.peekRecordHeader()
        if nextAtom11.recType == .cString && nextAtom11.recInstance == 0x000B {
            self.bcNSFilesDirAtom = try BCNetShowFilesDirAtom(dataStream: &dataStream)
        } else {
            self.bcNSFilesDirAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcNSServerNameAtom = nil
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcNSServerNameAtom (variable): An optional BCNetShowServerNameAtom record that specifies the name of the NetShow server. It
        /// MUST exist if bcDocInfoAtom.fUseNetShow is TRUE.
        let nextAtom12 = try dataStream.peekRecordHeader()
        if nextAtom12.recType == .cString && nextAtom12.recInstance == 0x000C {
            self.bcNSServerNameAtom = try BCNetShowServerNameAtom(dataStream: &dataStream)
        } else {
            self.bcNSServerNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcPptFilesBaseDirAtom = nil
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcPptFilesBaseDirAtom (variable): A BCPptFilesBaseDirAtom record that specifies the path to the UNC base directory to store presentation
        /// broadcast files.
        let nextAtom13 = try dataStream.peekRecordHeader()
        if nextAtom13.recType == .cString && nextAtom13.recInstance == 0x000D {
            self.bcPptFilesBaseDirAtom = try BCPptFilesBaseDirAtom(dataStream: &dataStream)
        } else {
            self.bcPptFilesBaseDirAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcPptFilesDirAtom = nil
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcPptFilesDirAtom (variable): A BCPptFilesDirAtom record that specifies the path to the UNC directory to store presentation broadcast files.
        let nextAtom14 = try dataStream.peekRecordHeader()
        if nextAtom14.recType == .cString && nextAtom14.recInstance == 0x000E {
            self.bcPptFilesDirAtom = try BCPptFilesDirAtom(dataStream: &dataStream)
        } else {
            self.bcPptFilesDirAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcPptFilesBaseUrlAtom = nil
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcPptFilesBaseUrlAtom (variable): A BCPptFilesBaseUrlAtom record that specifies the UNC or HTTP location of the directory specified in
        /// bcPptFilesDirAtom.
        let nextAtom15 = try dataStream.peekRecordHeader()
        if nextAtom15.recType == .cString && nextAtom15.recInstance == 0x000F {
            self.bcPptFilesBaseUrlAtom = try BCPptFilesBaseUrlAtom(dataStream: &dataStream)
        } else {
            self.bcPptFilesBaseUrlAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcUserNameAtom = nil
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcUserNameAtom (variable): A BCUserNameAtom record that specifies the name of the user who scheduled the presentation broadcast.
        let nextAtom16 = try dataStream.peekRecordHeader()
        if nextAtom16.recType == .cString && nextAtom16.recInstance == 0x0010 {
            self.bcUserNameAtom = try BCUserNameAtom(dataStream: &dataStream)
        } else {
            self.bcUserNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcBroadcastDateTimeAtom = nil
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcBroadcastDateTimeAtom (variable): A BCBroadcastDateTimeAtom record that specifies the directory name to create under the base
        /// directory specified in bcPptFilesBaseDirAtom.
        let nextAtom17 = try dataStream.peekRecordHeader()
        if nextAtom17.recType == .cString && nextAtom17.recInstance == 0x0011 {
            self.bcBroadcastDateTimeAtom = try BCBroadcastDateTimeAtom(dataStream: &dataStream)
        } else {
            self.bcBroadcastDateTimeAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcPresentationNameAtom = nil
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcPresentationNameAtom (variable): A BCPresentationNameAtom record that specifies the name of the presentation.
        let nextAtom18 = try dataStream.peekRecordHeader()
        if nextAtom18.recType == .cString && nextAtom18.recInstance == 0x0012 {
            self.bcPresentationNameAtom = try BCPresentationNameAtom(dataStream: &dataStream)
        } else {
            self.bcPresentationNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcAsdFileNameAtom = nil
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcAsdFileNameAtom (variable): A BCAsdFileNameAtom record that specifies the location of an ASD file. The ASD file is the description file
        /// for an Advanced Systems Format (ASF) file, described in [ASF], used to stream audio and video content.
        let nextAtom20 = try dataStream.peekRecordHeader()
        if nextAtom20.recType == .cString && nextAtom20.recInstance == 0x0013 {
            self.bcAsdFileNameAtom = try BCAsdFileNameAtom(dataStream: &dataStream)
        } else {
            self.bcAsdFileNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcEntryIdAtom = nil
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcEntryIdAtom (variable): An optional BCEntryIDAtom record that specifies the identifier for a calendar item to associate with this
        /// presentation broadcast.
        let nextAtom21 = try dataStream.peekRecordHeader()
        if nextAtom21.recType == .cString && nextAtom21.recInstance == 0x0014 {
            self.bcEntryIdAtom = try BCEntryIDAtom(dataStream: &dataStream)
        } else {
            self.bcEntryIdAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.bcDocInfoAtom = nil
            return
        }
        
        /// bcDocInfoAtom (42 bytes): A BroadcastDocInfoAtom record that specifies properties of a presentation broadcast.
        if try dataStream.peekRecordHeader().recType == .broadcastDocInfo9Atom {
            self.bcDocInfoAtom = try BroadcastDocInfoAtom(dataStream: &dataStream)
        } else {
            self.bcDocInfoAtom = nil
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
