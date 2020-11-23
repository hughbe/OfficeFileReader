//
//  FixedPoint.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.2.1.6 FixedPoint
/// Specifies an approximation of a real number, where the approximation has a fixed number of digits after the radix point.
/// Value of the real number = Integral + (Fractional / 65536.0)
public struct FixedPoint {
    public let integral: UInt16
    public let fractional: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// Integral (2 bytes): A signed integer that specifies the integral part of the real number.
        self.integral = try dataStream.read(endianess: .littleEndian)
        
        /// Fractional (2 bytes): An unsigned integer that specifies the fractional part of the real number.
        self.fractional = try dataStream.read(endianess: .littleEndian)
    }
    
    public var value: Double {
        return Double(integral) + (Double(fractional) / 65536.0)
    }
}
