//
//  UpxChpx.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.336 UpxChpx
/// The UpxChpx structure specifies the character formatting properties that differ from the parent style as defined by StdfBase.istdBase.
public struct UpxChpx {
    public let grpprlChpx: [Prl]
    public let padding: UPXPadding

    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position
        
        /// grpprlChpx (variable): An array of Prl elements that specifies character formatting properties.
        /// This array MUST contain only character Sprm structures. However, this array MUST NOT contain any Sprm structure that specifies
        /// a property that is preserved across the application of the sprmCIstd value. Finally, this array MUST NOT contain any of the following:
        /// 1. sprmCFSpecVanish
        /// 2. sprmCIstd
        /// 3. sprmCIstdPermute
        /// 4. sprmCPlain
        /// 5. sprmCMajority
        /// 6. sprmCDispFldRMark
        /// 7. sprmCIdslRMarkDel
        /// 8. sprmCLbcCRJ
        /// 9. sprmCPbiIBullet
        /// 10. sprmCPbiGrf
        /// Additionally, character, paragraph, and list styles MUST NOT contain the sprmCCnf value.
        var grpprlChpx: [Prl] = []
        while dataStream.position - startPosition < size {
            grpprlChpx.append(try Prl(dataStream: &dataStream))
        }
        
        self.grpprlChpx = grpprlChpx

        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
        
        /// padding (variable): A UPXPadding structure that specifies the padding that is required to make the UpxChpx structure an even length.
        self.padding = try UPXPadding(dataStream: &dataStream, startPosition: startPosition)
    }
}
