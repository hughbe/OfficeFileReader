//
//  Customization.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.50 Customization
/// The Customization structure specifies either a custom toolbar or toolbar delta values.
public struct Customization {
    public let tbidForTBD: Int32
    public let reserved1: UInt16
    public let ctbds: Int16
    public let customizationData: CustomizationData
    
    public init(dataStream: inout DataStream) throws {
        /// tbidForTBD (4 bytes): A signed integer that specifies if customizationData contains a CTB structure or an array of TBDelta structures.
        /// This value MUST be greater than or equal to 0x00000000. If this value equals 0x00000000, customizationData MUST contain a CTB
        /// structure. If this value does not equal 0x00000000, customizationData MUST contain an array of TBDelta structures and the value of
        /// this field specifies the toolbar identifier of the toolbar affected by the TBDelta structures contained in the array.
        self.tbidForTBD = try dataStream.read(endianess: .littleEndian)
        if self.tbidForTBD < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// reserved1 (2 bytes): This MUST be 0x0000 and MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// ctbds (2 bytes): A signed integer that specifies, if tbidForTBD is not equal to 0x00000000, the number of TBDelta structures that are
        /// contained in the customizationData array. This MUST be 0x0000 if tbidForTBD equals 0x00000000.
        let ctbds: Int16 = try dataStream.read(endianess: .littleEndian)
        if self.tbidForTBD == 0x00000000 && ctbds != 0x0000 {
            throw OfficeFileError.corrupted
        }
        
        self.ctbds = ctbds
        
        /// customizationData (variable): The type of this structure depends on the value of tbidForTBD. The types of this structure are shown following.
        if self.tbidForTBD == 0x00000000 {
            self.customizationData = .ctb(data: try CTB(dataStream: &dataStream))
        } else {
            /// not 0x00000000 A zero-based index array of TBDelta structures. The number of elements in the array MUST be equal to ctbds.
            var tbDelta: [TBDelta] = []
            tbDelta.reserveCapacity(Int(self.ctbds))
            for _ in 0..<self.ctbds {
                tbDelta.append(try TBDelta(dataStream: &dataStream))
            }
            
            self.customizationData = .tbDelta(data: tbDelta)
        }
    }
    
    /// customizationData (variable): The type of this structure depends on the value of tbidForTBD. The types of this structure are shown following.
    public enum CustomizationData {
        case ctb(data: CTB)
        case tbDelta(data: [TBDelta])
    }
}
