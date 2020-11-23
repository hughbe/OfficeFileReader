//
//  FibRgFcLcb2007.swift
//
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.10 FibRgFcLcb2007
/// The FibRgFcLcb2007 structure is a variable-sized portion of the Fib. It extends the FibRgFcLcb2003.
public struct FibRgFcLcb2007 {
    public let rgFcLcb2003: FibRgFcLcb2003
    public let fcPlcfmthd: UInt32
    public let lcbPlcfmthd: UInt32
    public let fcSttbfBkmkMoveFrom: UInt32
    public let lcbSttbfBkmkMoveFrom: UInt32
    public let fcPlcfBkfMoveFrom: UInt32
    public let lcbPlcfBkfMoveFrom: UInt32
    public let fcPlcfBklMoveFrom: UInt32
    public let lcbPlcfBklMoveFrom: UInt32
    public let fcSttbfBkmkMoveTo: UInt32
    public let lcbSttbfBkmkMoveTo: UInt32
    public let fcPlcfBkfMoveTo: UInt32
    public let lcbPlcfBkfMoveTo: UInt32
    public let fcPlcfBklMoveTo: UInt32
    public let lcbPlcfBklMoveTo: UInt32
    public let fcUnused1: UInt32
    public let lcbUnused1: UInt32
    public let fcUnused2: UInt32
    public let lcbUnused2: UInt32
    public let fcUnused3: UInt32
    public let lcbUnused3: UInt32
    public let fcSttbfBkmkArto: UInt32
    public let lcbSttbfBkmkArto: UInt32
    public let fcPlcfBkfArto: UInt32
    public let lcbPlcfBkfArto: UInt32
    public let fcPlcfBklArto: UInt32
    public let lcbPlcfBklArto: UInt32
    public let fcArtoData: UInt32
    public let lcbArtoData: UInt32
    public let fcUnused4: UInt32
    public let lcbUnused4: UInt32
    public let fcUnused5: UInt32
    public let lcbUnused5: UInt32
    public let fcUnused6: UInt32
    public let lcbUnused6: UInt32
    public let fcOssTheme: UInt32
    public let lcbOssTheme: UInt32
    public let fcColorSchemeMapping: UInt32
    public let lcbColorSchemeMapping: UInt32
    
    public init(dataStream: inout DataStream, fibBase: FibBase, fibRgLw97: FibRgLw97) throws {
        /// rgFcLcb2003 (1312 bytes): The contained FibRgFcLcb2003.
        self.rgFcLcb2003 = try FibRgFcLcb2003(dataStream: &dataStream, fibBase: fibBase, fibRgLw97: fibRgLw97)
        
        /// fcPlcfmthd (4 bytes): This value is undefined and MUST be ignored.
        self.fcPlcfmthd = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfmthd (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbPlcfmthd = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfBkmkMoveFrom (4 bytes): This value is undefined and MUST be ignored.
        self.fcSttbfBkmkMoveFrom = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfBkmkMoveFrom (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbSttbfBkmkMoveFrom = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBkfMoveFrom (4 bytes): This value is undefined and MUST be ignored
        self.fcPlcfBkfMoveFrom = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBkfMoveFrom (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbPlcfBkfMoveFrom = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBklMoveFrom (4 bytes): This value is undefined and MUST be ignored.
        self.fcPlcfBklMoveFrom = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBklMoveFrom (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbPlcfBklMoveFrom = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfBkmkMoveTo (4 bytes): This value is undefined and MUST be ignored.
        self.fcSttbfBkmkMoveTo = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfBkmkMoveTo (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbSttbfBkmkMoveTo = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBkfMoveTo (4 bytes): This value is undefined and MUST be ignored.
        self.fcPlcfBkfMoveTo = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBkfMoveTo (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbPlcfBkfMoveTo = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBklMoveTo (4 bytes): This value is undefined and MUST be ignored.
        self.fcPlcfBklMoveTo = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBklMoveTo (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbPlcfBklMoveTo = try dataStream.read(endianess: .littleEndian)

        /// fcUnused1 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused1 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused1 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused1 = try dataStream.read(endianess: .littleEndian)

        /// fcUnused2 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused2 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused2 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused2 = try dataStream.read(endianess: .littleEndian)

        /// fcUnused3 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused3 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused3 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused3 = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfBkmkArto (4 bytes): This value is undefined and MUST be ignored.
        self.fcSttbfBkmkArto = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfBkmkArto (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbSttbfBkmkArto = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBkfArto (4 bytes): This value is undefined and MUST be ignored.
        self.fcPlcfBkfArto = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBkfArto (4 bytes): This value MUST be zero, and MUST be ignored
        self.lcbPlcfBkfArto = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBklArto (4 bytes): Undefined and MUST be ignored.
        self.fcPlcfBklArto = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBklArto (4 bytes): MUST be zero, and MUST be ignored.
        self.lcbPlcfBklArto = try dataStream.read(endianess: .littleEndian)

        /// fcArtoData (4 bytes): This value is undefined and MUST be ignored.
        self.fcArtoData = try dataStream.read(endianess: .littleEndian)

        /// lcbArtoData (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbArtoData = try dataStream.read(endianess: .littleEndian)

        /// fcUnused4 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused4 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused4 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused4 = try dataStream.read(endianess: .littleEndian)

        /// fcUnused5 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused5 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused5 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused5 = try dataStream.read(endianess: .littleEndian)

        /// fcUnused6 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused6 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused6 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused6 = try dataStream.read(endianess: .littleEndian)

        /// fcOssTheme (4 bytes): This value is undefined and MUST be ignored.
        self.fcOssTheme = try dataStream.read(endianess: .littleEndian)

        /// lcbOssTheme (4 bytes): This value SHOULD<144> be zero, and MUST be ignored.
        self.lcbOssTheme = try dataStream.read(endianess: .littleEndian)

        /// fcColorSchemeMapping (4 bytes): This value is undefined and MUST be ignored.
        self.fcColorSchemeMapping = try dataStream.read(endianess: .littleEndian)

        /// lcbColorSchemeMapping (4 bytes): This value SHOULD<145> be zero, and MUST be ignored.
        self.lcbColorSchemeMapping = try dataStream.read(endianess: .littleEndian)

    }
}
