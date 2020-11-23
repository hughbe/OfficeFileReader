//
//  ToggleOperand.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.327 ToggleOperand
/// The ToggleOperand structure is an operand to an SPRM whose spra is 0 and whose sgc is 2. It modifies a Boolean character property.
public struct ToggleOperand {
    public let value: Value
    
    public init(dataStream: inout DataStream) throws {
        /// value (1 byte): An unsigned integer which MUST be one of the following values.
        let valueRaw: UInt8 = try dataStream.read()
        guard let value = Value(rawValue: valueRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.value = value
    }
    
        /// value (1 byte): An unsigned integer which MUST be one of the following values.
    public enum Value: UInt8 {
        /// 0x00 The Boolean property is set to 0, which means the property is turned OFF.
        case turnOff = 0x00
        
        /// 0x01 The Boolean property is set to 1, which means the property is turned ON.
        case turnOn = 0x01
        
        /// 0x80 The Boolean property is set to match the value of the property in the current style that is applied to the text.
        case matchValueOfPropertyInCurrentStyle = 0x80
        
        /// 0x81 The Boolean property is set to the opposite of the value of the property in the current style that is applied to the text.
        case oppositeValueOfPropertyInCurrentStyle = 0x81
    }
}
