//
//  Stshif.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.274 Stshif
/// The Stshif structure specifies general stylesheet information.
public struct Stshif {
    public let cstd: UInt16
    public let cbSTDBaseInFile: UInt16
    public let fStdStylenamesWritten: Bool
    public let fReserved: UInt16
    public let stiMaxWhenSaved: UInt16
    public let istdMaxFixedWhenSaved: UInt16
    public let nVerBuiltInNamesWhenSaved: UInt16
    public let ftcAsci: Int16
    public let ftcFE: Int16
    public let ftcOther: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// cstd (2 bytes): An unsigned integer that specifies the count of elements in STSH.rglpstd. This value MUST be equal to or greater
        /// than 0x000F, and MUST be less than 0x0FFE.
        let cstd: UInt16 = try dataStream.read(endianess: .littleEndian)
        if cstd < 0x000F || cstd > 0x0FFE {
            throw OfficeFileError.corrupted
        }
        
        self.cstd = cstd
        
        /// cbSTDBaseInFile (2 bytes): An unsigned integer that specifies the size, in bytes, of the Stdf structure. The Stdf structure contains
        /// an StdfBase structure that is followed by a StdfPost2000OrNone structure which contains an optional StdfPost2000 structure.
        /// This value MUST be 0x000A when the Stdf structure does not contain an StdfPost2000 structure and MUST be 0x0012 when the
        /// Stdf structure does contain an StdfPost2000 structure.
        let cbSTDBaseInFile: UInt16 = try dataStream.read(endianess: .littleEndian)
        if cbSTDBaseInFile != 0x000A && cbSTDBaseInFile != 0x0012 {
            throw OfficeFileError.corrupted
        }
        
        self.cbSTDBaseInFile = cbSTDBaseInFile
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fStdStylenamesWritten (1 bit): This value MUST be 1 and MUST be ignored.
        self.fStdStylenamesWritten = flags.readBit()
        
        /// fReserved (15 bits): This value MUST be zero and MUST be ignored.
        self.fReserved = flags.readRemainingBits()
        
        /// stiMaxWhenSaved (2 bytes): An unsigned integer that specifies a value that is 1 larger than the largest StdfBase.sti index of any
        /// application-defined style. This SHOULD<242> be equal to the largest sti index that is defined in the application, incremented by 1.
        self.stiMaxWhenSaved = try dataStream.read(endianess: .littleEndian)
        
        /// istdMaxFixedWhenSaved (2 bytes): An unsigned integer that specifies the count of elements at the start of STSH.rglpstd that are
        /// reserved for fixed-index application-defined styles. This value MUST be 0x000F.
        self.istdMaxFixedWhenSaved = try dataStream.read(endianess: .littleEndian)
        if self.istdMaxFixedWhenSaved != 0x000F {
            throw OfficeFileError.corrupted
        }
        
        /// nVerBuiltInNamesWhenSaved (2 bytes): An unsigned integer that specifies the version number of the style names as defined by the
        /// application that writes the file. This value SHOULD<243> be 0.
        self.nVerBuiltInNamesWhenSaved = try dataStream.read(endianess: .littleEndian)
        
        /// ftcAsci (2 bytes): A signed integer that specifies an operand value for the sprmCRgFtc0 for default document formatting, as defined
        /// in the section Determining Formatting Properties.
        self.ftcAsci = try dataStream.read(endianess: .littleEndian)
        
        /// ftcFE (2 bytes): A signed integer that specifies an operand value for the sprmCRgFtc1 for default document formatting, as defined
        /// in the section Determining Formatting Properties.
        self.ftcFE = try dataStream.read(endianess: .littleEndian)
        
        /// ftcOther (2 bytes): A signed integer that specifies an operand value for the sprmCRgFtc2 for default document formatting, as defined
        /// in the section Determining Formatting Properties.
        self.ftcOther = try dataStream.read(endianess: .littleEndian)
    }
}
