//
//  DateTimeMCAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.50 DateTimeMCAtom
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// An atom record that specifies a datetime metacharacter.
/// The metacharacter is replaced by the current datetime. Current datetime is formatted in the style that is specified by the index field.
/// Let the corresponding text be specified by the TextHeaderAtom record that most closely precedes this DateTimeMCAtom record.
public struct DateTimeMCAtom {
    public let rh: RecordHeader
    public let position: TextPosition
    public let index: UInt8
    public let unused: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_DateTimeMetaCharAtom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .dateTimeMetaCharAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// position (4 bytes): A TextPosition that specifies the position of the metacharacter in thecorresponding text.
        self.position = try TextPosition(dataStream: &dataStream)
        
        /// index (1 byte): An unsigned byte that specifies the Format ID used to stylize datetime. The identifier specified by the Format ID is converted
        /// based on the LCID [MS-LCID] into a value or string as specified in the following tables. The LCID is specified in TextSIException.lid. If no
        /// valid LCID is found in TextSIException.lid, TextSIException.altLid (if it exists) is used. If, in the following tables, the converted Format ID is a
        /// value, it specifies the format index (specified in [MS-OSHARED] section 2.4.4.1) that is used to style the datetime. If, in the following tables,
        /// the converted Format ID is a string, that string is used as the style to format the datetime. The value MUST be greater than or equal to 0x0 and
        /// MUST be less than or equal to 0xC.
        /// LCID: American (0x0409)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 8
        /// 3 2
        /// 4 5
        /// 5 9
        /// 6 10
        /// 7 11
        /// 8 12
        /// 9 15
        /// 10 16
        /// 11 13
        /// 12 14
        /// LCID: British (0x0809) / Australian (0x0C09)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 "d MMMM, yyy"
        /// 3 2
        /// 4 5
        /// 5 9
        /// 6 10
        /// 7 11
        /// 8 12
        /// 9 15
        /// 10 16
        /// 11 13
        /// 12 14
        /// LCID: Japanese (0x0411)
        /// Format ID Converted value/string
        /// 0 4
        /// 1 8
        /// 2 7
        /// 3 3
        /// 4 0
        /// 5 9
        /// 6 5
        /// 7 11
        /// 8 12
        /// 9 "HH:mm"
        /// 10 "HH:mm:ss"
        /// 11 15
        /// 12 16
        /// LCID: Taiwan (0x0404)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 3
        /// 3 7
        /// 4 12
        /// 5 9
        /// 6 10
        /// 7 4
        /// 8 11
        /// 9 "HH:mm"
        /// 10 "HH:mm:ss"
        /// 11 "H:mm AMPM"
        /// 12 "H:mm:ss AMPM"
        /// LCID: China (0x0804)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 2
        /// 3 2
        /// 4 4
        /// 5 9
        /// 6 5
        /// 7 "\x79\x79\x79\x79\x5E74\x4D\x6708\x64\x65E5\x68\x65F6\x6D\x5206"
        /// 8 "\x79\x79\x79\x79\x5E74\x4D\x6708\x64\x65E5\x661F
        /// \x671f\x57\x68\x65F6\x6D\x5206\x73\x79D2"
        /// 9 "HH:mm"
        /// 10 "HH:mm:ss"
        /// 11 "\x41\x4D\x50\x4D\x68\x65F6\x6D\x5206"
        /// 12 "\x41\x4D\x50\x4D\x68\x65F6\x6D\x5206\x73\x79D2"
        /// LCID: Korean (0x0412)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 6
        /// 3 3
        /// 4 4
        /// 5 10
        /// 6 7
        /// 7 12
        /// 8 11
        /// 9 "HH:mm"
        /// 10 "HH:mm:ss"
        /// 11 13
        /// 12 14
        /// LCID: Arabic (0x0401)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 2
        /// 3 3
        /// 4 4
        /// 5 5
        /// 6 8
        /// 7 7
        /// 8 8
        /// 9 1
        /// 10 10
        /// 11 11
        /// 12 5
        /// LCID: Hebrew (0x040D)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 2
        /// 3 6
        /// 4 11
        /// 5 5
        /// 6 12
        /// 7 7
        /// 8 8
        /// 9 9
        /// 10 1
        /// 11 11
        /// 12 6
        /// LCID: Swedish (0x041D)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 3
        /// 3 2
        /// 4 7
        /// 5 9
        /// 6 10
        /// 7 11
        /// 8 12
        /// 9 15
        /// 10 16
        /// 11 13
        /// 12 14
        /// LCID: Singapore (0x1004) / Macao SAR (0x1404) / Hong Kong SAR (0x0C04)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 3
        /// 3 2
        /// 4 4
        /// 5 9
        /// 6 5
        /// 7 "\x79\x79\x79\x79\x5E74\x4D\x6708\x64\x65E5\x68\x65F6\x6D\x5206"
        /// 8 "\x79\x79\x79\x79\x5E74\x4D\x6708\x64\x65E5\x661F
        /// \x671f\x57\x68\x65F6\x6D\x5206\x73\x79D2"
        /// 9 "HH:mm"
        /// 10 "HH:mm:ss"
        /// 11 "\x41\x4D\x50\x4D\x68\x65F6\x6D\x5206"
        /// 12 "\x41\x4D\x50\x4D\x68\x65F6\x6D\x5206\x73\x79D2"
        /// LCID: Thai (0x41E)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 2
        /// 3 3
        /// 4 5
        /// 5 6
        /// 6 7
        /// 7 8
        /// 8 9
        /// 9 10
        /// 10 11
        /// 11 13
        /// 12 14
        /// LCID: Vietnamese (0x042A)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 2
        /// 3 3
        /// 4 5
        /// 5 6
        /// 6 10
        /// 7 11
        /// 8 12
        /// 9 13
        /// 10 14
        /// 11 15
        /// 12 16
        /// LCID: Hindi (0x0439)
        /// Format ID Converted value/string
        /// 0 1
        /// 1 2
        /// 2 3
        /// 3 5
        /// 4 7
        /// 5 11
        /// 6 13
        /// 7 0
        /// 8 1
        /// 9 5
        /// 10 10
        /// 11 11
        /// 12 14
        /// LCID: Syriac (0x045A)
        /// Format ID Converted value/string
        /// 0 0
        /// 1 1
        /// 2 2
        /// 3 3
        /// 4 4
        /// 5 5
        /// 6 6
        /// 7 7
        /// 8 8
        /// 9 9
        /// 10 10
        /// 11 11
        /// 2 12
        self.index = try dataStream.read()
        
        /// unused (3 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.readBytes(count: 3)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
