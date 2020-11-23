//
//  SoundIdRef.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.2.27 SoundIdRef
/// Referenced by: AnimationInfoAtom, ExWAVAudioEmbeddedAtom, InteractiveInfoAtom, SlideShowSlideInfoAtom, VisualSoundAtom
/// A 4-byte unsigned integer that specifies a reference to a sound. It MUST be 0x00000000 or equal to the integer value of the soundIdAtom field
/// of a SoundContainer record (section 2.4.16.3). The value 0x00000000 specifies a null reference.
public typealias SoundIdRef = UInt32
