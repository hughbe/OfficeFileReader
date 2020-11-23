//
//  FNPI.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.93 FNPI
/// The FNPI structure contains a type and an identifier for a file name. This structure can be used to define the type and identifier of a file name in
/// SttbFnm, or it can be used to reference the file name in SttbFnm that has an identical fnpi in the appended FNIF. The definition of each FNPI
/// specifies how it is used.
public struct FNPI {
    public let fnpt: FileNameType
    public let fnpd: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// fnpt (4 bits): A signed integer that specifies the type of a file name. This MUST be one of the following values.
        let fnptRaw = UInt8(flags.readBits(count: 4))
        guard let fnpt = FileNameType(rawValue: fnptRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.fnpt = fnpt
        
        /// fnpd (12 bits): A signed integer that specifies an identifier for a file name. This value MUST NOT be 0xFFF.
        self.fnpd = flags.readRemainingBits()
        if self.fnpd == 0xFFF {
            throw OfficeFileError.corrupted
        }
    }
    
    /// fnpt (4 bits): A signed integer that specifies the type of a file name. This MUST be one of the following values.
    public enum FileNameType: UInt8 {
        /// 3 The file name refers to a mail merge data source file. This document MUST be a mail merge document.
        case mailMergeDataSourceFile = 3
        
        /// 5 The file name refers to a subdocument. This document MUST be a master document.
        case subdocument = 5
    }
}
