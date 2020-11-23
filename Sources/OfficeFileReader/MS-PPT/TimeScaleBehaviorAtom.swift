//
//  TimeScaleBehaviorAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.68 TimeScaleBehaviorAtom
/// Referenced by: TimeScaleBehaviorContainer
/// An atom record that specifies animation information for scaling the size of an object.
public struct TimeScaleBehaviorAtom {
    public let rh: RecordHeader
    public let fByPropertyUsed: Bool
    public let fFromPropertyUsed: Bool
    public let fToPropertyUsed: Bool
    public let fZoomContentsUsed: Bool
    public let reserved: UInt32
    public let fXBy: Float
    public let fYBy: Float
    public let fXFrom: Float
    public let fYFrom: Float
    public let fXTo: Float
    public let fYTo: Float
    public let fZoomContents: bool1
    public let unused: [UInt8]

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeScaleBehavior.
        /// rh.recLen MUST be 0x00000020.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeScaleBehavior else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000020 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fByPropertyUsed (1 bit): A bit that specifies whether fXBy and fYBy were explicitly set by a user interface action.
        self.fByPropertyUsed = flags.readBit()
        
        /// B - fFromPropertyUsed (1 bit): A bit that specifies whether fXFrom and fYFrom were explicitly set by a user interface action. If
        /// fFromPropertyUsed is TRUE, fByPropertyUsed or fToPropertyUsed MUST also be TRUE.
        self.fFromPropertyUsed = flags.readBit()
        
        /// C - fToPropertyUsed (1 bit): A bit that specifies whether fXTo and fYTo were explicitly set by a user interface action.
        self.fToPropertyUsed = flags.readBit()
        
        /// D - fZoomContentsUsed (1 bit): A bit that specifies whether fZoomContents was explicitly set by a user interface action.
        self.fZoomContentsUsed = flags.readBit()
        
        /// reserved (28 bits): MUST be zero, and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// fXBy (4 bytes): A floating-point number that specifies the offset value of the width of the object that is animated. It MUST be ignored if
        /// fByPropertyUsed is FALSE or if fToPropertyUsed is TRUE.
        self.fXBy = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fYBy (4 bytes): A floating-point number that specifies the offset value of the height of the object that is animated. It MUST be ignored if
        /// fByPropertyUsed is FALSE or if fToPropertyUsed is TRUE.
        self.fYBy = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fXFrom (4 bytes): A floating-point number that specifies the starting value of the width of the object that is animated. It MUST be ignored
        /// if fFromPropertyUsed is FALSE and a value of 0 MUST be used instead.
        self.fXFrom = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fYFrom (4 bytes): A floating-point number that specifies the starting value of the height of the object that is animated. It MUST be ignored if
        /// fFromPropertyUsed is FALSE and a value of 0 MUST be used instead.
        self.fYFrom = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fXTo (4 bytes): A floating-point number that specifies the end value of the width of the object that is animated. It MUST be ignored if
        /// fToPropertyUsed is FALSE and a value of 100 MUST be used instead.
        self.fXTo = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fYTo (4 bytes): A floating-point number that specifies the end value of the height of the object that is animated. It MUST be ignored if
        /// fToPropertyUsed is FALSE and a value of 100 MUST be used instead.
        self.fYTo = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fZoomContents (1 byte): A bool1 (section 2.2.2) that specifies whether the content contained by the scaling object is also scaled. It MUST
        /// be ignored if fZoomContentsUsed is FALSE and a value of 0x01 MUST be used instead.
        self.fZoomContents = try bool1(dataStream: &dataStream)
        
        /// unused (3 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.readBytes(count: 3)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
