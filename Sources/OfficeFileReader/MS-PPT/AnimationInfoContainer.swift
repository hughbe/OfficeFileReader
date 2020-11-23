//
//  AnimationInfoContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.1 AnimationInfoContainer
/// Referenced by: OfficeArtClientData
/// A container record that specifies the animation and sound information for a shape.
public struct AnimationInfoContainer {
    public let rh: RecordHeader
    public let animationAtom: AnimationInfoAtom
    public let animationSound: SoundContainer?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_AnimationInfo.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .animationInfo else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// animationAtom (36 bytes): An AnimationInfoAtom record that specifies the animation effectinformation for the shape. It SHOULD<103>
        /// be ignored.
        self.animationAtom = try AnimationInfoAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.animationSound = nil
            return
        }
        
        /// animationSound (variable): An optional SoundContainer record (section 2.4.16.3) that specifies the sound for the animation specified by
        /// the animationAtom. If this field exists, it overrides the animationAtom.soundIdRef.
        self.animationSound = try SoundContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
