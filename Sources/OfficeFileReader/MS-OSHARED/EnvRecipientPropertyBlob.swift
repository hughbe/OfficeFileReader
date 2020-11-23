//
//  EnvRecipientPropertyBlob.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.6 EnvRecipientPropertyBlob
/// Referenced by: EnvRecipientProperty
/// A structure that describes the size of the data for a single recipient property. The type of this structure is specified by the PropTag of a EnvRecipientProperty
/// (section 2.3.8.5).
public enum EnvRecipientPropertyBlob {
    /// 0x0003 The property data is a PT_LONG (section 2.3.8.7).
    case long(data: PT_LONG)
    
    /// 0x0001 The property data is a PT_NULL (section 2.3.8.8).
    case null(data: PT_NULL)
    
    /// 0x000B The property data is a PT_BOOLEAN (section 2.3.8.9).
    case boolean(data: PT_BOOLEAN)
    
    /// 0x0040 The property data is a PT_SYSTIME (section 2.3.8.10).
    case systime(data: PT_SYSTIME)
    
    /// 0x000A The property data is a PT_ERROR (section 2.3.8.11).
    case error(data: PT_ERROR)
    
    /// 0x001E The property data is a PT_STRING8 section 2.3.8.12).
    case string8(data: PT_STRING8)
    
    /// 0x001F The property data is a PT_UNICODE (section 2.3.8.13).
    case unicode(data: PT_UNICODE)
    
    /// 0x0102 The property data is a PT_BINARY (section 2.3.8.14).
    case binary(data: PT_BINARY)
    
    /// 0x101E The property data is a PT_MV_STRING8 (section 2.3.8.15).
    case mvString8(data: PT_MV_STRING8)
    
    /// 0x1102 The property data is a PT_MV_BINARY (section 2.3.8.16).
    case mvBinary(data: PT_MV_BINARY)
    
    public init(dataStream: inout DataStream, propType: UInt16) throws {
        switch propType {
        case 0x0003:
            self = .long(data: try PT_LONG(dataStream: &dataStream))
        case 0x0001:
            self = .null(data: try PT_NULL(dataStream: &dataStream))
        case 0x000B:
            self = .boolean(data: try PT_BOOLEAN(dataStream: &dataStream))
        case 0x0040:
            self = .systime(data: try PT_SYSTIME(dataStream: &dataStream))
        case 0x000A:
            self = .error(data: try PT_ERROR(dataStream: &dataStream))
        case 0x001E:
            self = .string8(data: try PT_STRING8(dataStream: &dataStream))
        case 0x001F:
            self = .unicode(data: try PT_UNICODE(dataStream: &dataStream))
        case 0x0102:
            self = .binary(data: try PT_BINARY(dataStream: &dataStream))
        case 0x101E:
            self = .mvString8(data: try PT_MV_STRING8(dataStream: &dataStream))
        case 0x1102:
            self = .mvBinary(data: try PT_MV_BINARY(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
