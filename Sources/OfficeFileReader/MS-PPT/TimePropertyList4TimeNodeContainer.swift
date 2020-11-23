//
//  TimePropertyList4TimeNodeContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.18 TimePropertyList4TimeNodeContainer
/// Referenced by: ExtTimeNodeContainer, SubEffectContainer
/// A container record that specifies a list of attributes for a time node.
/// Let the corresponding time node be specified by the ExtTimeNodeContainer record (section 2.8.15) or the SubEffectContainer record (section 2.8.16)
/// that contains this TimePropertyList4TimeNodeContainer record.
public struct TimePropertyList4TimeNodeContainer {
    public let rh: RecordHeader
    public let rgTimeVariant: [TimeVariant4TimeNode]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_TimePropertyList.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timePropertyList else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgTimeVariant (variable): An array of TimeVariant4TimeNode records that specifies the list of attributes for the corresponding time node.
        /// The size, in bytes, of the array is specified by rh.recLen. Each TimePropertyID4TimeNode enumeration value MUST NOT occur more than
        /// once as a value of the rh.recInstance field in the array.
        /// If the TL_TPID_AfterEffect value does not occur, a TimeVariantBool record in which the boolValue field is set to 0x00 SHOULD be used.
        /// If the TL_TPID_Display value does not occur, a TimeDisplayType record in which the displayType field is set to 0x00000000 SHOULD be used.
        /// If the corresponding time node is an ExtTimeNodeContainer record (section 2.8.15), the following values MUST NOT occur:
        /// TL_TPID_MasterPos and TimeSubType.
        /// If the corresponding time node is a SubEffectContainer record, the following values MUST NOT occur: TL_TPID_EffectID,
        /// TL_TPID_EffectDir, TL_TPID_EffectType, TL_TPID_SlideCount, TL_TPID_TimeFilter, TL_TPID_EventFilter, TL_TPID_HideWhenStopped,
        /// TL_TPID_GroupID, TL_TPID_EffectNodeType, and TL_TPID_ZoomToFullScreen.
        var rgTimeVariant: [TimeVariant4TimeNode] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgTimeVariant.append(try TimeVariant4TimeNode(dataStream: &dataStream))
        }
        
        self.rgTimeVariant = rgTimeVariant
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
