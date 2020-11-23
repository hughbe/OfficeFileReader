//
//  ShapeDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.18 ShapeDiffContainer
/// Referenced by: ShapeListDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to a shape.
public struct ShapeDiffContainer {
    public let rhs: DiffRecordHeaders
    public let addShape: Bool
    public let deleteShape: Bool
    public let child: Bool
    public let position: Bool
    public let recolorInfo: Bool
    public let externalObject: Bool
    public let interactiveInfoOnOver: Bool
    public let interactiveInfoOnClick: Bool
    public let reserved1: Bool
    public let msopsid3DSettings: Bool
    public let msopsidBWSettings: Bool
    public let msopsidAutoShape: Bool
    public let msopsidLineStyle: Bool
    public let msopsidFillStyle: Bool
    public let msopsidShadowStyle: Bool
    public let msopsidWordArt: Bool
    public let msopsidPicture: Bool
    public let msopsidOrientation: Bool
    public let msopsidTextSetting: Bool
    public let reserved2: Bool
    public let msopsidSize: Bool
    public let reserved3: Bool
    public let ruler: Bool
    public let reserved4: Bool
    public let textDiff: TextDiffContainer?
    public let recolorInfoDiff: RecolorInfoDiffContainer?
    public let externalObjDiff: ExternalObjectDiffContainer?
    public let clickInteractiveInfoDiff: InteractiveInfoDiffContainer?
    public let overInteractiveInfoDiff: InteractiveInfoDiffContainer?
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_ShapeDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .shapeDiff else {
            throw OfficeFileError.corrupted
        }

        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - addShape (1 bit): A bit that specifies whether the addition of the corresponding shape made by the reviewer in the corresponding slide
        /// or corresponding main master slide is not displayed.
        self.addShape = flags.readBit()
        
        /// B - deleteShape (1 bit): A bit that specifies whether the deletion of the corresponding shape made by the reviewer in the corresponding
        /// slide or corresponding main master slide is not displayed.
        self.deleteShape = flags.readBit()
        
        /// C - child (1 bit): A bit that specifies whether the change made by the reviewer to the set of child shapes of the corresponding shape is not
        /// displayed. MUST be ignored if the shapeProp.fGroup field of the OfficeArtSpContainer record ([MSODRAW] section 2.2.14) is FALSE.
        self.child = flags.readBit()
        
        /// D - position (1 bit): A bit that specifies whether the change made by the reviewer to the position of the corresponding shape in the
        /// OfficeArtDgContainer record ([MS-ODRAW] section 2.2.13 ) is not displayed.
        self.position = flags.readBit()
        
        /// E - recolorInfo (1 bit): A bit that specifies whether the changes made by the reviewer to the RecolorInfoAtom record contained within the
        /// corresponding shape are not displayed.
        self.recolorInfo = flags.readBit()
        
        /// F - externalObject (1 bit): A bit that specifies whether the changes made by the reviewer to the corresponding external object referenced
        /// from within the corresponding shape is not displayed.
        /// Let the corresponding external object be an external object that is specified by either the ExMediaAtom record (section 2.10.6) or the
        /// ExOleObjAtom record (section 2.10.12) whose exObjId field equals the exObjIdRef field of ExObjRefAtom record contained within the
        /// corresponding shape.
        self.externalObject = flags.readBit()
        
        /// G - interactiveInfoOnOver (1 bit): A bit that specifies whether the changes made by the reviewer to the MouseOverInteractiveInfoContainer
        /// record contained within the corresponding shape are not displayed.
        self.interactiveInfoOnOver = flags.readBit()
        
        /// H - interactiveInfoOnClick (1 bit): A bit that specifies whether the changes made by the reviewer to the MouseClickInteractiveInfoContainer
        /// record contained within the corresponding shape are not displayed.
        self.interactiveInfoOnClick = flags.readBit()
        
        /// I - reserved1 (1 bit): MUST be zero and MUST be ignored.
        self.reserved1 = flags.readBit()
        
        /// J - msopsid3DSettings (1 bit): A bit that specifies whether the changes made by the reviewer to the 3D object ([MS-ODRAW] section 2.3.15),
        /// 3D Style ([MS-ODRAW] section 2.3.16), and perspective style ([MS-ODRAW] section 2.3.14) properties of the corresponding shape are not
        /// displayed.
        self.msopsid3DSettings = flags.readBit()
        
        /// K - msopsidBWSettings (1 bit): A bit that specifies whether the changes made by the reviewer to the bWMode ([MS-ODRAW] section 2.3.2.3),
        /// bWModePureBW ([MS-ODRAW] section 2.3.2.4), and bWModeBW ([MS-ODRAW] section 2.3.2.5) properties of the corresponding shape
        /// are not displayed.
        self.msopsidBWSettings = flags.readBit()
        
        /// L - msopsidAutoShape (1 bit): A bit that specifies whether the changes made by the reviewer to the shape type in the OfficeArtFSP record
        /// ([MS-ODRAW] section 2.2.40) and the callout ([MSODRAW] section 2.3.3) properties of the corresponding shape are not displayed.
        self.msopsidAutoShape = flags.readBit()
        
        /// M - msopsidLineStyle (1 bit): A bit that specifies whether the changes made by the reviewer to the line style properties ([MS-ODRAW]
        /// section 2.3.8) of the corresponding shape are not displayed.
        self.msopsidLineStyle = flags.readBit()
        
        /// N - msopsidFillStyle (1 bit): A bit that specifies whether the changes made by the reviewer to the fill style properties ([MS-ODRAW] section
        /// 2.3.7) of the corresponding shape are not displayed.
        self.msopsidFillStyle = flags.readBit()
        
        /// O - msopsidShadowStyle (1 bit): A bit that specifies whether the changes made by the reviewer to the shadow style properties
        /// ([MS-ODRAW] section 2.3.13) of the corresponding shape are not displayed.
        self.msopsidShadowStyle = flags.readBit()
        
        /// P - msopsidWordArt (1 bit): A bit that specifies whether the changes made by the reviewer to the geometry text properties ([MS-ODRAW]
        /// section 2.3.22) of the corresponding shape are not displayed.
        self.msopsidWordArt = flags.readBit()
        
        /// Q - msopsidPicture (1 bit): A bit that specifies whether the changes made by the reviewer to the blip properties ([MS-ODRAW] section 2.3.23)
        /// of the corresponding shape are not displayed.
        self.msopsidPicture = flags.readBit()
        
        /// R - msopsidOrientation (1 bit): A bit that specifies whether the changes made by the reviewer to the transform properties ([MS-ODRAW]
        /// section 2.3.18 and [MS-ODRAW] section 2.3.19) of the corresponding shape are not displayed.
        self.msopsidOrientation = flags.readBit()
        
        /// S - msopsidTextSetting (1 bit): A bit that specifies whether the changes made by the reviewer to the text properties ([MS-ODRAW] section
        /// 2.3.21) of the corresponding shape are not displayed.
        self.msopsidTextSetting = flags.readBit()
        
        /// T - reserved2 (1 bit): MUST be zero and MUST be ignored.
        self.reserved2 = flags.readBit()
        
        /// U - msopsidSize (1 bit): A bit that specifies whether the changes made by the reviewer to the OfficeArtClientAnchor record contained within
        /// the corresponding shape are not displayed.
        self.msopsidSize = flags.readBit()
        
        /// V - reserved3 (1 bit): MUST be zero and MUST be ignored.
        self.reserved3 = flags.readBit()
        
        /// W - ruler (1 bit): A bit that specifies whether the changes made by the reviewer to the TextRulerAtom record of the OfficeArtClientTextbox
        /// record contained within the corresponding shape are not displayed.
        self.ruler = flags.readBit()
        
        /// reserved4 (9 bits): MUST be zero and MUST be ignored.
        self.reserved4 = flags.readBit()
        
        /// textDiff (32 bytes): An optional TextDiffContainer record that specifies how to display the changes made by the reviewer to the
        /// OfficeArtClientTextbox record contained within the corresponding shape.
        self.textDiff = try TextDiffContainer(dataStream: &dataStream)
        
        /// recolorInfoDiff (32 bytes): An optional RecolorInfoDiffContainer record that specifies how to display the changes made by the reviewer to the
        /// RecolorInfoAtom record contained within the corresponding shape.
        self.recolorInfoDiff = try RecolorInfoDiffContainer(dataStream: &dataStream)
        
        /// externalObjDiff (32 bytes): An optional ExternalObjectDiffContainer record that specifies how to display the changes made by the reviewer to
        /// the external object referenced from within the corresponding shape.
        self.externalObjDiff = try ExternalObjectDiffContainer(dataStream: &dataStream)
        
        /// clickInteractiveInfoDiff (32 bytes): An optional InteractiveInfoDiffContainer record that specifies how to display the changes made by the
        /// reviewer to the MouseClickInteractiveInfoContainer record contained within the corresponding shape.
        self.clickInteractiveInfoDiff = try InteractiveInfoDiffContainer(dataStream: &dataStream)
        
        /// overInteractiveInfoDiff (32 bytes): An optional InteractiveInfoDiffContainer record that specifies how to display the changes made by the
        /// reviewer to the MouseOverInteractiveInfoContainer record contained within the corresponding shape.
        self.overInteractiveInfoDiff = try InteractiveInfoDiffContainer(dataStream: &dataStream)
    }
}
