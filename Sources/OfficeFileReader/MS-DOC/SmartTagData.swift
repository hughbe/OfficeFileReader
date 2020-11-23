//
//  SmartTagData.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.251 SmartTagData
/// The SmartTagData structure stores information about all the smart tags in the document. The location of each smart tag is specified by the
/// fcPlcfBkfFactoid and lcbPlcfBkfFactoid members of the FibRgFcLcb2002.
public struct SmartTagData {
    public let propBagStore: PropertyBagStore
    public let propBags: [PropertyBag]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition1 = dataStream.position
        
        /// propBagStore (variable): A PropertyBagStore, as specified in [MS-OSHARED] section 2.3.4.1.
        self.propBagStore = try PropertyBagStore(dataStream: &dataStream)
        
        let startPosition2 = dataStream.position
        
        /// propBags (variable): An array of PropertyBag structures, as specified in [MS-OSHARED] section 2.3.4.3. The size of this array, in bytes,
        /// is determined by subtracting the size of propBagStore from the lcbSmartTag member of FibRgFcLcb2002.
        var propBags: [PropertyBag] = []
        while dataStream.position - startPosition2 < size {
            propBags.append(try PropertyBag(dataStream: &dataStream))
        }
        
        self.propBags = propBags
        
        if dataStream.position - startPosition1 != size {
            throw OfficeFileError.corrupted
        }
    }
}
