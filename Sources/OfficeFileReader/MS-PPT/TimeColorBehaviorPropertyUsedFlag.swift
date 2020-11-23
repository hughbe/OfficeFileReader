//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.54 TimeColorBehaviorPropertyUsedFlag
/// Referenced by: TimeColorBehaviorAtom
/// A structure that specifies which attributes of a color animation are valid.
/// Let the corresponding TimeColorBehaviorAtom be specified by the TimeColorBehaviorAtom record that contains this
/// TimeColorBehaviorPropertyUsedFlag record.
/// Let the corresponding TimeColorBehaviorContainer be specified by the TimeColorBehaviorContainer record (section 2.8.52) that contains the
/// corresponding TimeColorBehaviorAtom.
public struct TimeColorBehaviorPropertyUsedFlag {
    public let fByPropertyUsed: Bool
    public let fFromPropertyUsed: Bool
    public let fToPropertyUsed: Bool
    public let fColorSpacePropertyUsed: Bool
    public let fDirectionPropertyUsed: Bool
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fByPropertyUsed (1 bit): A bit that specifies whether the colorBy field of the corresponding TimeColorBehaviorAtom is valid.
        self.fByPropertyUsed = flags.readBit()
        
        /// B - fFromPropertyUsed (1 bit): A bit that specifies whether the colorFrom field of the corresponding TimeColorBehaviorAtom is valid.
        self.fFromPropertyUsed = flags.readBit()
        
        /// C - fToPropertyUsed (1 bit): A bit that specifies whether the colorTo field of the corresponding TimeColorBehaviorAtom is valid.
        self.fToPropertyUsed = flags.readBit()
        
        /// D - fColorSpacePropertyUsed (1 bit): A bit that specifies whether the behavior.propertyList.rec field of the corresponding
        /// TimeColorBehaviorContainer which has behavior.propertyList.rec.rh.recInstance equal to TL_TBPID_ColorColorModel was explicitly
        /// set by a user interface action.
        self.fColorSpacePropertyUsed = flags.readBit()
        
        /// E - fDirectionPropertyUsed (1 bit): A bit that specifies whether the behavior.propertyList.rec field of the corresponding
        /// TimeColorBehaviorContainer which has behavior.propertyList.rec.rh.recInstance equal to TL_TBPID_ColorDirection was explicitly set
        /// by a user interface action.
        self.fDirectionPropertyUsed = flags.readBit()
        
        /// reserved (27 bits): MUST be zero, and MUST be ignored.
        self.reserved = flags.readRemainingBits()
    }
}
