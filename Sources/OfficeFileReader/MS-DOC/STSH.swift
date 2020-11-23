//
//  STSH.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.271 STSH
/// The STSH structure specifies the stylesheet for a document. The stylesheet describes the styles that are available within a document as well
/// as their formatting.
/// An istd is an index into rglpstd that is used to reference a particular style definition. The istd values are used internally within the stylesheet,
/// such as in the istdBase member of the StdfBase structure, as well as externally outside the stylesheet, such as in Sprm structures such as
/// sprmPIstd. An istd value MUST be greater than or equal to 0x0000 and less than 0x0FFE.
/// Each FIB MUST contain a stylesheet.
public struct STSH {
    public let lpstshi: LPStshi
    public let rglpstd: [LpStd]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        /// lpstshi (variable): An LPStshi that specifies information about the stylesheet.
        self.lpstshi = try LPStshi(dataStream: &dataStream)
        
        /// rglpstd (variable): An array of LPStd that specifies the style definitions.
        /// The beginning of the rglpstd array is reserved for specific "fixed-index" application-defined styles.
        /// A particular fixed-index, application-defined style has the same istd value in every stylesheet. The rglpstd MUST contain an
        /// LPStd for each of these fixed-index styles and the order MUST match the order in the following table.
        /// istd sti of application-defined style (see sti in StdfBase)
        /// 0 0
        /// 1 1
        /// 2 2
        /// 3 3
        /// 4 4
        /// 5 5
        /// 6 6
        /// 7 7
        /// 8 8
        /// 9 9
        /// 10 65
        /// 11 105
        /// 12 107
        /// 13 Reserved for future use
        /// 14 Reserved for future use
        /// A style is "empty" if the cbStd member of the LPStd is 0. The fixed-index styles from istd 0 to 12
        /// MAY<241> be empty, while those from istd 13 to 14 MUST be empty.
        var rglpstd: [LpStd] = []
        while dataStream.position - startPosition < size {
            rglpstd.append(try LpStd(dataStream: &dataStream, stshif: self.lpstshi.stshi.stshif))
        }
        
        self.rglpstd = rglpstd
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
