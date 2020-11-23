//
//  PGPOptions.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.189 PGPOptions
/// The PGPOptions structure is a variable-sized container of the PGPInfo properties that are to be changed from their default values. The members that are
/// present in the file are indicated by PGPInfo.grfElements.
public struct PGPOptions {
    public let cbOption: UInt16
    public let dxaLeft: UInt32
    public let dxaRight: UInt32
    public let dyaBefore: UInt32
    public let dyaAfter: UInt32
    public let brcLeft: Brc?
    public let brcRight: Brc?
    public let brcTop: Brc?
    public let brcBottom: Brc?
    public let type: UInt16?
    
    public init(dataStream: inout DataStream, grfElements: PGPInfo.Elements) throws {
        /// cbOption (2 bytes): If PGPInfo.grfElements is nonzero, this is the byte size of the remaining PGPOptions data in the file.
        if grfElements != [] {
            self.cbOption = try dataStream.read(endianess: .littleEndian)
        } else {
            self.cbOption = 0
        }
        
        let startPosition = dataStream.position

        /// dxaLeft (4 bytes): If PGPInfo.grfElements & 0x0001 is nonzero, this is the size of the left margin to apply, measured in 1/20 point increments.
        /// Otherwise, the default value of 0 is used.
        if grfElements.contains(.dxaLeftPresent) {
            self.dxaLeft = try dataStream.read(endianess: .littleEndian)
        } else {
            self.dxaLeft = 0
        }

        /// dxaRight (4 bytes): If PGPInfo.grfElements & 0x0002 is nonzero, this is the size of the right margin to apply, measured in 1/20 point increments.
        /// Otherwise, the default value of 0 is used.
        if grfElements.contains(.dxaRightPresent) {
            self.dxaRight = try dataStream.read(endianess: .littleEndian)
        } else {
            self.dxaRight = 0
        }

        /// dyaBefore (4 bytes): If PGPInfo.grfElements & 0x0004 is nonzero, this is the size of the top margin to apply, measured in 1/20 point increments. Otherwise, the default of 0 is used.
        if grfElements.contains(.dyaBeforePresent) {
            self.dyaBefore = try dataStream.read(endianess: .littleEndian)
        } else {
            self.dyaBefore = 0
        }

        /// dyaAfter (4 bytes): If PGPInfo.grfElements & 0x0008 is nonzero, this is the size of the bottom margin to apply, measured in 1/20 point increments. Otherwise, the default value of 0 is used.
        if grfElements.contains(.dyaAfterPresent) {
            self.dyaAfter = try dataStream.read(endianess: .littleEndian)
        } else {
            self.dyaAfter = 0
        }

        /// brcLeft (8 bytes): If PGPInfo.grfElements & 0x0010 is nonzero, this is the Brc that describes the left border of the PGPInfo.
        /// Otherwise, there is no left border.
        if grfElements.contains(.brcLeftPresent) {
            self.brcLeft = try Brc(dataStream: &dataStream)
        } else {
            self.brcLeft = nil
        }

        /// brcRight (8 bytes): If PGPInfo.grfElements & 0x0020 is nonzero, this is the Brc that describes the right border of the PGPInfo.
        /// Otherwise, there is no right border.
        if grfElements.contains(.brcRightPresent) {
            self.brcRight = try Brc(dataStream: &dataStream)
        } else {
            self.brcRight = nil
        }

        /// brcTop (8 bytes): If PGPInfo.grfElements & 0x0040 is nonzero, this is the Brc that describes the top border of the PGPInfo.
        /// Otherwise, there is no top border.
        if grfElements.contains(.brcTopPresent) {
            self.brcTop = try Brc(dataStream: &dataStream)
        } else {
            self.brcTop = nil
        }

        /// brcBottom (8 bytes): If PGPInfo.grfElements & 0x0080 is nonzero, this is the Brc that describes the bottom border of the PGPInfo.
        /// Otherwise, there is no bottom border.
        if grfElements.contains(.brcBottomPresent) {
            self.brcBottom = try Brc(dataStream: &dataStream)
        } else {
            self.brcBottom = nil
        }

        /// type (2 bytes): If PGPInfo.grfElements & 0x0100 is nonzero, this value MUST be 0, 1 or 2. If this value is 1, this PGPInfo is represented as
        /// a <BLOCKQUOTE> element when saved as HTML. If this value is 2, this PGPInfo is represented as a <BODY> element, provided that it is
        /// applied at a point where the <BODY> element is legal in HTML. If this value is not present or is 0, it is assumed that this PGPInfo represents
        /// a <DIV> element.
        if grfElements.contains(.typePresent) {
            self.type = try dataStream.read(endianess: .littleEndian)
            if self.type != 0 && self.type != 1 && self.type != 2 {
                throw OfficeFileError.corrupted
            }
        } else {
            self.type = nil
        }

        if dataStream.position - startPosition != self.cbOption {
            throw OfficeFileError.corrupted
        }
    }
}
