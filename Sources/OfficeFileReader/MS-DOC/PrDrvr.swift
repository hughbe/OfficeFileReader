//
//  PrDrvr.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.211 PrDrvr
/// The PrDrvr structure specifies printer driver information. It contains four null-terminated strings of ANSI characters that specify the printer name, the port,
/// the driver, and the product name of the printer.
public struct PrDrvr {
    public let szPrinter: String
    public let szPrPort: String
    public let szPrDriver: String
    public let szTruePrnName: String
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        /// szPrinter (variable): A null-terminated string of ANSI characters that specifies the printer name that is used by the computer or the network.
        self.szPrinter = try dataStream.readAsciiString()!
        
        /// szPrPort (variable): A null-terminated string of ANSI characters that specifies the printer port.
        self.szPrPort = try dataStream.readAsciiString()!
        
        /// szPrDriver (variable): A null-terminated string of ANSI characters that specifies the printer driver.
        self.szPrDriver = try dataStream.readAsciiString()!
        
        /// szTruePrnName (variable): A null-terminated string of ANSI characters that specifies the product name from the printer manufacturer.
        self.szTruePrnName = try dataStream.readAsciiString()!
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
