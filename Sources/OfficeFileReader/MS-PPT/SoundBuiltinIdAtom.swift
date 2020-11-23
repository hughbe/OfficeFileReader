//
//  SoundBuiltinIdAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.16.7 SoundBuiltinIdAtom
/// Referenced by: SoundContainer
/// An atom record that specifies a description of a sound.
public struct SoundBuiltinIdAtom {
    public let rh: RecordHeader
    public let data: Builtin
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x003.
        /// rh.recType MUST be RT_CString (section 2.13.24).
        /// rh.recLen MUST be an even number.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x003 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (self.rh.recLen % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// soundBuiltinId (variable): A UTF-16 Unicode [RFC2781] string representation of the base-10 form of an integer value that specifies a
        /// description of a sound. It MUST be a value from the following table.
        /// The length, in bytes, of the field is specified by rh.recLen.
        let dataRaw = try dataStream.readString(count: Int(self.rh.recLen), encoding: .utf16LittleEndian)!
        guard let data = Builtin(rawValue: dataRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.data = data
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// soundBuiltinId (variable): A UTF-16 Unicode [RFC2781] string representation of the base-10 form of an integer value that specifies a
    /// description of a sound. It MUST be a value from the following table.
    /// The length, in bytes, of the field is specified by rh.recLen.
    public enum Builtin: String {
        /// 100 Cash Register
        case cashRegister = "100"

        /// 101 Typewriter
        case typewriter = "101"

        /// 102 Screeching Brakes
        case screechingBrakes = "102"

        /// 103 Whoosh
        case whoosh = "103"

        /// 104 Laser
        case laser = "104"

        /// 105 Camera
        case camera = "105"

        /// 106 Chime
        case chime = "106"

        /// 107 Clapping
        case clapping = "107"

        /// 108 Applause
        case applause = "108"

        /// 109 Drive By
        case driveBy = "109"

        /// 110 Drum Roll
        case drumRoll = "110"

        /// 111 Explosion
        case explosion = "111"

        /// 112 Breaking Glass
        case breakingGlass = "112"

        /// 113 Gunshot
        case gunshot = "113"

        /// 114 Slide Projector
        case slideProjector = "114"

        /// 115 Ricochet
        case ricochet = "115"

        /// 116 Arrow
        case arrow = "116"

        /// 117 Bomb
        case bomb = "117"

        /// 118 Breeze
        case breeze = "118"

        /// 119 Click
        case click = "119"

        /// 120 Coin
        case coin = "120"

        /// 121 Hammer
        case hammer = "121"

        /// 122 Push
        case push = "122"

        /// 123 Suction
        case suction = "123"

        /// 124 Voltage
        case voltage = "124"

        /// 125 Wind
        case wind = "125"
    }
}
