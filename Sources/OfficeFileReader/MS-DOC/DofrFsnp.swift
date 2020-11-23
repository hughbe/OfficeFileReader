//
//  DofrFsnp.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.59 DofrFsnp
/// The DofrFsnp structure marks the beginning or end of a group of child frames. In the first marker, fPush is set to "true"; in the ending marker,
/// fPush is set to "false". The enclosed child frames belong to the frame associated with the record that appears immediately before the DofrFsnp,
/// with fPush set to "true".
/// DofrFsnp records can be nested. While loading the child nodes of frame A there appears another DofrFsnp with fPush set to "true". This means
/// that the most recently loaded child record B does have child nodes. All the nodes between that DofrFsnp and the corresponding DofrFsnp with
/// fPush set to "false" are the child nodes of frame B. This is how frame records support an arbitrary level of nesting within the frame set.
/// DofrFsnp records MUST be equally matched. There MUST be as many records with fPush set to "false" as there are records with fPush set to "true".
public struct DofrFsnp {
    public let fPush: Bool
    public let fUnused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fPush (1 bit): Specifies if this marker indicates the beginning or end of a group of frames. A value of 1 specifies the beginning of a
        /// set of child frames. A value of 0 specifies the end of the child frames.
        self.fPush = flags.readBit()
        
        /// fUnused (31 bits): This value is unused and MUST be ignored.
        self.fUnused = flags.readRemainingBits()
    }
}
