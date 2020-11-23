//
//  ExternalObjectDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.21 ExternalObjectDiffContainer
/// Referenced by: ShapeDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to an external object.
/// Let the corresponding shape be as specified in the ShapeDiffContainer record that contains this ExternalObjectDiffContainer record.
/// Let the corresponding external object be specified by one of the container records listed in the following table that contains a field, also listed in the
/// table, that matches the exObjIdRef field of the ExObjRefAtom record contained within the corresponding shape.
/// External object container Field
/// ExAviMovieContainer exVideo.exMediaAtom.exObjId
/// ExMCIMovieContainer exVideo.exMediaAtom.exObjId
/// ExCDAudioContainer exMediaAtom.exObjId
/// ExMIDIAudioContainer exMediaAtom.exObjId
/// ExWAVAudioEmbeddedContainer exMedia.exObjId
/// ExWAVAudioLinkContainer exMedia.exObjId
/// ExControlContainer (section 2.10.10) exOleObjAtom.exObjId
/// ExOleEmbedContainer (section 2.10.27) exOleObjAtom.exObjId
/// ExOleLinkContainer (section 2.10.29) exOleObjAtom.exObjId
public struct ExternalObjectDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_ExternalObjectDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .externalObjectDiff else {
            throw OfficeFileError.corrupted
        }
        
        /// reserved (32 bits): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
