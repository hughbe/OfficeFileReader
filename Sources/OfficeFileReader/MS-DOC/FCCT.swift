//
//  FCCT.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import Foundation

import DataStream

/// [MS-DOC] 2.9.74 FCCT
/// The FCCT structure specifies information about a format consistency-checker bookmark.
public struct FCCT {
    public let fcctChp: Bool
    public let fcctPap: Bool
    public let fcctTap: Bool
    public let fcctSep: Bool
    public let fcctUnused: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fcctChp (1 bit): A bit field specifying that the character properties associated with the region of text were flagged as inconsistent with
        /// those in other regions of text in the file.
        self.fcctChp = flags.readBit()
        
        /// B - fcctPap (1 bit): A bit field specifying that paragraph properties associated with the region of text were flagged as inconsistent with
        /// those in other regions of text in the file. This bit field MUST be 0.
        self.fcctPap = flags.readBit()
        
        /// C - fcctTap (1 bit): A bit field specifying that table properties associated with the region of text were flagged as inconsistent with those
        /// in other regions of text in the file.
        self.fcctTap = flags.readBit()
        
        /// D - fcctSep (1 bit): A bit field specifying that line-separation properties associated with the region of text were flagged as inconsistent
        /// with those in other regions of text in the file.
        self.fcctSep = flags.readBit()
        
        /// E - fcctUnused (4 bits): This MUST be zero and MUST be ignored. 
        self.fcctUnused = flags.readRemainingBits()
    }
}
