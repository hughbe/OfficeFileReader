//
//  PlcfGlsy.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.194 PlcfGlsy
/// The PlcfGlsy structure is a PLC that contains only CPs and no additional data. The count of CPs in a PlcfGlsy structure MUST be equal to a
/// number that represents the count of strings in the corresponding SttbfGlsy incremented by 2. A PlcfGlsy MUST NOT contain duplicate CPs.
public struct PlcfGlsy: PLC {
    public let aCP: [CP]
    public var aData: [Any] = []

    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfDataElements = Self.numberOfDataElements(cbPlc: size, cbData: 0)
        
        /// aCP (variable): An array of CP. Each CP is an offset into the main document. Each CP MUST be greater than or equal to zero, and MUST
        /// be less than FibRgLw97.ccpText. Each CP specifies the beginning of a range of text that constitutes the contents of an AutoText item.
        /// Each AutoText item corresponds to its respective entry in the parallel AutoText item string table SttbfGlsy. The range of text ends
        /// immediately before the next CP. The last CP MUST be ignored, and the second to last CP does not begin a new text range; it only
        /// terminates the text range that started with the previous CP.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfDataElements + 1))
        for _ in 0..<numberOfDataElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }

        self.aCP = aCP
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
