//
//  PlcfSed.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.26 PlcfSed
/// The PlcfSed structure is a PLC structure where the data elements are Sed structures (12 bytes each).
public struct PlcfSed: PLC {
    public let aCP: [CP]
    public let aSed: [Sed]

    public var aData: [Sed] { aSed }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 12)
        
        /// aCP (variable): An array of CPs. Each CP specifies the beginning of a range of text in the main document that constitutes a section.
        /// The range of text ends immediately prior to the next CP. A PlcfSed MUST NOT contain duplicate CPs. There MUST also be an
        /// end-of-section character (0x0C) as the final character in the text range of all but the last section. An end-of-section character (0x0C)
        /// which occurs at a CP and which is not the last character in a section specifies a manual page break.
        /// The last CP does not begin a new section. It MUST be at or beyond the end of the main document. Sections only contain text from
        /// the main document, so even when the last CP comes after text in other document parts, that text is not part of the last section.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aSed (variable): An array of 12-byte Sed structures. Each Sed structure contains the location of properties pertaining to the section
        /// that begins at the corresponding CP.
        var aSed: [Sed] = []
        aSed.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aSed.append(try Sed(dataStream: &dataStream))
        }
        
        self.aSed = aSed
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
