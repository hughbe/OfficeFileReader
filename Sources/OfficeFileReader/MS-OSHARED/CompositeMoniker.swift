//
//  CompositeMoniker.swift
//  
//
//  Created by Hugh Bellamy on 10/11/2020.
//

import DataStream

/// [MS-DOC] 2.3.7.3 CompositeMoniker
/// Referenced by: HyperlinkMoniker
/// This structure specifies a composite moniker. A composite moniker is a collection of arbitrary monikers. For more information about composite
/// monikers see [MSDN-IMGCMI].
public struct CompositeMoniker {
    public let cMonikers: UInt32
    public let monikerArray: [HyperlinkMoniker]
    
    public init(dataStream: inout DataStream) throws {
        /// cMonikers (4 bytes): An unsigned integer that specifies the count of monikers in monikerArray.
        self.cMonikers = try dataStream.read(endianess: .littleEndian)
        
        /// monikerArray (variable): An array of HyperlinkMonikers (section 2.3.7.2). Each array element specifies a moniker of arbitrary type.
        var monikerArray: [HyperlinkMoniker] = []
        monikerArray.reserveCapacity(Int(self.cMonikers))
        for _ in 0..<self.cMonikers {
            monikerArray.append(try HyperlinkMoniker(dataStream: &dataStream))
        }
        
        self.monikerArray = monikerArray
    }
}
