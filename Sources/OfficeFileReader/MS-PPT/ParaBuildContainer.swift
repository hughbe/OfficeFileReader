//
//  ParaBuildContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.6 ParaBuildContainer
/// Referenced by: BuildListSubContainer
/// A container record that specifies the build information for text paragraphs in a shape.
public struct ParaBuildContainer {
    public let rh: RecordHeader
    public let buildAtom: BuildAtom
    public let paraBuildAtom: ParaBuildAtom
    public let rgParaBuildLevel: [ParaBuildLevel]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_ParaBuild.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .paraBuild else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// buildAtom (24 bytes): A BuildAtom record that specifies the information for the build.
        self.buildAtom = try BuildAtom(dataStream: &dataStream)
        
        /// paraBuildAtom (24 bytes): A ParaBuildAtom record that specifies the information for the paragraph build.
        self.paraBuildAtom = try ParaBuildAtom(dataStream: &dataStream)
        
        /// rgParaBuildLevel (variable): An array of ParaBuildLevel that specifies the template effects for the text. If paraBuildAtom.paraBuild is
        /// TLPB_AsAWhole, rgParaBuildLevel MUST contain one and only one ParaBuildLevel that specifies the template effects for the text.
        /// Otherwise, rgParaBuildLevel MUST contain the same number of ParaBuildLevel items as the number of paragraph levels in the shape,
        /// ordered from level 1 to the biggest level. Each ParaBuildLevel item in the array specifies the template effects for a paragraph level in the text.
        var rgParaBuildLevel: [ParaBuildLevel] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgParaBuildLevel.append(try ParaBuildLevel(dataStream: &dataStream))
        }
        
        self.rgParaBuildLevel = rgParaBuildLevel
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
