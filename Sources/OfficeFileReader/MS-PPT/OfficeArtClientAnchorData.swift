//
//  OfficeArtClientAnchorData.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.2 OfficeArtClientAnchorData
/// Referenced by: OfficeArtClientAnchor
/// A variable type structure whose type and meaning are dictated by the value of rh.recLen of the OfficeArtClientAnchor record that contains this
/// OfficeArtClientAnchorData structure, as specified in the following table.
public enum OfficeArtClientAnchorData {
    case smallRect(data: SmallRectStruct)
    case rect(data: RectStruct)
    
    public init(dataStream: inout DataStream, length: Int) throws {
        if length == 0x00000008 {
            self = .smallRect(data: try SmallRectStruct(dataStream: &dataStream))
        } else if length == 0x00000010 {
            self = .rect(data: try RectStruct(dataStream: &dataStream))
        } else {
            throw OfficeFileError.corrupted
        }
    }
}
