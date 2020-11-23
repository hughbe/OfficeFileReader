//
//  StwUser.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.298 StwUser
/// The StwUser structure specifies the names and values of the user-defined variables that are stored in the document.
public struct StwUser {
    public let sttbNames: STTB<String>
    public let rgxchValues: [Xst]
    
    public init(dataStream: inout DataStream) throws {
        /// SttbNames (variable): An extended-character STTB that specifies the names of the variables. Each string in this STTB specifies the name of
        /// a variable. The extra data appended to each string in this STTB is a 4-byte unsigned integer that MUST be ignored. Each string in this STTB
        /// MUST be unique. The name "Sign", if it exists, SHOULD<249> specify the VBA digital signature variable. The name "SigAgile", if it exists,
        /// SHOULD<250> specify the VBA digital signature variable.
        /// The SttbNames structure is an STTB structure that has the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0004.
        self.sttbNames = try STTB(dataStream: &dataStream)
        if !self.sttbNames.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttbNames.cbExtra != 0x0004 {
            throw OfficeFileError.corrupted
        }
        
        /// rgxchValues (variable): An array of Xst elements. This array is parallel to SttbNames. Each string in this array specifies the value of the variable
        /// that is named by the corresponding string in SttbNames. The value that corresponds to the "Sign" name string in SttbNames, if it exists,
        /// SHOULD<251> be a special value that specifies the VBA digital signature of the document. The bytes of this value, including the count prefix,
        /// specify a WordSigBlob structure, as specified in [MSOSHARED] section 2.3.2.3. The WordSignBlob MUST have the contentInfo field of the
        /// SignedData structure ([MS-OSHARED] section 2.3.2.4.1) as an SpcIndirectDataContent structure ([MSOSHARED] section 2.3.2.4.3.1). The
        /// value that corresponds to the "SigAgile" name string in SttbNames, if exists, SHOULD<252> be a special value that specifies the VBA digital
        /// signature of the document. The bytes of this value, including the count prefix, specify a WordSigBlob structure, as specified in [MS-OSHARED]
        /// section 2.3.2.3. The WordSignBlob MUST have the contentInfo field of the SignedData structure ([MS-OSHARED] section 2.3.2.4.1) as an
        /// SpcIndirectDataContentV2 structure ([MS-OSHARED] section 2.3.2.4.3.2).
        var rgxchValues: [Xst] = []
        rgxchValues.reserveCapacity(Int(self.sttbNames.cData))
        for _ in 0..<self.sttbNames.cData {
            rgxchValues.append(try Xst(dataStream: &dataStream))
        }
        
        self.rgxchValues = rgxchValues
    }
}
