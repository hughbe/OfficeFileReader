//
//  Prl.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.2.5.2 Prl
/// The Prl structure is a Sprm that is followed by an operand. The Sprm specifies a property to modify, and the operand specifies the new value.
public struct Prl {
    public let sprm: Sprm
    public let operand: [UInt8]
    
    public var operandDataStream: DataStream { DataStream(operand) }
    
    public init(dataStream: inout DataStream) throws {
        /// sprm (2 bytes): A Sprm which specifies the property to be modified.
        self.sprm = try Sprm(dataStream: &dataStream)
        
        /// operand (variable): A variable-length operand for the sprm. The size of the operand is specified by sprm.spra. The meaning of the
        /// operand depends on the sprm, see section 2.6 (Single Property Modifiers).
        /// Spra Meaning
        /// 0 Operand is a ToggleOperand (which is 1 byte in size).
        /// 1 Operand is 1 byte.
        /// 2 Operand is 2 bytes.
        /// 3 Operand is 4 bytes.
        /// 4 Operand is 2 bytes.
        /// 5 Operand is 2 bytes.
        /// 6 Operand is of variable length. The first byte of the operand indicates the size of the rest of the operand, except in the cases of
        /// sprmTDefTable and sprmPChgTabs.
        /// 7 Operand is 3 bytes.
        let size: Int
        switch self.sprm.spra {
        case 0:
            size = 1
        case 1:
            size = 1
        case 2:
            size = 2
        case 3:
            size = 4
        case 4:
            size = 2
        case 5:
            size = 2
        case 6:
            let sizeRaw: UInt8 = try dataStream.read()
            size = Int(sizeRaw)
        case 7:
            size = 3
        default:
            throw OfficeFileError.corrupted
        }
        self.operand = try dataStream.readBytes(count: size)
    }
    
    public init(sprm: Sprm, operand: [UInt8]) {
        self.sprm = sprm
        self.operand = operand
    }
}
