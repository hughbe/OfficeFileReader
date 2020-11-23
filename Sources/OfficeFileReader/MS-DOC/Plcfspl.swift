//
//  Plcfspl.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.28 Plcfspl
/// The Plcfspl structure is a Plc structure whose data elements are SpellingSpls structures (2 bytes each).
public struct Plcfspl: PLC {
    public let aCP: [CP]
    public let aSpellingSpls: [SpellingSpls]

    public var aData: [SpellingSpls] { aSpellingSpls }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 2)
        
        /// aCP (variable): An array of CPs. CPs are positions in the set of all document parts. CPs are relative to the start of the main document
        /// but can extend into any of the document parts.
        /// Each CP specifies the beginning of a range of text where the state in the corresponding SpellingSpls structure applies. The range of
        /// text ends immediately prior to the next CP.
        /// A Plcfspl can contain duplicate CPs. Duplicate CPs specify an insertion point or a deletion point at that CP and the corresponding
        /// SpellingSpls state applies to that point.
        /// The last CP does not begin a new text range; it only terminates the previous one.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aSpellingSpls (variable): An array of 2-byte SpellingSpls structures. Each SpellingSpls structure contains the state of the spelling
        /// checker for the corresponding text range.
        var aSpellingSpls: [SpellingSpls] = []
        aSpellingSpls.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aSpellingSpls.append(try SpellingSpls(dataStream: &dataStream))
        }
        
        self.aSpellingSpls = aSpellingSpls
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
