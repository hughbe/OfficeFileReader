//
//  OfficeArtFSP.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.40 OfficeArtFSP
/// Referenced by: OfficeArtSpContainer
/// The OfficeArtFSP record specifies an instance of a shape. The record header contains the shape type, and the record itself contains the shape
/// identifier and a set of bits that further define the shape.
public struct OfficeArtFSP {
    public let rh: OfficeArtRecordHeader
    public let spid: MSOSPID
    public let fGroup: Bool
    public let fChild: Bool
    public let fPatriarch: Bool
    public let fDeleted: Bool
    public let fOleShape: Bool
    public let fHaveMaster: Bool
    public let fFlipH: Bool
    public let fFlipV: Bool
    public let fConnector: Bool
    public let fHaveAnchor: Bool
    public let fBackground: Bool
    public let fHaveSpt: Bool
    public let unused1: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// rh.recVer A value that MUST be 0x2.
        /// rh.recInstance A signed value that specifies the shape type and that MUST be an MSOSPT enumeration value, as defined in section 2.4.24.
        /// rh.recType A value that MUST be 0xF00A.
        /// rh.recLen A value that MUST be 0x00000008.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x2 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF00A else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// spid (4 bytes): An MSOSPID structure, as defined in section 2.1.2, that specifies the identifier of this shape.
        self.spid = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fGroup (1 bit): A bit that specifies whether this shape is a group shape.
        self.fGroup = flags.readBit()
        
        /// B - fChild (1 bit): A bit that specifies whether this shape is a child shape.
        self.fChild = flags.readBit()
        
        /// C - fPatriarch (1 bit): A bit that specifies whether this shape is the topmost group shape. Each drawing contains one topmost group shape.
        self.fPatriarch = flags.readBit()
        
        /// D - fDeleted (1 bit): A bit that specifies whether this shape has been deleted.
        self.fDeleted = flags.readBit()
        
        /// E - fOleShape (1 bit): A bit that specifies whether this shape is an OLE object.
        self.fOleShape = flags.readBit()
        
        /// F - fHaveMaster (1 bit): A bit that specifies whether this shape has a valid master in the hspMaster property, as defined in section 2.3.2.1.
        self.fHaveMaster = flags.readBit()
        
        /// G - fFlipH (1 bit): A bit that specifies whether this shape is horizontally flipped.
        self.fFlipH = flags.readBit()
            
        /// H - fFlipV (1 bit): A bit that specifies whether this shape is vertically flipped.
        self.fFlipV = flags.readBit()
        
        /// I - fConnector (1 bit): A bit that specifies whether this shape is a connector shape.
        self.fConnector = flags.readBit()
        
        /// J - fHaveAnchor (1 bit): A bit that specifies whether this shape has an anchor.
        self.fHaveAnchor = flags.readBit()
        
        /// K - fBackground (1 bit): A bit that specifies whether this shape is a background shape.
        self.fBackground = flags.readBit()
        
        /// L - fHaveSpt (1 bit): A bit that specifies whether this shape has a shape type property.
        self.fHaveSpt = flags.readBit()
        
        /// unused1 (20 bits): A value that is undefined and MUST be ignored.
        self.unused1 = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
