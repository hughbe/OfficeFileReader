//
//  PlcBteChpx.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.5 PlcBteChpx
/// The PlcBteChpx structure is a PLC that maps the offsets of text in the WordDocument stream to the character properties of that text. Where
/// most PLCs map CPs to data, the PlcBteChpx maps stream offsets to data instead. A PlcBteChpx MUST NOT contain duplicate stream offsets.
public struct PlcBteChpx: PLC {
    public let aFC: [CP]
    public let aPnBteChpx: [PnFkpChpx]
    
    public var aCP: [CP] { aFC }
    public var aData: [PnFkpChpx] { aPnBteChpx }
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        let numberOfElements = Self.numberOfDataElements(cbPlc: size, cbData: 4)
        
        /// aFC (variable): An array of unsigned integers. Each element in this array specifies an offset in the WordDocument stream where
        /// text begins. The end of each range is the beginning of the next range. As with all PLCs, the elements of aFC MUST be sorted
        /// in ascending order.
        var aFC: [CP] = []
        aFC.reserveCapacity(Int(numberOfElements + 1))
        for _ in 0..<numberOfElements + 1 {
            aFC.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.aFC = aFC

        /// aPnBteChpx (variable): An array of PnFkpChpx (4 bytes each). Each element of this array specifies the location in the WordDocument
        /// stream of a ChpxFkp. That ChpxFkp contains the character properties for the text at the corresponding offset in aFC.
        var aPnBteChpx: [PnFkpChpx] = []
        aPnBteChpx.reserveCapacity(Int(numberOfElements))
        for _ in 0..<numberOfElements {
            aPnBteChpx.append(try PnFkpChpx(dataStream: &dataStream))
        }
        
        self.aPnBteChpx = aPnBteChpx
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
