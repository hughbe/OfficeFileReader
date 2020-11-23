//
//  InteractiveInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.6.10 InteractiveInfoAtom
/// Referenced by: MouseClickInteractiveInfoContainer, MouseOverInteractiveInfoContainer
/// An atom record that specifies a type of action to be performed.
public struct InteractiveInfoAtom {
    public let rh: RecordHeader
    public let soundIdRef: SoundIdRef
    public let exHyperlinkIdRef: ExHyperlinkIdRef
    public let action: InteractiveInfoActionEnum
    public let oleVerb: OLEVerbEnum
    public let jump: InteractiveInfoJumpEnum
    public let fAnimated: Bool
    public let fStopSound: Bool
    public let fCustomShowReturn: Bool
    public let fVisited: Bool
    public let reserved: UInt8
    public let hyperlinkType: LinkToEnum
    public let unused: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_InteractiveInfoAtom.
        /// rh.recLen MUST be 0x00000010.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .interactiveInfoAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// soundIdRef (4 bytes): A SoundIdRef that specifies the sound to play when this action executes.
        self.soundIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// exHyperlinkIdRef (4 bytes): An ExHyperlinkIdRef that specifies the hyperlink to follow when this action executes. It MUST be ignored
        /// unless action is equal to "II_JumpAction", "II_HyperlinkAction", or "II_CustomShowAction".
        self.exHyperlinkIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// action (1 byte): An InteractiveInfoActionEnum enumeration that specifies the action to perform when this action executes.
        let actionRaw: UInt8 = try dataStream.read()
        guard let action = InteractiveInfoActionEnum(rawValue: actionRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.action = action
        
        /// oleVerb (1 byte): An OLEVerbEnum enumeration that specifies the OLE verb to run when this action executes. It MUST be ignored unless
        /// action is equal to "II_OLEAction".
        let oleVerbRaw: UInt8 = try dataStream.read()
        guard let oleVerb = OLEVerbEnum(rawValue: oleVerbRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.oleVerb = oleVerb
        
        /// jump (1 byte): An InteractiveInfoJumpEnum enumeration that specifies the slide to jump to. It MUST be ignored unless action is equal to
        /// "II_JumpAction".
        let jumpRaw: UInt8 = try dataStream.read()
        guard let jump = InteractiveInfoJumpEnum(rawValue: jumpRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.jump = jump
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fAnimated (1 bit): A bit that specifies whether to animate the object this action applies to when the action is performed.
        self.fAnimated = flags.readBit()
        
        /// B - fStopSound (1 bit): A bit that specifies whether to stop currently playing sounds. It MUST be ignored if the soundIdRef field specifies
        /// a sound to play.
        self.fStopSound = flags.readBit()
        
        /// C - fCustomShowReturn (1 bit): A bit that specifies to return to the previous set of displayed slides at the end of the named show.
        /// It MUST be ignored unless action is equal to II_CustomShowAction.
        self.fCustomShowReturn = flags.readBit()
        
        /// D - fVisited (1 bit): A bit that specifies whether this action was executed since the file was last loaded.
        self.fVisited = flags.readBit()
        
        /// E - reserved (4 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// hyperlinkType (1 byte): A LinkToEnum enumeration that specifies how to interpret the hyperlink referred to by exHyperlinkIdRef.
        let hyperlinkTypeRaw: UInt8 = try dataStream.read()
        guard let hyperlinkType = LinkToEnum(rawValue: hyperlinkTypeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.hyperlinkType = hyperlinkType
        
        /// unused (3 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.readBytes(count: 3)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
