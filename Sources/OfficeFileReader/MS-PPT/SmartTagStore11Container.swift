//
//  SmartTagStore11Container.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.28 SmartTagStore11Container
/// Referenced by: PP11DocBinaryTagExtension
/// A container record that specifies information about all smart tags within the corresponding presentation. A smart tag is additional information that is
/// specified to correspond to a string of text.
public struct SmartTagStore11Container {
    public let rh: RecordHeader
    public let cBags: UInt32
    public let propBagStore: PropertyBagStore
    public let rgPpropBag: [PropertyBag]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_SmartTagStore11Container.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .smartTagStore11Container else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// cBags (4 bytes): An unsigned integer that specifies the count of items in rgPpropBag.
        self.cBags = try dataStream.read(endianess: .littleEndian)
        
        /// propBagStore (variable): A PropertyBagStore that specifies a collection of smart tag types and their corresponding data as specified in
        /// [MS-OSHARED] section 2.3.4.1.
        self.propBagStore = try PropertyBagStore(dataStream: &dataStream)
        
        /// rgPpropBag (variable): An array of PropertyBag that specifies a set of properties with their corresponding key/value pairs as specified in
        /// [MS-OSHARED] section 2.3.4.4. These key/value pairs each represent a string of text and correspond to an entry within propBagStore.
        var rgPpropBag: [PropertyBag] = []
        rgPpropBag.reserveCapacity(Int(self.cBags))
        for _ in 0..<self.cBags {
            rgPpropBag.append(try PropertyBag(dataStream: &dataStream))
        }
        
        self.rgPpropBag = rgPpropBag
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
