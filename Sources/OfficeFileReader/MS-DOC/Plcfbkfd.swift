//
//  Plcfbkfd.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.8.11 Plcfbkfd
/// The Plcfbkfd structure is a PLC whose data elements are FBKFD structures (6 bytes each). Each CP in the PLCFBKFD, with the exception of the
/// last CP, represents the character position of the start of a bookmark in a document part. For every PLCFBKFD, there is a corresponding PLCFBKLD.
/// Each data element in the PLCFBKFD is associated in a one-to-one correlation with a data element in that PLCFBKLD, whose corresponding CP
/// represents the character position of the end of the same bookmark. Constraints on the CPs inside a PLCFBKFD as they relate to the CPs in its
/// corresponding PLCFBKLD can be found in the description of PLCFBKF, which shares the same constraints in relation to its corresponding PLCFBKL.
/// The only types of bookmark found in a PLCFBKFD are format consistency-checker bookmarks and smart tag bookmarks. The largest value that a
/// CP marking the start or end of a format consistencychecker bookmark or a smart tag bookmark is allowed to have is the CP representing the end of all document parts.
public struct Plcfbkfd: PLC {
    public let aCP: [CP]
    public let aFBKFD: [FBKFD]

    public var aData: [FBKFD] { aFBKFD }
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        if size < 4 {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        let numberOfElements = Self.numberOfDataElements(cbPlc: size, cbData: 6)
        
        /// aCP (variable): An array of CPs. Each CP in the array indicates the start of a bookmark in the document.
        var aCP: [CP] = []
        aCP.reserveCapacity(Int(numberOfElements + 1))
        for _ in 0..<numberOfElements + 1 {
            aCP.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.aCP = aCP
        
        /// aFBKFD (variable): An array of FBKFDs (6 bytes each), each of which specifies additional information about the bookmark starting
        /// at the corresponding CP in aCP.
        var aFBKFD: [FBKFD] = []
        aFBKFD.reserveCapacity(Int(numberOfElements))
        for _ in 0..<numberOfElements {
            aFBKFD.append(try FBKFD(dataStream: &dataStream))
        }
        
        self.aFBKFD = aFBKFD
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
