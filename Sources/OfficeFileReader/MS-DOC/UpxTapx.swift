//
//  UpxTapx.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.340 UpxTapx
/// The UpxTapx structure specifies the table formatting properties that differ from the parent style, as defined by the StdfBase.istdBase value.
public struct UpxTapx {
    public let grpprlTapx: [Prl]
    public let padding: UPXPadding
    
    public init(dataStream: inout DataStream, size: Int) throws {
        let startPosition = dataStream.position
        
        /// grpprlTapx (variable): An array of Prl elements that specify table formatting properties. This array MUST contain only table Sprm
        /// structures.
        /// Any sprmTIstd value that is contained in the array MUST be ignored.
        /// This array MUST NOT contain the sprmTWidthBefore value, except when specifying the table formatting properties for the table
        /// style with an istd of 0x000B, which MUST contain a sprmTWidthBefore value with an FtsWWidth_TablePart operand that specifies
        /// a ftsWidth of ftsDxa (0x03) and a wWidth of zero.
        /// Additionally, this array MUST NOT contain any Sprm structure that specifies a property that is preserved across the application of
        /// the sprmTIstd value.
        /// Finally, this array MUST NOT contain any of the following:
        /// 1. sprmTDxaLeft
        /// 2. sprmTDefTable
        /// 3. sprmTDefTableShd80
        /// 4. sprmTDefTableShd3rd
        /// 5. sprmTDefTableShd
        /// 6. sprmTDefTableShd2nd
        /// 7. sprmTWidthAfter
        /// 8. sprmTFKeepFollow
        /// 9. sprmTBrcTopCv
        /// 10. sprmTBrcLeftCv
        /// 11. sprmTBrcBottomCv
        /// 12. sprmTBrcRightCv
        /// 13. sprmTSetBrc80
        /// 14. sprmTInsert
        /// 15. sprmTDelete
        /// 16. sprmTDxaCol
        /// 17. sprmTMerge
        /// 18. sprmTSplit
        /// 19. sprmTTextFlow
        /// 20. sprmTVertMerge
        /// 21. sprmTVertAlign
        /// 22. sprmTSetBrc
        /// 23. sprmTCellPadding
        /// 24. sprmTCellWidth
        /// 25. sprmTFitText
        /// 26. sprmTFCellNoWrap
        /// 27. sprmTCellFHideMark
        /// 28. sprmTSetShdTable
        /// 29. sprmTCellBrcType
        /// 30. sprmTFBiDi90
        /// 31. sprmTFNoAllowOverlap
        /// 32. sprmTIpgp
        /// 33. sprmTDefTableShdRaw
        /// 34. sprmTDefTableShdRaw2nd
        /// 35. sprmTDefTableShdRaw3rd
        /// 36. sprmTCellBrcTopStyle (except within a sprmTCnf)
        /// 37. sprmTCellBrcBottomStyle (except within a sprmTCnf)
        /// 38. sprmTCellBrcLeftStyle (except within a sprmTCnf)
        /// 39. sprmTCellBrcRightStyle (except within a sprmTCnf)
        /// 40. sprmTCellBrcInsideHStyle (except within a sprmTCnf)
        /// 41. sprmTCellBrcInsideVStyle (except within a sprmTCnf)
        var grpprlTapx: [Prl] = []
        while dataStream.position - startPosition < size {
            grpprlTapx.append(try Prl(dataStream: &dataStream))
        }
        
        self.grpprlTapx = grpprlTapx
        
        /// padding (variable): A UPXPadding value that specifies the padding that is required to make UpxTapx an even length.
        self.padding = try UPXPadding(dataStream: &dataStream, startPosition: startPosition)
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
