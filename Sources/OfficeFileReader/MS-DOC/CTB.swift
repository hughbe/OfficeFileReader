//
//  CTB.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.48 CTB
/// The CTB structure specifies a custom toolbar.
public struct CTB {
    public let name: Xst
    public let cbTBData: Int32
    public let tb: TB
    public let rVisualData: [TBVisualData]
    public let iWCTB: Int32
    public let reserved: Int16
    public let unused: UInt16
    public let cCtls: Int32
    public let rTBC: [TBC]
    
    public init(dataStream: inout DataStream) throws {
        /// name (variable): A structure of type Xst that specifies the name of this custom toolbar.
        self.name = try Xst(dataStream: &dataStream)
        
        /// cbTBData (4 bytes): A signed integer value that specifies the size, in bytes, of this structure excluding the name, cCtls, and rTBC fields.
        /// The value is given by the following formula.
        /// cbTBData = sizeof(tb) + sizeof(rVisualData) + 12
        self.cbTBData = try dataStream.read(endianess: .littleEndian)
        
        /// tb (variable): A structure of type TB, as specified in [MS-OSHARED]. This structure contains toolbar data.
        self.tb = try TB(dataStream: &dataStream)
        
        /// rVisualData (100 bytes): A zero-based index array of TBVisualData, as specified in [MSOSHARED] structures. The number of
        /// elements in this array MUST be 5. The index of each structure in the array corresponds to a Word view number. Refer to the following
        /// table for the meaning of each TBVisualData, as defined in [MS-OSHARED] structures, according to its position in this array.
        /// Array index of structure Meaning of TBVisualData
        /// 0 Contains the visual information for this toolbar to be used when the application is in Normal view.
        /// 1 Contains the visual information for this toolbar to be used when the application is in Print Preview view.
        /// 2 Contains the visual information for this toolbar to be used when the application is in full screen view.
        /// 3 Contains the visual information for this toolbar to be used when the application is in both Print Preview view and full screen view.
        /// 4 Contains the visual information for this toolbar to be used when the application is in Hyperlink view<211>.
        var rVisualData: [TBVisualData] = []
        rVisualData.reserveCapacity(5)
        for _ in 0..<5 {
            rVisualData.append(try TBVisualData(dataStream: &dataStream))
        }
        
        self.rVisualData = rVisualData
        
        /// iWCTB (4 bytes): A signed integer that specifies the zero-based index of the Customization structure that contains this structure in the
        /// rCustomizations array that contains the Customization structure that contains this structure. The value MUST be greater or equal to
        /// 0x00000000 and MUST be less than the value of the cCust field of the CTBWRAPPER structure that contains the rCustomizations array
        /// that contains the Customization structure that contains this structure.
        self.iWCTB = try dataStream.read(endianess: .littleEndian)
        if self.iWCTB < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved (2 bytes): This MUST be 0x0000 and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        /// unused (2 bytes): This is undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        /// cCtls (4 bytes): A signed integer that specifies the number of toolbar controls in this toolbar.
        self.cCtls = try dataStream.read(endianess: .littleEndian)
        
        /// rTBC (variable): A zero-based index array of TBC structures. The number of elements in this array MUST equal cCtls.
        var rTBC: [TBC] = []
        rTBC.reserveCapacity(Int(self.cCtls))
        for _ in 0..<self.cCtls {
            rTBC.append(try TBC(dataStream: &dataStream))
        }
        
        self.rTBC = rTBC
    }
}
