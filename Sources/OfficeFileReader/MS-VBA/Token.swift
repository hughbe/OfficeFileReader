//
//  Token.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

public protocol Token {
    init(dataStream: inout DataStream) throws
    func decompress(to: inout [UInt8])
}
