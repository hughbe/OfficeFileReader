//
//  VtHyperlink.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream
import OlePropertySet

/// [MS-DOC] 2.3.3.1.18 VtHyperlink
/// Referenced by: VecVtHyperlink
/// Specifies the data format for a hyperlink for a property
public struct VtHyperlink {
    public let dwHash: TypedPropertyValue
    public let dwApp: TypedPropertyValue
    public let dwOfficeArt: TypedPropertyValue
    public let dwInfo: TypedPropertyValue
    public let hlink1: VtString
    public let hlink2: VtString
    
    public init(dataStream: inout DataStream) throws {
        /// dwHash (8 bytes): MUST be a VT_I4 TypedPropertyValue as specified in [MS-OLEPS] section 2.15. The Value field of this structure
        /// SHOULD be calculated as specified in the Hyperlink Hash (section 2.4.2) section with the hlink1 field and hlink2 field string values
        /// given as input.<21>
        self.dwHash = try TypedPropertyValue(dataStream: &dataStream, codePage: nil)
        if self.dwHash.type != .i4 {
            throw OfficeFileError.corrupted
        }
        
        /// dwApp (8 bytes): MUST be a VT_I4 TypedPropertyValue as specified in [MS-OLEPS] section 2.15. The Value field of this structure is
        /// implementation specific.<22>
        self.dwApp = try TypedPropertyValue(dataStream: &dataStream, codePage: nil)
        if self.dwApp.type != .i4 {
            throw OfficeFileError.corrupted
        }
        
        /// dwOfficeArt (8 bytes): MUST be a VT_I4 TypedPropertyValue as specified in [MS-OLEPS] section 2.15. The Value field of this structure
        /// MUST be a MSOSPID type value ([MS-ODRAW] section 2.1.2) specifying the identifier of the shape ([MS-ODRAW] section 2.2.31) to
        /// which this hyperlink applies in the document. If this hyperlink does not apply to a shape, the Value field of this structure MUST be
        /// 0x00000000.
        self.dwOfficeArt = try TypedPropertyValue(dataStream: &dataStream, codePage: nil)
        if self.dwOfficeArt.type != .i4 {
            throw OfficeFileError.corrupted
        }
        
        /// dwInfo (8 bytes): MUST be a VT_I4 TypedPropertyValue as specified in [MS-OLEPS] section 2.15. The Value field of this structure is
        /// implementation specific.<23> The high-order 2-byte integer of the Value field of this structure SHOULD be 0x0000. The unsigned 2-byte
        /// integer specified by the high two bytes of this value can be written as 0x0000 by an application that saves the entire file, as it specifies
        /// that the hyperlink is in sync with the document contents. If a process changes the hyperlink property element without a corresponding
        /// change to the related document content such that the hyperlink needs to be fixed in the document the next time the document is loaded,
        /// this value needs to be changed to 0x0001 by the process. If such a process wishes to specify that the hyperlink is to be removed from
        /// the document the next time the document is loaded, this value needs to be changed to 0x0002 by the process.
        self.dwInfo = try TypedPropertyValue(dataStream: &dataStream, codePage: nil)
        if self.dwInfo.type != .i4 {
            throw OfficeFileError.corrupted
        }
        
        /// hlink1 (variable): MUST be a VtString structure (section 2.3.3.1.11) with hlink1.wType equal to VT_LPWSTR. hlink1.stringValue specifies
        /// the hyperlink target.
        self.hlink1 = try VtString(dataStream: &dataStream)
        if self.hlink1.stringType != 0x001F {
            throw OfficeFileError.corrupted
        }
        
        /// hlink2 (variable): MUST be a VtString structure (section 2.3.3.1.11) with hlink2.wType equal to VT_LPWSTR. hlink2.stringValue specifies
        /// the hyperlink location.
        self.hlink2 = try VtString(dataStream: &dataStream)
        if self.hlink2.stringType != 0x001F {
            throw OfficeFileError.corrupted
        }
    }
}
