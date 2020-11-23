//
//  TimeVariant.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.78 TimeVariant
/// Referenced by: TimeAnimationValueListEntry
/// A variable type record whose type and meaning are dictated by the value of the type field of any of these four structures, as specified by the following
/// table.
public enum TimeVariant {
    /// TL_TVT_Bool A TimeVariantBool record that specifies a Boolean value.
    case bool(data: TimeVariantBool)
    
    /// TL_TVT_Int A TimeVariantInt that specifies an integer value.
    case int(data: TimeVariantInt)
    
    /// TL_TVT_Float A TimeVariantFloat record that specifies a floating-point number.
    case float(data: TimeVariantFloat)
    
    /// TL_TVT_String A TimeVariantString record that specifies a string.
    case string(data: TimeVariantString)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recType == .timeVariant else {
            throw OfficeFileError.corrupted
        }
        
        guard let type = TimeVariantTypeEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = position
        
        switch type {
        case .bool:
            self = .bool(data: try TimeVariantBool(dataStream: &dataStream))
        case .int:
            self = .int(data: try TimeVariantInt(dataStream: &dataStream))
        case .float:
            self = .float(data: try TimeVariantFloat(dataStream: &dataStream))
        case .string:
            self = .string(data: try TimeVariantString(dataStream: &dataStream))
        }
    }
}
