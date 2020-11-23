//
//  InteractiveInfoInstance.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.6.7 InteractiveInfoInstance
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// A variable type record whose type and meaning are dictated by the value of rh.recInstance as specified in the following table.
public enum InteractiveInfoInstance {
    /// 0x000 A MouseClickInteractiveInfoContainer record that specifies actions to perform when the mouse is clicked on an object.
    case mouseClick(data: MouseClickInteractiveInfoContainer)
    
    /// 0x001 A MouseOverInteractiveInfoContainer record that specifies actions to perform when the mouse is moved over an object.
    case mouseOver(data: MouseOverInteractiveInfoContainer)
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.peekBits(endianess: .littleEndian)

        /// recVer (4 bits): An unsigned integer that specifies the version of the record data that follows the record header. A value of 0xF specifies
        /// that the record is a container record.
        let _ = UInt8(flags.readBits(count: 4))
        
        /// recInstance (12 bits): An unsigned integer that specifies the record instance data. Interpretation of the value is dependent on the particular
        /// record type.
        let recInstance = flags.readRemainingBits()
        
        if recInstance == 0x000 {
            self = .mouseClick(data: try MouseClickInteractiveInfoContainer(dataStream: &dataStream))
        } else if recInstance == 0x0001 {
            self = .mouseOver(data: try MouseOverInteractiveInfoContainer(dataStream: &dataStream))
        } else {
            throw OfficeFileError.corrupted
        }
    }
}
