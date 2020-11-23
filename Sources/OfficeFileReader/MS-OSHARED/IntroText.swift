//
//  IntroText.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.19 IntroText
/// Specifies the text of the introduction for the document when sent as an email message.
public struct IntroText {
    public let introTextSize: UInt32
    public let introText: String
    
    public init(dataStream: inout DataStream) throws {
        /// IntroTextSize (4 bytes): An unsigned integer that specifies the size, in bytes, of IntroText. MUST be evenly divisible by two.
        self.introTextSize = try dataStream.read(endianess: .littleEndian)
        
        /// IntroText (variable): A Unicode character array that specifies the introduction text.
        self.introText = try dataStream.readString(count: Int(self.introTextSize), encoding: .utf16LittleEndian)!
    }
}
