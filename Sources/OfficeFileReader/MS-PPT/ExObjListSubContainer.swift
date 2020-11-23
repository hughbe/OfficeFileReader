//
//  ExObjListSubContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.2 ExObjListSubContainer
/// Referenced by: ExObjListContainer
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified in the following table.
public enum ExObjListSubContainer {
    case externalAviMovie(data: ExAviMovieContainer)
    case externalCdAudio(data: ExCDAudioContainer)
    case externalOleControl(data: ExControlContainer)
    case externalHyperlink(data: ExHyperlinkContainer)
    case externalMciMovie(data: ExMCIMovieContainer)
    case externalMidiAudio(data: ExMIDIAudioContainer)
    case externalOleEmbed(data: ExOleEmbedContainer)
    case externalOleLink(data: ExOleLinkContainer)
    case externalWavAudioEmbedded(data: ExWAVAudioEmbeddedContainer)
    case externalWavAudioLink(data: ExWAVAudioLinkContainer)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .externalAviMovie:
            self = .externalAviMovie(data: try ExAviMovieContainer(dataStream: &dataStream))
        case .externalCdAudio:
            self = .externalCdAudio(data: try ExCDAudioContainer(dataStream: &dataStream))
        case .externalOleControl:
            self = .externalOleControl(data: try ExControlContainer(dataStream: &dataStream))
        case .externalHyperlink:
            self = .externalHyperlink(data: try ExHyperlinkContainer(dataStream: &dataStream))
        case .externalMciMovie:
            self = .externalMciMovie(data: try ExMCIMovieContainer(dataStream: &dataStream))
        case .externalMidiAudio:
            self = .externalMidiAudio(data: try ExMIDIAudioContainer(dataStream: &dataStream))
        case .externalOleEmbed:
            self = .externalOleEmbed(data: try ExOleEmbedContainer(dataStream: &dataStream))
        case .externalOleLink:
            self = .externalOleLink(data: try ExOleLinkContainer(dataStream: &dataStream))
        case .externalWavAudioEmbedded:
            self = .externalWavAudioEmbedded(data: try ExWAVAudioEmbeddedContainer(dataStream: &dataStream))
        case .externalWavAudioLink:
            self = .externalWavAudioLink(data: try ExWAVAudioLinkContainer(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
