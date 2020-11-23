//
//  grffldEnd.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import Foundation

/// [MS-DOC] 2.9.110 grffldEnd
/// The grffldEnd structure describes the properties of the field.
import DataStream

public struct grffldEnd {
    public let fDiffer: Bool
    public let fZombieEmbed: Bool
    public let fResultsDirty: Bool
    public let fResultsEdited: Bool
    public let fLocked: Bool
    public let fPrivateResult: Bool
    public let fNested: Bool
    public let fHasSep: Bool
    
    public init(dataStream: inout DataStream) throws {
        self.init(rawValue: try dataStream.read())
    }
    
    public init(rawValue: UInt8) {
        var flags = BitFieldReader(rawValue: rawValue)
        
        /// A - fDiffer (1 bit): If this bit is set, the field shows results if the document-level setting is to show field instructions, and shows instructions if
        /// the document-level setting is to show field results.
        self.fDiffer = flags.readBit()
        
        /// B - fZombieEmbed (1 bit): If this bit is set, the field result contains an OLE object, but the field type is not able to generate OLE objects.
        self.fZombieEmbed = flags.readBit()
        
        /// C - fResultsDirty (1 bit): If this bit is set, the field results were either edited or formatted since the last time that an application calculated
        /// the field.
        self.fResultsDirty = flags.readBit()
        
        /// D - fResultsEdited (1 bit): If this bit is set, the field results were edited since the last time that an application calculated the field.
        self.fResultsEdited = flags.readBit()
        
        /// E - fLocked (1 bit): If this bit is set, this field does not recalculate.
        self.fLocked = flags.readBit()
        
        /// F - fPrivateResult (1 bit): If this bit is set, the field result is not intended to be visible to the user.
        self.fPrivateResult = flags.readBit()
        
        /// G - fNested (1 bit): This bit MUST be set if this field is contained in another field.
        self.fNested = flags.readBit()
        
        /// H - fHasSep (1 bit): This bit MUST be set if this field has a separator.
        self.fHasSep = flags.readBit()
    }
}
