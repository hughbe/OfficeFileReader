//
//  OfficeArtClientTextboxPpt.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.76 OfficeArtClientTextbox
/// A container record that specifies text related data for a shape.
public struct OfficeArtClientTextboxPpt {
    public let rh: OfficeArtRecordHeader
    public let rgChildRec: [TextClientDataSubContainerOrAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader ([MS-ODRAW] section 2.2.1) that specifies the header for this record. Sub-fields are further
        /// specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be 0xF00D.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        // NOTE: the specification is wrong. Should be 0xF
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF00D else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgChildRec (variable): An array of TextClientDataSubContainerOrAtom records that specifies textrelated data. The size, in bytes, of the
        /// array is specified by rh.recLen. The sequence of the rh.recType fields of the array items MUST be a valid OfficeArtClientTextBoxAtoms
        /// as specified in the following ABNF (specified in [RFC5234]) grammar:
        var textCount: Int = 0
        var rgChildRec: [TextClientDataSubContainerOrAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let childRec = try TextClientDataSubContainerOrAtom(dataStream: &dataStream, textCount: textCount)
            rgChildRec.append(childRec)
            if case let .textBytesAtom(data: atom) = childRec {
                textCount = atom.textBytes.count
            }
            if case let .textCharsAtom(data: atom) = childRec {
                textCount = atom.textChars.count
            }
        }
        
        self.rgChildRec = rgChildRec
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
