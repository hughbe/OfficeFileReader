//
//  DofrFsn.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.56 DofrFsn
/// The DofrFsn structure specifies the properties of a frame. There can be multiple DofrFsn records for a particular frame. If fsnk is fsnkFrame, this
/// record introduces a new frame. Otherwise this record applies to the frame that is associated with the previous DofrFsn with fsnk equal to fsnkFrame,
/// unless it appears before the first DofrFsn with fsnk equal to fsnkFrame. In that case, this record applies to the outermost frame.
public struct DofrFsn {
    public let fssd: Fssd
    public let tCols: ChildFramesDirection
    public let fsnk: Fsnk
    public let dxMargin: Int32
    public let dyMargin: Int32
    public let iidsScroll: IScrollType
    public let fLinked: Bool
    public let fNoResize: Bool
    public let fUnused1: UInt32
    public let fUnused2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// fssd (8 bytes): An Fssd that specifies the position of the divider. If fsnk is not fsnkFrame, this value MUST be ignored.
        self.fssd = try Fssd(dataStream: &dataStream)
        
        /// tCols (4 bytes): A signed integer value that specifies whether the child frames are displayed horizontally or vertically This field MUST
        /// contain one of the following values.
        let tColsRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let tCols = ChildFramesDirection(rawValue: tColsRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.tCols = tCols
        
        /// fsnk (4 bytes): A Fsnk that specifies the type of DofrFsn that contains this field.
        let fsnkRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let fsnk = Fsnk(rawValue: fsnkRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.fsnk = fsnk
        
        /// dxMargin (4 bytes): A signed integer that specifies the left and right margins, in pixels, for this frame.
        self.dxMargin = try dataStream.read(endianess: .littleEndian)
        
        /// dyMargin (4 bytes): A signed integer that specifies the top and bottom margins, in pixels, for this frame.
        self.dyMargin = try dataStream.read(endianess: .littleEndian)
        
        /// iidsScroll (4 bytes): An IScrollType that specifies the scroll bar behavior for this frame.
        let iidsScrollRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let iidsScroll = IScrollType(rawValue: iidsScrollRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iidsScroll = iidsScroll
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fLinked (1 bit): Specifies whether the frame is linked to an external file.
        self.fLinked = flags.readBit()
        
        /// B - fNoResize (1 bit): Specifies whether the size of the frame is locked and cannot be changed.
        self.fNoResize = flags.readBit()
        
        /// fUnused1 (30 bits): This value is undefined and MUST be ignored.
        self.fUnused1 = flags.readBits(count: 30)
        
        /// fUnused2 (32 bits): This value is undefined and MUST be ignored.
        self.fUnused2 = try dataStream.read(endianess: .littleEndian)
    }
    
    /// tCols (4 bytes): A signed integer value that specifies whether the child frames are displayed horizontally or vertically This field MUST
    /// contain one of the following values.
    public enum ChildFramesDirection: UInt32 {
        /// 0xFFFFFFFF No child frames
        case noChildFrames = 0xFFFFFFFF
        
        /// 0x00000000 Arrange child frames into rows
        case arrangeIntoRows = 0x00000000
        
        /// 0x00000001 Arrange child frames into columns
        case arrangeIntoColumns = 0x00000001
    }
}
