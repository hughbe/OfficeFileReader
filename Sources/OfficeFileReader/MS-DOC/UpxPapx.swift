//
//  UpxPapx.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.338 UpxPapx
/// The UpxPapx structure specifies the paragraph formatting properties that differ from the parent style, as defined by StdfBase.istdBase.
public struct UpxPapx {
    public let istd: UInt16?
    public let grpprlPapx: [Prl]?
    public let padding: UPXPadding
    
    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position
        
        if size >= 2 {
            /// istd (2 bytes): An unsigned integer that specifies the istd value of the paragraph style. The istd value MUST be equal to the
            /// current style.
            self.istd = try dataStream.read(endianess: .littleEndian)
            
            /// grpprlPapx (variable): An array of Prl elements that specify paragraph formatting properties. This array MUST contain only
            /// paragraph Sprm structures. List styles MUST contain only the sprmPIlfo value.
            /// Paragraph and table styles MUST NOT contain any Sprm structure that specifies a property that is preserved across the application
            /// of the sprmPIstd value. Additionally, paragraph and table styles MUST NOT contain any of the following:
            ///  sprmPIstd
            ///  sprmPIstdPermute
            ///  sprmPIncLvl
            ///  sprmPNest80
            ///  sprmPChgTabs
            ///  sprmPDcs
            ///  sprmPHugePapx
            ///  sprmPFInnerTtp
            ///  sprmPFOpenTch
            ///  sprmPNest
            ///  sprmPFNoAllowOverlap
            ///  sprmPIstdListPermute
            ///  sprmPTableProps
            ///  sprmPTIstdInfo
            /// Additionally, paragraph styles MUST NOT contain sprmPCnf.
            var grpprlPapx: [Prl] = []
            let remainingCount = size - 2
            while dataStream.position - startPosition < remainingCount {
                grpprlPapx.append(try Prl(dataStream: &dataStream))
            }
            
            self.grpprlPapx = grpprlPapx
        } else {
            self.istd = nil
            self.grpprlPapx = nil
        }

        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
        
        /// padding (variable): A UPXPadding value that specifies the padding that is required to make the UpxPapx structure an even length.
        self.padding = try UPXPadding(dataStream: &dataStream, startPosition: startPosition)
    }
}
