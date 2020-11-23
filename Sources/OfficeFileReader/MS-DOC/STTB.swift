//
//  STTB.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.2.4 STTB
/// The STTB is a string table that is made up of a header that is followed by an array of elements. The cData value specifies the number of elements
/// that are contained in the array.
public struct STTB<TData> where TData: STTBData {
    public let fExtend: Bool
    public let cData: UInt32
    public let cbExtra: UInt16
    public let cchData: [UInt16]
    public let data: [TData]
    public let extraData: [[UInt8]]?
    
    public init(dataStream: inout DataStream, fourByteCData: Bool = false) throws {
        /// The header consists of the following.
        /// fExtend (variable): If the first two bytes of the STTB are equal to 0xFFFF, this is a 2-byte fExtend field that specifies, by its existence, that the
        /// Data fields in this STTB contain extended (2-byte) characters and that the cchData fields are 2 bytes in size. If the first two bytes of the STTB are
        /// not equal to 0xFFFF, this fExtend field does not exist, which specifies, by its nonexistence, that the Data fields in this STTB contain nonextended
        /// (1-byte) characters and that the cchData fields are 1 byte in size.
        if try dataStream.peek(endianess: .littleEndian) as UInt16 == 0xFFFF {
            self.fExtend = true
            dataStream.position += 2
        } else {
            self.fExtend = false
        }
        
        /// cData (variable): A 2-byte unsigned integer or a 4-byte signed integer that specifies the count of elements in this STTB. If this is a 2-byte
        /// unsigned integer, it MUST be less than 0xFFFF. If this is a 4-byte signed integer, it MUST be greater than zero. Unless otherwise specified,
        /// this is a 2-byte unsigned integer.
        if fourByteCData {
            self.cData = try dataStream.read(endianess: .littleEndian)
        } else {
            self.cData = UInt32(try dataStream.read(endianess: .littleEndian) as UInt16)
        }
        
        /// cbExtra (2 bytes): An unsigned integer that specifies the size, in bytes, of the ExtraData fields in this STTB.
        self.cbExtra = try dataStream.read(endianess: .littleEndian)
        
        var cchData: [UInt16] = []
        var data: [TData] = []
        var extraData: [[UInt8]]?
        if self.cbExtra > 0 {
            extraData = []
        }

        for _ in 0..<self.cData {
            /// The array of elements consists of the following.
            /// cchData (variable): An unsigned integer that specifies the count of characters in the Data field following this field. If this STTB is using
            /// extended characters as defined by fExtend, the size of cchData is 2 bytes. If this STTB is not using extended characters, the size of
            /// cchData is 1 byte.
            let chData: UInt16
            if self.fExtend {
                chData = try dataStream.read(endianess: .littleEndian)
            } else {
                chData = UInt16(try dataStream.read() as UInt8)
            }
            
            cchData.append(chData)
        
            /// Data (variable): The definition of each STTB specifies the meaning of this field. If this STTB uses extended characters, the size of this field is
            /// 2×cchData bytes and it is a Unicode string unless otherwise specified by the STTB definition. If this STTB does not use extended characters,
            /// then the size of this field is cchData bytes and it is an ANSI string, unless otherwise specified by the STTB definition.
            data.append(try TData(dataStream: &dataStream, size: chData, extend: fExtend))
            
            /// ExtraData (variable): The definition of each STTB specifies the structure and meaning of this field. The size of this field is cbExtra bytes.
            if self.cbExtra > 0 {
                extraData!.append(try dataStream.readBytes(count: Int(self.cbExtra)))
            }
        }
        
        self.cchData = cchData
        self.data = data
        self.extraData = extraData
    }
}

public protocol STTBData {
    init(dataStream: inout DataStream, size: UInt16, extend: Bool) throws
}

extension String: STTBData {
    public init(dataStream: inout DataStream, size: UInt16, extend: Bool) throws {
        if extend {
            self = try dataStream.readString(count: Int(size) * 2, encoding: .utf16LittleEndian)!
        } else {
            self = try dataStream.readString(count: Int(size), encoding: .ascii)!
        }
    }
}
