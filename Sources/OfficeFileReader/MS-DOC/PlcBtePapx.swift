//
//  PlcBtePapx.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.6 PlcBtePapx
/// The PlcBtePapx structure is a PLC that specifies paragraph, table row, or table cell properties as described later. Where most PLCs map
/// CPs to data, the PlcBtePapx maps stream offsets to data instead. The offsets in aFC partition a portion of the WordDocument stream into
/// adjacent ranges.
/// Consider the collection of paragraphs, table rows, and table cells whose last character occurs at an offset in the WordDocument stream
/// larger than or equal to aFC[i] but smaller than aFC[i+1]. Then, aPnBtePapx[i] specifies the properties of these paragraphs, table rows,
/// or table cells.
/// A PlcBtePapx MUST NOT contain duplicate stream offsets. Each data element of PlcBtePapx is 4 bytes long.
public struct PlcBtePapx: PLC {
    public let aFC: [CP]
    public let aPnBtePapx: [PnFkpPapx]
    
    public var aCP: [CP] { aFC }
    public var aData: [PnFkpPapx] { aPnBtePapx }
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfElements = Self.numberOfDataElements(cbPlc: size, cbData: 4)
        
        /// aFC (variable): An array of unsigned integers. Each element in this array specifies an offset in the WordDocument stream.
        /// The elements of aFC MUST be sorted in ascending order, and there MUST NOT be any duplicate entries.
        var aFC: [CP] = []
        aFC.reserveCapacity(Int(numberOfElements + 1))
        for _ in 0..<numberOfElements + 1 {
            aFC.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.aFC = aFC
        
        /// aPnBtePapx (variable): An array of PnFkpPapx. The ith entry in aPnBtePapx is a PnFkpPapx that specifies the properties of all
        /// paragraphs, table rows, and table cells whose last character occurs at an offset in the WordDocument stream larger than or
        /// equal to aFC[i] but smaller than aFC[i+1]; aPnBtePapx MUST contain one less entry than aFC.
        var aPnBtePapx: [PnFkpPapx] = []
        aPnBtePapx.reserveCapacity(Int(numberOfElements))
        for _ in 0..<numberOfElements {
            aPnBtePapx.append(try PnFkpPapx(dataStream: &dataStream))
        }
        
        self.aPnBtePapx = aPnBtePapx
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
