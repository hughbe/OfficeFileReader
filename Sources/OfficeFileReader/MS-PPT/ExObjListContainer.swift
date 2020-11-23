//
//  ExObjListContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.1 ExObjListContainer
/// Referenced by: DocumentContainer
/// A container record that specifies a list of external objects in the document.
public struct ExObjListContainer {
    public let rh: RecordHeader
    public let exObjListAtom: ExObjListAtom
    public let rgChildRec: [ExObjListSubContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalObjectList.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalObjectList else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exObjListAtom (12 bytes): An ExObjListAtom record that specifies list-specific properties.
        self.exObjListAtom = try ExObjListAtom(dataStream: &dataStream)
        
        /// rgChildRec (variable): An array of ExObjListSubContainer records that specifies the external objects. The length, in bytes, of the array is
        /// specified by the following formula: rh.recLen – 12.
        var rgChildRec: [ExObjListSubContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgChildRec.append(try ExObjListSubContainer(dataStream: &dataStream))
        }
        
        self.rgChildRec = rgChildRec
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
