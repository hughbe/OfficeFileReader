//
//  ClientVisualElementContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.44 ClientVisualElementContainer
/// Referenced by: ExtTimeNodeContainer, SubEffectContainer, TimeBehaviorContainer, TimeConditionContainer
/// A container record that specifies the target for an animation effect.
public struct ClientVisualElementContainer {
    public let rh: RecordHeader
    public let visualElementAtom: VisualElementAtom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeClientVisualElement.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeClientVisualElement else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// visualElementAtom (variable): A VisualElementAtom record that specifies the target to which the animation effect applies.
        self.visualElementAtom = try VisualElementAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
