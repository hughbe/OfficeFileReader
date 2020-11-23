//
//  Plcfld.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.25 Plcfld
/// The Plcfld structure is a PLC whose data elements are Flds (2 bytes each). It specifies the location of fields in the document.
/// A field consists of two parts: field instructions and, optionally, a result. All fields MUST begin with Unicode character 0x0013 with sprmCFSpec
/// applied with a value of 1. This is the field begin character. All fields MUST end with a Unicode character 0x0015 with sprmCFSpec applied with
/// a value of 1. This is the field end character. If the field has a result, then there MUST be a Unicode character 0x0014 with sprmCFSpec applied
/// with a value of 1 somewhere between the field begin character and the field end character. This is the field separator. The field result is the
/// content between the field separator and the field end character. The field instructions are the content between the field begin character and
/// the field separator, if one is present, or between the field begin character and the field end character if no separator is present. The field begin
/// character, field end character, and field separator are collectively referred to as field characters.
/// The field instructions and field result MUST each be a valid selection.
/// The CPs of a PlcFld specify the location of the field characters. A PlcFld MUST NOT contain duplicate CPs. Each document part has its own
/// PlcFld, with CPs relative to the start of that document part.
/// The last CP in aCP does not specify the location of a field character. Because a PlcFld is a PLC, aCP MUST be sorted. Because aCP MUST NOT
/// contain duplicate CPs, the last CP MUST be the largest in aCP. Other than those constraints, the last CP in aCP is undefined and MUST be ignored.
/// The Flds MUST be arranged such that the sequence of Fld.fldch.ch is a valid FieldList according to the following Augmented Backus-Naur Form
/// (ABNF) rulelist. ABNF is specified in [RFC4234].
/// Begin = 0x13
/// Sep = 0x14
/// End = 0x15
/// Field = <Begin> *<Field> [Sep] *<Field> <End>
/// FieldList = *<Field>
/// Additionally, the field characters of the following five field types MUST NOT appear in aFld.
/// 1. XE, as specified in [ECMA-376] Part 4, Section 2.16.5.79
/// 2. TC, as specified in [ECMA-376] Part 4, Section 2.16.5.70
/// 3. RD, as specified in [ECMA-376] Part, Section 2.16.5.57
/// 4. TA, as specified in [ECMA-376] Part, Section 2.16.5.79
/// 5. PRIVATE, as specified in [ECMA-376] Part 4, Section 2.16.5.55
public struct Plcfld: PLC {
    public let aCP: [CP]
    public let aFld: [LadSpls]

    public var aData: [LadSpls] { aFld }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 2)
        
        /// aCP (variable): An array of CPs. Specifies the positions of field characters in the document.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aFld (variable): An array of Fld. Specifies properties for the field character at the corresponding CP. Fldch.ch of each Fld MUST be equal
        /// to the character at the corresponding CP.
        var aFld: [LadSpls] = []
        aFld.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aFld.append(try LadSpls(dataStream: &dataStream))
        }
        
        self.aFld = aFld
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
