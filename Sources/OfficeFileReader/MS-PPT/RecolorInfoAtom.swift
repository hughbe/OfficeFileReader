//
//  RecolorInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.9 RecolorInfoAtom
/// Referenced by: OfficeArtClientData
/// An atom record that specifies a collection of re-color mappings for a metafile ([MS-WMF]). The corresponding metafile is specified by the Blip properties
/// ([MS-ODRAW] section 2.3.23) of the OfficeArtSpContainer ([MS-ODRAW] section 2.2.14) that contains this RecolorInfoAtom record.
public struct RecolorInfoAtom {
    public let rh: RecordHeader
    public let fShouldRecolor: Bool
    public let fMissingColors: Bool
    public let fMissingFills: Bool
    public let unused1: Bool
    public let fMonoRecolor: Bool
    public let unused2: UInt16
    public let cColors: UInt16
    public let cFills: UInt16
    public let monoColor: WideColorStruct
    public let rgRecolorEntry: [RecolorEntry]
    public let unused3: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_RecolorInfoAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .recolorInfoAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fShouldRecolor (1 bit): A bit that specifies whether the re-color mappings are applied.
        self.fShouldRecolor = flags.readBit()
        
        /// B - fMissingColors (1 bit): A bit that specifies whether rgRecolorEntry has more than 64 items with a RecolorEntryColor variant. It SHOULD<97>
        /// be ignored.
        self.fMissingColors = flags.readBit()
        
        /// C - fMissingFills (1 bit): A bit that specifies whether rgRecolorEntry has more than 64 items with a RecolorEntryBrush variant. It SHOULD<98>
        /// be ignored.
        self.fMissingFills = flags.readBit()
        
        /// D - unused1 (1 bit): Undefined and MUST be ignored.
        self.unused1 = flags.readBit()
        
        /// E - fMonoRecolor (1 bit): A bit that specifies whether monoColor is used as the destination color instead of the destination colors specified by
        /// the RecolorEntry structures in the rgRecolorEntry array.
        self.fMonoRecolor = flags.readBit()
        
        /// unused2 (11 bits): Undefined and MUST be ignored.
        self.unused2 = flags.readRemainingBits()
        
        /// cColors (2 bytes): An unsigned integer that specifies the count of items in the rgRecolorEntry array with a RecolorEntryColor variant.
        self.cColors = try dataStream.read(endianess: .littleEndian)
        
        /// cFills (2 bytes): An unsigned integer that specifies the count of items in the rgRecolorEntry array with a RecolorEntryBrush variant.
        self.cFills = try dataStream.read(endianess: .littleEndian)
        
        /// monoColor (6 bytes): A WideColorStruct structure that specifies the destination color if the fMonoRecolor bit is set.
        self.monoColor = try WideColorStruct(dataStream: &dataStream)
        
        /// rgRecolorEntry (variable): An array of RecolorEntry structures that specifies color mappings. The count of items in the array is specified by
        /// cColors + cFills. It MUST contain cColor items with a RecolorEntryColor variant. It MUST contain cFills items with a RecolorEntryBrush variant.
        var rgRecolorEntry: [RecolorEntry] = []
        let count = self.cColors + self.cFills
        rgRecolorEntry.reserveCapacity(Int(count))
        for _ in 0..<count {
            rgRecolorEntry.append(try RecolorEntry(dataStream: &dataStream))
        }
        
        self.rgRecolorEntry = rgRecolorEntry
        
        /// unused3 (variable): Undefined and MUST be ignored. The size, in bytes, is specified by the following formula:
        /// rh.recLen – ( 12 + 44 * ( cColors + cFills ) )
        let unusedCount = Int(self.rh.recLen) - (12 + 44 * Int(count))
        self.unused3 = try dataStream.readBytes(count: unusedCount)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
