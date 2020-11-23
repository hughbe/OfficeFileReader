//
//  OfficeArtTertiaryFOPT.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.11 OfficeArtTertiaryFOPT
/// Referenced by: OfficeArtDggContainer, OfficeArtSpContainer
/// The OfficeArtTertiaryFOPT record specifies a table of OfficeArtRGFOPTE records, as defined in section 2.3.1. This table SHOULD specify the
/// following properties:
///  Blip:Blip Boolean Properties
///  Blip:pictureRecolor
///  Blip:pictureRecolorExt
///  Blip:pictureRecolorExtMod
///  Blip:pictureTransparentExt
///  Blip:pictureTransparentExtMod
///  Diagram:dgmBaseTextScale
///  Diagram:dgmConstrainBounds
///  Diagram:dgmDefaultFontSize
///  Diagram:dgmScaleX
///  Diagram:dgmScaleY
///  Diagram:dgmStyle
///  Diagram:dgmt
///  Diagram:Diagram Boolean Properties
///  Diagram:pRelationTbl
///  Geometry:Geometry Boolean Properties
///  GeoText:gtextCSSFont
///  GroupShape:alignHR
///  GroupShape:borderBottomColor
///  GroupShape:borderLeftColor
///  GroupShape:borderRightColor
///  GroupShape:borderTopColor
///  GroupShape:dhgt
///  GroupShape:dxHeightHR
///  GroupShape:dxWidthHR
///  GroupShape:Group Shape Boolean Properties
///  GroupShape:metroBlob
///  GroupShape:pctHR
///  GroupShape:posh
///  GroupShape:posrelh
///  GroupShape:posrelv
///  GroupShape:posv
///  GroupShape:scriptLang
///  GroupShape:tableProperties
///  GroupShape:tableRowProperties
///  GroupShape:wzScript
///  GroupShape:wzScriptExtAttr
///  GroupShape:wzScriptLangAttr
///  GroupShape:wzTooltip
///  GroupShape:wzWebBot
///  GroupShape2:pctHoriz
///  GroupShape2:pctHorizPos
///  GroupShape2:pctVert
///  GroupShape2:pctVertPos
///  GroupShape2:sizerelh
///  GroupShape2:sizerelv
///  FillStyle:fillBackColorExt
///  FillStyle:fillBackColorExtMod
///  FillStyle:fillColorExt
///  FillStyle:fillColorExtMod
///  FillStyle:Fill Style Boolean Properties
///  Ink:Ink Boolean Properties
///  Ink:pInkData
///  LineBottomStyle:Bottom Line Style Boolean Properties
///  LineBottomStyle:lineBottomBackColor
///  LineBottomStyle:lineBottomBackColorExt
///  LineBottomStyle:lineBottomBackColorExtMod
///  LineBottomStyle:lineBottomColor
///  LineBottomStyle:lineBottomColorExt
///  LineBottomStyle:lineBottomColorExtMod
///  LineBottomStyle:lineBottomCrMod
///  LineBottomStyle:lineBottomFillBlip
///  LineBottomStyle:lineBottomFillBlipFlags
///  LineBottomStyle:lineBottomFillBlipName
///  LineBottomStyle:lineBottomFillDztype
///  LineBottomStyle:lineBottomFillHeight
///  LineBottomStyle:lineBottomDashing
///  LineBottomStyle:lineBottomDashStyle
///  LineBottomStyle:lineBottomEndArrowhead
///  LineBottomStyle:lineBottomEndArrowLength
///  LineBottomStyle:lineBottomEndArrowWidth
///  LineBottomStyle:lineBottomEndCapStyle
///  LineBottomStyle:lineBottomJoinStyle
///  LineBottomStyle:lineBottomMiterLimit
///  LineBottomStyle:lineBottomFillWidth
///  LineBottomStyle:lineBottomOpacity
///  LineBottomStyle:lineBottomStartArrowhead
///  LineBottomStyle:lineBottomStartArrowLength
///  LineBottomStyle:lineBottomStartArrowWidth
///  LineBottomStyle:lineBottomStyle
///  LineBottomStyle:lineBottomType
///  LineBottomStyle:lineBottomWidth
///  LineLeftStyle:Left Line Style Boolean Properties
///  LineLeftStyle:lineLeftBackColor
///  LineLeftStyle:lineLeftBackColorExt
///  LineLeftStyle:lineLeftBackColorExtMod
///  LineLeftStyle:lineLeftColor
///  LineLeftStyle:lineLeftColorExt
///  LineLeftStyle:lineLeftColorExtMod
///  LineLeftStyle:lineLeftCrMod
///  LineLeftStyle:lineLeftDashing
///  LineLeftStyle:lineLeftDashStyle
///  LineLeftStyle:lineLeftEndArrowhead
///  LineLeftStyle:lineLeftEndArrowLength
///  LineLeftStyle:lineLeftEndArrowWidth
///  LineLeftStyle:lineLeftEndCapStyle
///  LineLeftStyle:lineLeftFillBlip
///  LineLeftStyle:lineLeftFillBlipFlags
///  LineLeftStyle:lineLeftFillBlipName
///  LineLeftStyle:lineLeftFillDztype
///  LineLeftStyle:lineLeftFillHeight
///  LineLeftStyle:lineLeftMiterLimit
///  LineLeftStyle:lineLeftFillWidth
///  LineLeftStyle:lineLeftJoinStyle
///  LineLeftStyle:lineLeftOpacity
///  LineLeftStyle:lineLeftStartArrowhead
///  LineLeftStyle:lineLeftStartArrowLength
///  LineLeftStyle:lineLeftStartArrowWidth
///  LineLeftStyle:lineLeftStyle
///  LineLeftStyle:lineLeftType
///  LineLeftStyle:lineLeftWidth
///  LineRightStyle:lineRightBackColor
///  LineRightStyle:lineRightBackColorExt
///  LineRightStyle:lineRightBackColorExtMod
///  LineRightStyle:lineRightColor
///  LineRightStyle:lineRightColorExt
///  LineRightStyle:lineRightColorExtMod
///  LineRightStyle:lineRightCrMod
///  LineRightStyle:lineRightDashing
///  LineRightStyle:lineRightDashStyle
///  LineRightStyle:lineRightEndArrowhead
///  LineRightStyle:lineRightEndArrowLength
///  LineRightStyle:lineRightEndArrowWidth
///  LineRightStyle:lineRightEndCapStyle
///  LineRightStyle:lineRightFillBlip
///  LineRightStyle:lineRightFillBlipFlags
///  LineRightStyle:lineRightFillBlipName
///  LineRightStyle:lineRightFillDztype
///  LineRightStyle:lineRightFillHeight
///  LineRightStyle:lineRightFillWidth
///  LineRightStyle:lineRightJoinStyle
///  LineRightStyle:lineRightMiterLimit
///  LineRightStyle:lineRightOpacity
///  LineRightStyle:lineRightStartArrowhead
///  LineRightStyle:lineRightStartArrowLength
///  LineRightStyle:lineRightStartArrowWidth
///  LineRightStyle:lineRightStyle
///  LineRightStyle:lineRightType
///  LineRightStyle:lineRightWidth
///  LineRightStyle:Right Line Style Boolean Properties
///  LineStyle:lineBackColorExt
///  LineStyle:lineBackColorExtMod
///  LineStyle:lineColorExt
///  LineStyle:lineColorExtMod
///  LineStyle:Line Style Boolean Properties
///  LineTopStyle:lineTopBackColor
///  LineTopStyle:lineTopBackColorExt
///  LineTopStyle:lineTopBackColorExtMod
///  LineTopStyle:lineTopColor
///  LineTopStyle:lineTopColorExt
///  LineTopStyle:lineTopColorExtMod
///  LineTopStyle:lineTopCrMod
///  LineTopStyle:lineTopDashing
///  LineTopStyle:lineTopDashStyle
///  LineTopStyle:lineTopEndArrowhead
///  LineTopStyle:lineTopEndArrowLength
///  LineTopStyle:lineTopEndArrowWidth
///  LineTopStyle:lineTopFillBlip
///  LineTopStyle:lineTopFillBlipFlags
///  LineTopStyle:lineTopFillBlipName
///  LineTopStyle:lineTopFillDztype
///  LineTopStyle:lineTopFillHeight
///  LineTopStyle:lineTopFillWidth
///  LineTopStyle:lineTopJoinStyle
///  LineTopStyle:lineTopMiterLimit
///  LineTopStyle:lineTopStartArrowhead
///  LineTopStyle:lineTopStartArrowLength
///  LineTopStyle:lineTopStartArrowWidth
///  LineTopStyle:lineTopEndCapStyle
///  LineTopStyle:lineTopOpacity
///  LineTopStyle:lineTopStyle
///  LineTopStyle:lineTopType
///  LineTopStyle:lineTopWidth
///  LineTopStyle:Top Line Style Boolean Properties
///  Protection:Protection Boolean Properties
///  ShadowStyle:shadowColorExt
///  ShadowStyle:shadowColorExtMod
///  ShadowStyle:shadowHighlightExt
///  ShadowStyle:shadowHighlightExtMod
///  Shape:dgmLayout
///  Shape:dgmLayoutMRU
///  Shape:dgmNodeKind
///  Shape:equationXML
///  Shape:idDiscussAnchor
///  Shape:Shape Boolean Properties
///  3DObject:c3DExtrusionColorExt
///  3DObject:c3DExtrusionColorExtMod
///  UnknownHTML:Unknown HTML Boolean Properties
///  UnknownHTML:wzCalloutId
///  UnknownHTML:wzFillId
///  UnknownHTML:wzFormulaeId
///  UnknownHTML:wzGtextId
///  UnknownHTML:wzHandlesId
///  UnknownHTML:wzLineId
///  UnknownHTML:wzLockId
///  UnknownHTML:wzPathId
///  UnknownHTML:wzPerspectiveId
///  UnknownHTML:wzPictureId
///  UnknownHTML:wzShadowId
///  UnknownHTML:wzTextId
///  UnknownHTML:wzThreeDId
///  WebComponent:webComponentWzHtml
///  WebComponent:webComponentWzName
///  WebComponent:webComponentWzUrl
///  WebComponent:Web Component Boolean Properties
///  SignatureLine:Signature Line Boolean Properties
///  SignatureLine:wzSigSetupAddlXml
///  SignatureLine:wzSigSetupProvUrl
///  SignatureLine:wzSigSetupId
///  SignatureLine:wzSigSetupProvId
///  SignatureLine:wzSigSetupSignInst
///  SignatureLine:wzSigSetupSuggSigner
///  SignatureLine:wzSigSetupSuggSigner2
///  SignatureLine:wzSigSetupSuggSignerEmail
public struct OfficeArtTertiaryFOPT {
    public let rh: OfficeArtRecordHeader
    public let fopt: OfficeArtRGFOPTE
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x3.
        /// rh.recInstance An unsigned integer that specifies the number of properties in the table.
        /// rh.recType A value that MUST be 0xF122.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header that contain property records. This value equals the
        /// number of properties multiplied by the size of the OfficeArtFOPTE type, as defined in section 2.2.7, plus the size of the complex property
        /// data.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x3 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF122 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// fopt (variable): The OfficeArtRGFOPTE record, as defined in section 2.3.1, table that specifies the property data.
        self.fopt = try OfficeArtRGFOPTE(dataStream: &dataStream, count: Int(self.rh.recInstance))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
