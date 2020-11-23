//
//  TimeAnimateBehaviorContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.29 TimeAnimateBehaviorContainer
/// Referenced by: ExtTimeNodeContainer
/// A container record that specifies a generic animation behavior. This animation behavior is applied to the object specified by the
/// behavior.clientVisualElement field and used to animate one property specified by the behavior.stringList field. The property MUST be one from the list
/// that is specified in the TimeStringListContainer record (section 2.8.36).
public struct TimeAnimateBehaviorContainer {
    public let rh: RecordHeader
    public let animateBehaviorAtom: TimeAnimateBehaviorAtom
    public let animateValueList: TimeAnimationValueListContainer?
    public let varBy: TimeVariantString?
    public let varFrom: TimeVariantString?
    public let varTo: TimeVariantString?
    public let behavior: TimeBehaviorContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeAnimateBehaviorContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeAnimateBehaviorContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// animateBehaviorAtom (20 bytes): A TimeAnimateBehaviorAtom record that specifies the value type of the animated property as specified
        /// in the behavior.stringList field, how to interpolate the value, and which attributes of this field and this TimeAnimateBehaviorContainer
        /// record are valid.
        self.animateBehaviorAtom = try TimeAnimateBehaviorAtom(dataStream: &dataStream)
        
        /// animateValueList (variable): An optional TimeAnimationValueListContainer record (section 2.8.31) that specifies the list of key points that
        /// consists of a time and the value at that time. The animateBehaviorAtom.calcMode field specifies how to calculate interpolated values
        /// between these key points. It MUST be ignored if animateBehaviorAtom.fAnimationValuesPropertyUsed is FALSE.
        if try dataStream.peekRecordHeader().recType == .timeAnimationValueList {
            self.animateValueList = try TimeAnimationValueListContainer(dataStream: &dataStream)
        } else {
            self.animateValueList =  nil
        }
        
        /// varBy (variable): An optional TimeVariantString record that specifies the offset value of the animated property. The sub-field
        /// varBy.rh.recInstance MUST be 0x001. It MUST be in a format dictated by the value of animateBehaviorAtom.valueType as specified in the
        /// following table.
        /// Value Meaning
        /// TL_TABVT_String An arbitrary Unicode string.
        /// TL_TABVT_Number A preset string value as specified in the varTo field of the TimeSetBehaviorContainer record (section 2.8.69); or a
        /// string that specifies a real number, whose format is specified by the varTo field of the TimeSetBehaviorContainer record.
        /// TL_TABVT_Color A string that specifies a color value, whose format is specified by the varTo field of the TimeSetBehaviorContainer record.
        /// MUST be ignored if varTo exists. It MUST be ignored if animateValueList exists. It MUST be ignored if animateBehaviorAtom.fByPropertyUsed
        /// is FALSE.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .timeVariant && nextAtom1.recInstance == 0x001 {
            self.varBy = try TimeVariantString(dataStream: &dataStream)
        } else {
            self.varBy = nil
        }
        
        /// varFrom (variable): An optional TimeVariantString record that specifies the starting value of the animated property. The sub-field
        /// varFrom.rh.recInstance MUST be 0x002. It MUST be in a format dictated by the value of animateBehaviorAtom.valueType as specified in
        /// the following table.
        /// Value Meaning
        /// TL_TABVT_String An arbitrary Unicode string.
        /// TL_TABVT_Number A preset string value as specified in the varTo field of the TimeSetBehaviorContainer record; or a string that specifies
        /// a real number, whose format is specified by the varTo field of the TimeSetBehaviorContainer record.
        /// TL_TABVT_Color A string that specifies a color value, whose format is specified by the varTo field of the TimeSetBehaviorContainer record.
        /// If varFrom exists, varTo or varBy MUST also exist. It MUST be ignored if animateValueList exists. It MUST be ignored if
        /// animateBehaviorAtom.fFromPropertyUsed is FALSE.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .timeVariant && nextAtom2.recInstance == 0x002 {
            self.varFrom = try TimeVariantString(dataStream: &dataStream)
        } else {
            self.varFrom = nil
        }
        
        /// varTo (variable): An optional TimeVariantString record that specifies the end value of the animated property. The sub-field
        /// varTo.rh.recInstance MUST be 0x003. It MUST be in a format dictated by the value of animateBehaviorAtom.valueType as specified in the
        /// following table. Value Meaning
        /// TL_TABVT_String An arbitrary Unicode string.
        /// TL_TABVT_Number A preset string value as specified in the varTo field of the TimeSetBehaviorContainer record; or a string that specifies a
        /// real number, whose format is specified by the varTo field of the TimeSetBehaviorContainer record.
        /// TL_TABVT_Color A string that specifies a color value, whose format is specified by the varTo field of the TimeSetBehaviorContainer record.
        /// MUST be ignored if animateValueList exists. It MUST be ignored if animateBehaviorAtom.fToPropertyUsed is FALSE.
        let nextAtom3 = try dataStream.peekRecordHeader()
        if nextAtom3.recType == .timeVariant && nextAtom3.recInstance == 0x003 {
            self.varTo = try TimeVariantString(dataStream: &dataStream)
        } else {
            self.varTo = nil
        }
        
        /// behavior (variable): A TimeBehaviorContainer record (section 2.8.34) that specifies the common animation behavior information.
        self.behavior = try TimeBehaviorContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
