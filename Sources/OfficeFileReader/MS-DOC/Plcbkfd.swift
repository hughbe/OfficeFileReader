//
//  Plcbkfd.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.2 Plcbkfd
/// The Plcbkfd structure is a PLC whose data elements are BKFD structures (10 bytes each). Each CP in the PLCBKFD that is not the last CP
/// represents the character position of the start of a bookmark in a Document Part. For every PLCBKFD, there is a corresponding PLCBKLD.
/// Each data element in the PLCBKFD is associated in a one-to-one correlation with a data element in the corresponding PLCBKLD.
/// The CP corresponding to the data element in the PLCBKLD represents the character position of the end of the same bookmark. Constraints
/// upon the CPs inside a PLCBKFD as they relate to the CPs in its corresponding PLCBKLD can be found with the description of PLCFBKF,
/// which shares the same constraints in relation to its corresponding PLCFBKL.
/// The only type of bookmark found in a PLCBKFD is a structured document tag bookmark. When a structured document tag bookmark is created,
/// a character demarcating the start of an arbitrary XML range (see sprmCFSpec) is inserted into the CP stream at the start of the bookmark range.
/// The CP defining the start of a structured document tag bookmark MUST be the offset of that character. As a result, the start CPs of structured
/// document tag bookmarks MUST be unique within their containing PLC.
/// When a structured document tag bookmark is created, a character demarcating the end of an arbitrary XML range (see sprmCFSpec) is inserted
/// into the CP stream at the end of the bookmark range. The CP defining the limit of a structured document tag bookmark MUST be 1 greater than the
/// CP of that character. As a result, the limit CPs of structured document tag bookmarks MUST be unique within their containing PLC, and the CP
/// specifying the start of a structured document tag bookmark MUST be less than the CP specifying the end of the bookmark by at least 2.
/// If the range of text spanned by a structured document tag bookmark’s CPs contains the CP defining the start or end of another structured
/// document tag bookmark, then it MUST contain the entire range of text spanned by that other bookmark. If the range of text spanned by a
/// structured document tag bookmark’s CPs contains content from inside a table and content from outside that table, then it MUST contain the
/// entire table, with possible omission of the table’s final end of cell mark and TTP mark. In such case, the final end of cell and TTP mark MUST
/// be omitted if and only if the structured document tag bookmark’s range does not include text following the table’s final TTP mark.
/// The largest value that a CP marking the start or end of a structured document tag bookmark is allowed to have is the CP representing the end
/// of all document parts.
public struct Plcbkfd: PLC {
    public let aCP: [CP]
    public let aBKFD: [BKFD]

    public var aData: [BKFD] { aBKFD }
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfElements = Self.numberOfDataElements(cbPlc: size, cbData: 10)
        
        /// aCP (variable): An array of CPs, each indicating the start of a bookmark in the document.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfElements + 1))
        for _ in 0..<numberOfElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.aCP = aCP
        
        /// aBKFD (variable): An array of BKFDs (10 bytes each), each of which specifies additional information about the bookmark starting at
        /// the corresponding CP in aCP.
        var aBKFD: [BKFD] = []
        aBKFD.reserveCapacity(Int(numberOfElements))
        for _ in 0..<numberOfElements {
            aBKFD.append(try BKFD(dataStream: &dataStream))
        }
        
        self.aBKFD = aBKFD
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
