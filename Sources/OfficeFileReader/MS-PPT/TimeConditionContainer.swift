//
//  TimeConditionContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.75 TimeConditionContainer
/// Referenced by: ExtTimeNodeContainer, SubEffectContainer
/// A container record that specifies a time condition of a time node.
public struct TimeConditionContainer {
    public let rh: RecordHeader
    public let conditionAtom: TimeConditionAtom
    public let visualElement: ClientVisualElementContainer?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be greater than or equal to 0x000 and less than or equal to 0x005.
        /// rh.recType MUST be an RT_TimeConditionContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance <= 0x005 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeConditionContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// conditionAtom (24 bytes): A TimeConditionAtom record that specifies the information that is used to evaluate the time condition.
        self.conditionAtom = try TimeConditionAtom(dataStream: &dataStream)
        
        /// visualElement (variable): An optional ClientVisualElementContainer record (section 2.8.44) that specifies the target object that participates
        /// in the evaluation of the time condition. It MUST exist if and only if conditionAtom.triggerObject is TL_TOT_VisualElement.
        if self.conditionAtom.triggerObject == .visualElement {
            self.visualElement = try ClientVisualElementContainer(dataStream: &dataStream)
        } else {
            self.visualElement = nil
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
