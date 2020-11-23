//
//  PlcfTch.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.29 PlcfTch
/// The PlcfTch structure is a PLC whose data elements are Tch structures (4 bytes each). The count of CPs MUST be equal to one more than the count of
/// Tch. Each pair of CPs represents a range of text in the main document described by the corresponding Tch.
/// This information is a deprecated cache of table characters that SHOULD<202> be ignored. The following three CPs and the following two Tch structures
/// SHOULD<203> be written to specify that this cache is undefined.
/// CP
/// 0
/// FibRgLw97.ccpText
/// FibRgLw97.ccpText + 2
/// The following specifies the values for the fields of the first Tch structure.
/// Field Value
/// fUnk 0
/// fUnused 0
/// The following specifies the values for the fields of the second Tch structure.
/// Field Value
/// fUnk 1
/// fUnused 0
public struct PlcfTch: PLC {
    public let aCP: [CP]
    public let aTCH: [Tch]

    public var aData: [Tch] { aTCH }

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 4)
        
        /// aCP (variable): An array of CPs. Each CP specifies the beginning of a range of text where a table character cache is stored. The last
        /// CP denotes the end of the last range of text. The range of text ends immediately prior to the next CP. MUST NOT contain duplicate CPs.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        /// aTCH (variable): An array of Tch structures (4 bytes each) that each specifies a table character cache at the corresponding CP in aCP.
        var aTCH: [Tch] = []
        aTCH.reserveCapacity(Int(numberOfDataElements))
        for _ in 0..<numberOfDataElements {
            aTCH.append(try Tch(dataStream: &dataStream))
        }
        
        self.aTCH = aTCH
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
