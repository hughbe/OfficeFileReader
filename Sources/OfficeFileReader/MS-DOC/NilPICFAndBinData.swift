//
//  NilPICFAndBinData.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.158 NilPICFAndBinData
/// The NilPICFAndBinData structure that holds header information and binary data for a hyperlink, form field, or add-in field. The NilPICFAndBinData
/// structure MUST be stored in the Data Stream.
public struct NilPICFAndBinData {
    public let lcb: Int32
    public let cbHeader: UInt16
    public let ignored: [UInt8]
    public let binData: BinData
    
    public init(dataStream: inout DataStream, fieldType: String) throws {
        let startPosition = dataStream.position
        
        /// lcb (4 bytes): A signed integer that specifies the size, in bytes, of this structure.
        self.lcb = try dataStream.read(endianess: .littleEndian)
        
        /// cbHeader (2 bytes): An unsigned integer that specifies the number of bytes from the beginning of this structure to the beginning of
        /// binData. This value MUST be 0x44.
        self.cbHeader = try dataStream.read(endianess: .littleEndian)
        if self.cbHeader != 0x44 {
            throw OfficeFileError.corrupted
        }
        
        /// ignored (62 bytes): This field MUST be 0 and MUST be ignored.
        self.ignored = try dataStream.readBytes(count: 62)
        
        /// binData (variable): The interpretation of the binData element depends on the field type of the field containing the picture character and
        /// is given by the following.
        /// The NilPICFAndBinData structure is invalid if it describes a picture character that is not inside a field or is inside a field with a field type other
        /// than those specified in the preceding table. The size of binData is lcb –cbHeader. The data MAY<228> be invalid. If the data is invalid, it
        /// MUST be ignored.
        switch fieldType {
        case "REF":
            self.binData = .ref(data: try HFD(dataStream: &dataStream))
        case "PAGEREF":
            self.binData = .pageref(data: try HFD(dataStream: &dataStream))
        case "FORMTEXT":
            self.binData = .formtext(data: try FFData(dataStream: &dataStream))
        case "FORMCHECKBOX":
            self.binData = .formcheckbox(data: try FFData(dataStream: &dataStream))
        case "NOTEREF":
            self.binData = .noteref(data: try HFD(dataStream: &dataStream))
        case "PRIVATE":
            self.binData = .private(data: try dataStream.readBytes(count: Int(self.lcb) - Int(self.cbHeader)))
        case "ADDIN":
            self.binData = .addin(data: try dataStream.readBytes(count: Int(self.lcb) - Int(self.cbHeader)))
        case "FORMDROPDOWN":
            self.binData = .formdropdown(data: try FFData(dataStream: &dataStream))
        case "HYPERLINK":
            self.binData = .hyperlink(data: try HFD(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
        
        if dataStream.position - startPosition != self.lcb {
            throw OfficeFileError.corrupted
        }
    }
    
    /// binData (variable): The interpretation of the binData element depends on the field type of the field containing the picture character and
    /// is given by the following.
    /// The NilPICFAndBinData structure is invalid if it describes a picture character that is not inside a field or is inside a field with a field type other
    /// than those specified in the preceding table. The size of binData is lcb –cbHeader. The data MAY<228> be invalid. If the data is invalid, it
    /// MUST be ignored.
    public enum BinData {
        /// REF HFD
        case ref(data: HFD)
        
        /// PAGEREF HFD
        case pageref(data: HFD)
        
        /// FORMTEXT FFData
        case formtext(data: FFData)
        
        /// FORMCHECKBOX FFData
        case formcheckbox(data: FFData)
        
        /// NOTEREF HFD
        case noteref(data: HFD)
        
        /// PRIVATE Custom binary data that is specified by the add-in that inserted this field.
        case `private`(data: [UInt8])
        
        /// ADDIN Custom binary data that is specified by the add-in that inserted this field.
        case addin(data: [UInt8])
        
        /// FORMDROPDOWN FFData
        case formdropdown(data: FFData)
        
        /// HYPERLINK HFD
        case hyperlink(data: HFD)
    }
}
