//
//  NoZoomViewInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.7 NoZoomViewInfoAtom
/// Referenced by: OutlineViewInfoContainer, SorterViewInfoContainer
/// An atom record that specifies origin and scaling information for a view that cannot be zoomed beyond 100 percent.
public struct NoZoomViewInfoAtom {
    public let rh: RecordHeader
    public let curScale: ScalingStruct
    public let unused1: [UInt8]
    public let origin: PointStruct
    public let unused2: UInt8
    public let fDraftMode: bool1
    public let unused3: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_ViewInfoAtom.
        /// rh.recLen MUST be 0x00000034.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .viewInfoAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000034 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// curScale (16 bytes): A ScalingStruct structure that specifies the scaling of content in the view. Subfields are further specified in the
        /// following table.
        /// Field Meaning
        /// curScale.x Specifies scaling of the x-axis. The value of curScale.x.numer / curScale.x.denom MUST be greater than or equal to 0.20 and
        /// less than or equal to 1.0.
        /// curScale.y Specifies scaling of the y-axis. The value of curScale.y.numer / curScale.y.denom MUST be equal to
        /// curScale.x.numer / curScale.x.denom.
        let curScale = try ScalingStruct(dataStream: &dataStream)
        guard curScale.x.ratio >= 0.20 && curScale.x.ratio <= 1.0 else {
            throw OfficeFileError.corrupted
        }
        guard curScale.y.ratio == curScale.x.ratio else {
            throw OfficeFileError.corrupted
        }
        
        self.curScale = curScale
        
        /// unused1 (24 bytes): Undefined and MUST be ignored.
        self.unused1 = try dataStream.readBytes(count: 24)
        
        /// origin (8 bytes): A PointStruct structure (section 2.12.5) that specifies a position in master units, relative to the top-left corner of the full
        /// view, that is displayed in the top-left corner of the displayable view area.
        self.origin = try PointStruct(dataStream: &dataStream)
        
        /// unused2 (1 byte): Undefined and MUST be ignored.
        self.unused2 = try dataStream.read()
        
        /// fDraftMode (1 byte): A bool1 (section 2.2.2) that specifies whether the view is displayed with less formatting.
        self.fDraftMode = try bool1(dataStream: &dataStream)
        
        /// unused3 (2 bytes): Undefined and MUST be ignored.
        self.unused3 = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
