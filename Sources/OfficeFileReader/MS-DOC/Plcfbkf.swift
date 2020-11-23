//
//  Plcfbkf.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.10 Plcfbkf
/// A PLCFBKF is a PLC whose data elements are FBKF structures (4 bytes each). Each CP in the PLCFBKF that is not the last CP represents the
/// character position of the start of a bookmark in a document part. For every PLCFBKF, there is a corresponding PLCFBKL. Each data element
/// in the PLCFBKF is associated in a one-to-one correlation with a data element in that PLCFBKL, whose corresponding CP represents the
/// character position of the end of the same bookmark.
/// The following constraints apply to CPs in all bookmark PLCs.
/// The last CP in a bookmark PLC MUST have a value that is one greater than the largest CP that a bookmark of the type associated with the PLC
/// is allowed to have and MUST be ignored. Unless otherwise specified by a particular type of bookmark, bookmark PLCs can contain duplicate CPs
/// because bookmarks can overlap. The CP defining the start of a bookmark MUST be less than or equal in value to the CP defining the limit of the
/// bookmark. The range of text spanned by a bookmark’s (1) CPs MUST obey all constraints, excluding those concerning tables, upon valid selections
/// defined in section 2.2.3. The following constraints reference entities defined in section 2.4.3 Overview of Tables. For bookmark types whose
/// BKC.fCol MUST be 0, the following rule 1 MUST apply. Otherwise, the following rule 2 MUST apply:
/// 1. If the range of text spanned by a bookmark’s (1) CPs contains a table cell mark, then its start CP MUST be less than or equal to the CP of
/// the beginning of the cell in question and its limit CP MUST either be one less than the CP of a cell mark in that table, one greater than the CP
/// of a TTP mark in that table, or outside the table. If the range of text spanned by a bookmark’s (1) CPs contains a TTP mark in a table, then its
/// start CP MUST be outside the table, or the first character of a row in the table. If the range of text spanned by a bookmark’s (1) CPs contains a
/// TTP mark in a table, then its limit CP MUST be outside the table, or two less than the CP of a TTP mark in the table, or one greater than the CP
/// of a TTP mark in the table.
/// 2. If the range of text spanned by a bookmark’s (1) CPs contains content from a cell in a table and content from outside that table, then it MUST
/// contain only whole rows of the table containing that cell. If the range of text spanned by a bookmark’s (1) CPs contains a table cell mark or TTP
/// mark, then it MUST NOT span partial rows of the table containing that cell or TTP.
public struct Plcfbkf: PLC {
    public let aCP: [CP]
    public let aFBKF: [FBKF]

    public var aData: [FBKF] { aFBKF }
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfElements = Self.numberOfDataElements(cbPlc: size, cbData: 4)
        
        /// aCP (variable): An array of CPs, each indicating the start of a bookmark (1) in the document.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfElements + 1))
        for _ in 0..<numberOfElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.aCP = aCP
        
        /// aFBKF (variable): An array of FBKFs (4 bytes each), each of which specifies additional information about the bookmark starting at the
        /// corresponding CP in aCP.
        var aFBKF: [FBKF] = []
        aFBKF.reserveCapacity(Int(numberOfElements))
        for _ in 0..<numberOfElements {
            aFBKF.append(try FBKF(dataStream: &dataStream))
        }
        
        self.aFBKF = aFBKF
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
