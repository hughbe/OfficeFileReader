//
//  CTBWRAPPER.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.49 CTBWRAPPER
/// The CTBWRAPPER structure is a custom toolbar wrapper. This structure contains the custom toolbars and toolbar deltas that are saved to the file.
public struct CTBWRAPPER {
    public let reserved1: UInt8
    public let reserved2: UInt16
    public let reserved3: UInt8
    public let reserved4: UInt16
    public let reserved5: UInt16
    public let cbTBD: Int16
    public let cCust: Int16
    public let cbDTBC: Int32
    public let rtbdc: [TBC]
    public let rCustomizations: [Customization]
    
    public init(dataStream: inout DataStream) throws {
        /// reserved1 (1 byte): This value MUST be 0x12.
        self.reserved1 = try dataStream.read()
        if self.reserved1 != 0x12 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved2 (2 bytes): This value MUST be 0x0000.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
        if self.reserved2 != 0x0000 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved3 (1 byte): This value MUST be 0x07.
        self.reserved3 = try dataStream.read()
        if self.reserved3 != 0x07 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved4 (2 bytes): This value MUST be 0x0006.
        self.reserved4 = try dataStream.read(endianess: .littleEndian)
        if self.reserved4 != 0x0006 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved5 (2 bytes): This value MUST be 0x000C.
        self.reserved5 = try dataStream.read(endianess: .littleEndian)
        if self.reserved5 != 0x000C {
            throw OfficeFileError.corrupted
        }
        
        /// cbTBD (2 bytes): A signed integer that specifies the size, in bytes, of a TBDelta structure. This value MUST be 0x0012.
        self.cbTBD = try dataStream.read(endianess: .littleEndian)
        if self.cbTBD != 0x0012 {
            throw OfficeFileError.corrupted
        }
        
        /// cCust (2 bytes): A signed integer that specifies the number of elements in the rCustomizations array. This value MUST be greater
        /// than 0x0000.
        self.cCust = try dataStream.read(endianess: .littleEndian)
        if self.cCust < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// cbDTBC (4 bytes): A signed integer that specifies the size, in bytes, of the rtbdc array. This value MUST be greater or equal to 0x00000000.
        self.cbDTBC = try dataStream.read(endianess: .littleEndian)
        if self.cbDTBC < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rtbdc (variable): An array of TBC structures. The total size of this array, in bytes, MUST be equal to the value of cbDTBC. The TBC
        /// structures in this array specify toolbar controls that are associated with TBDelta structures.
        var rtbdc: [TBC] = []
        let startPosition = dataStream.position
        while dataStream.position - startPosition < self.cbDTBC {
            rtbdc.append(try TBC(dataStream: &dataStream))
        }
        
        if dataStream.position - startPosition != self.cbDTBC {
            throw OfficeFileError.corrupted
        }
        
        self.rtbdc = rtbdc
        
        /// rCustomizations (variable): A zero-based index array of Customization structures. The number of elements MUST be equal to cCust.
        var rCustomizations: [Customization] = []
        rCustomizations.reserveCapacity(Int(self.cCust))
        for _ in 0..<self.cCust {
            rCustomizations.append(try Customization(dataStream: &dataStream))
        }
        
        self.rCustomizations = rCustomizations
    }
}
