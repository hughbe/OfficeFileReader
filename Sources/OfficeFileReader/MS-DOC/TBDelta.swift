//
//  TBDelta.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.311 TBDelta
/// The TBDelta structure specifies a toolbar delta. When the toolbar delta involves adding or modifying a toolbar control, the affected toolbar control
/// is stored in the rtbdc array of the CTBWRAPPER structure that contains the rCustomizations array, that contains the Customization structure that
/// contains the customizationData array, that contains this structure.
public struct TBDelta {
    public let dopr: DeltaOperationType
    public let fAtEnd: Bool
    public let reserved1: UInt8
    public let ibts: UInt8
    public let cidNext: UInt32
    public let cid: Cid
    public let fc: UInt32
    public let fOnDisk: Bool
    public let iTB: UInt16
    public let reserved2: Bool
    public let fDead: Bool
    public let cbTBC: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags1: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - dopr (2 bits): These bits specify the type of toolbar delta operation. This MUST be one of the following values.
        let doprRaw = UInt8(flags1.readBits(count: 2))
        guard let dopr = DeltaOperationType(rawValue: doprRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.dopr = dopr
        
        /// B - fAtEnd (1 bit): A bit that specifies if the toolbar control that is associated with this TBDelta was inserted at the end of the toolbar at
        /// the time the toolbar delta was created. A value of 1 specifies that the toolbar control that is associated with this TBDelta was inserted
        /// at the end of the toolbar. This bit MUST be 0 if dopr is not equal to 1.
        let fAtEnd: Bool = flags1.readBit()
        if self.dopr != .insert && fAtEnd {
            throw OfficeFileError.corrupted
        }
        
        self.fAtEnd = fAtEnd
        
        /// reserved1 (5 bits): This value MUST be 0 and MUST be ignored.
        self.reserved1 = UInt8(flags1.readBits(count: 5))
        
        /// ibts (8 bits): An unsigned integer that specifies the zero-based index of the toolbar control that was associated with this TBDelta in the
        /// toolbar at the time that the toolbar delta was created. It is possible for more than one TBDelta structure that affects the same toolbar
        /// to have the same
        self.ibts = UInt8(flags1.readBits(count: 8))
        
        /// cidNext (4 bytes): A signed integer value. This value MUST be one of the following.
        /// Condition Value of cidNext
        /// dopr equals 1 and fAtEnd equals 1 0xFFFFFFFF
        /// dopr equals 1, fAtEnd equals 0, and the toolbar control after the inserted toolbar control associated to this TBDelta at the time the
        /// TBDelta was created is not a custom toolbar control A structure of type Cid that specifies the command identifier, at the time the
        /// toolbar delta was created, for the toolbar control after the inserted toolbar control associated to this TBDelta. Toolbar controls MUST
        /// only have Cid structures that have Cmt values equal to 0x0001 or 0x0003.
        /// dopr equals 1, fAtEnd equals 0, and the toolbar control after the inserted toolbar control associated to this TBDelta at the time the
        /// TBDelta was created is a custom toolbar control 0x00001EF9
        /// dopr equals 0 cidNext equals cid.
        /// dopr equals 2 and the toolbar control after the deleted toolbar control that was associated with this TBDelta at the time the TBDelta was
        /// created is not a custom toolbar control A structure of type Cid that specifies the command identifier at the time that the toolbar delta was
        /// created for the toolbar control after the deleted toolbar control was associated with this TBDelta. Toolbar controls MUST only have Cid
        /// structures that have Cmt values equal to 0x0001 or 0x0003.
        /// dopr equals 2 and the toolbar control after the deleted toolbar control associated to this TBDelta at the time the TBDelta was created is a
        /// custom toolbar control 0x00001EF9
        let cidNext: UInt32 = try dataStream.read(endianess: .littleEndian)
        if self.dopr == .insert && fAtEnd && cidNext != 0xFFFFFFFF {
            throw OfficeFileError.corrupted
        } else if self.dopr == .insert && !fAtEnd && cidNext != 0x00001EF9 {
            throw OfficeFileError.corrupted
        }
        
        self.cidNext = cidNext
        
        /// cid (4 bytes): A structure of type Cid that specifies the command identifier for the toolbar control that is associated with this TBDelta.
        /// Toolbar controls MUST only have Cid structures that have Cmt values equal to 0x0001 or 0x0003.
        let cid: Cid = try Cid(dataStream: &dataStream)
        if cid.cmt != .fci && cid.cmt != .allocated {
            throw OfficeFileError.corrupted
        }

        self.cid = cid
        
        /// fc (4 bytes): An unsigned integer that specifies the file offset in the Table Stream where the toolbar control that is associated with this
        /// TBDelta is stored. This value MUST be 0x00000000 if fOnDisk is not equal to 1.
        let fc: UInt32 = try dataStream.read(endianess: .littleEndian)
        self.fc = fc
        
        var flags2: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// C - fOnDisk (1 bit): A bit that specifies if a toolbar control that is associated with this TBDelta was written to the file. A value of 1 specifies
        /// that a toolbar control that is associated with this TBDelta was written to the file. This value MUST be 1 if dopr is equal to 0 or 1.
        let fOnDisk = flags2.readBit()
        if (dopr == .change || dopr == .insert) && !fOnDisk {
            throw OfficeFileError.corrupted
        }
        if !fOnDisk && fc != 0x00000000 {
            throw OfficeFileError.corrupted
        }
        
        self.fOnDisk = fOnDisk
        
        /// iTB (13 bits): This field MUST be used only when the toolbar control that is associated with this TBDelta is a custom toolbar control
        /// that drops a custom menu toolbar. This is an unsigned integer that specifies the index to the Customization structure, contained in the
        /// rCustomizations array, that also contains the Customization that contains the customizationData array that contains this structure, that
        /// contains the CTB structure that specifies the custom menu toolbar dropped by the toolbar control associated to this TBDelta. This
        /// value MUST be 0 if the toolbar control that is associated with this TBDelta is not a custom toolbar control that drops a custom menu
        /// toolbar. This value MUST be greater than or equal to 0 and SHOULD<256> be less than the value of the cCust field of the
        /// CTBWRAPPER structure that contains the rCustomizations array, that contains the Customization structure, that contains the
        /// customizationData array that contains this structure.
        self.iTB = flags2.readBits(count: 13)
        
        /// D - reserved2 (1 bit): This value MUST be 0 and MUST be ignored.
        self.reserved2 = flags2.readBit()
        
        /// E - fDead (1 bit): A bit that specifies if the toolbar control that is associated with this TBDelta does not drop a menu toolbar. A value
        /// of 1 specifies that the toolbar control that is associated with this TBDelta does not drop a custom menu toolbar. This value MUST be
        /// 0 if the toolbar control that is associated with this TBDelta is not a custom toolbar control that drops a custom menu toolbar or
        /// if dopr is not equal to 1.
        let fDead = flags2.readBit()
        if dopr != .insert && fDead {
            throw OfficeFileError.corrupted
        }
        
        self.fDead = fDead
        
        /// cbTBC (2 bytes): An unsigned integer that specifies the size, in bytes, of the toolbar control that is associated with this TBDelta. This
        /// field MUST only be used when fOnDisk equals 1. If fOnDisk is equal to 0, this value MUST be 0x0000.
        let cbTBC: UInt16 = try dataStream.read(endianess: .littleEndian)
        if !fOnDisk && cbTBC != 0x0000 {
            throw OfficeFileError.corrupted
        }
        
        self.cbTBC = cbTBC
    }
    
    /// A - dopr (2 bits): These bits specify the type of toolbar delta operation. This MUST be one of the following values.
    public enum DeltaOperationType: UInt8 {
        /// 0x00 (00) Change a toolbar control.
        case change = 0x00
        
        /// 0x01 (01) Insert a toolbar control.
        case insert = 0x01
        
        /// 0x02 (10) Modify a toolbar control.
        case modify = 0x02
    }
}
