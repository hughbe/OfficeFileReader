//
//  STD.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.258 STD
/// The STD structure specifies a style definition.
public struct STD {
    public let stdf: Stdf
    public let xstzName: Xstz
    public let grLPUpxSw: GrLPUpxSw
    
    public init(dataStream: inout DataStream, stshif: Stshif, size: Int) throws {
        let startPosition = dataStream.position
        
        /// stdf (variable): An Stdf that specifies basic information about the style.
        self.stdf = try Stdf(dataStream: &dataStream, stshif: stshif)
        
        /// xstzName (variable): An Xstz structure that specifies the primary style name followed by any alternate names (aliases), with meaning
        /// as specified in [ECMA-376] part 4, section 2.7.3.9 (name) and [ECMA-376] part 4, section 2.7.3.1 (aliases). The primary style
        /// name and any alternate style names are combined into one string, with a comma character (U+002C) separating the primary
        /// style name and any alternate style names. If there are no alternate style names, the trailing comma is omitted.
        /// Each name, whether primary or alternate, MUST NOT be empty and MUST be unique within all names in the stylesheet.
        self.xstzName = try Xstz(dataStream: &dataStream)
        
        /// grLPUpxSw (variable): A GrLPUpxSw structure that specifies the formatting for the style.
        let remainingCount = size - (dataStream.position - startPosition)
        self.grLPUpxSw = try GrLPUpxSw(dataStream: &dataStream, stdfBase: self.stdf.stdfBase, size: Int(remainingCount))
    }
}
