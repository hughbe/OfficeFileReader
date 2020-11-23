//
//  OfficeArtFOPT.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.9 OfficeArtFOPT
/// Referenced by: OfficeArtDggContainer, OfficeArtSpContainer
/// The OfficeArtFOPT record specifies a table of OfficeArtRGFOPTE records, as defined in section 2.3.1. The following properties SHOULD be specified
/// in this table:
///  Blip:Blip Boolean Properties
///  Blip:cropFromBottom
///  Blip:cropFromLeft
///  Blip:cropFromRight
///  Blip:cropFromTop
///  Blip:pib
///  Blip:pibFlags
///  Blip:pibName
///  Blip:pibPrint
///  Blip:pibPrintFlags
///  Blip:pibPrintName
///  Blip:pictureBrightness
///  Blip:pictureContrast
///  Blip:pictureDblCrMod
///  Blip:pictureFillCrMod
///  Blip:pictureId
///  Blip:pictureLineCrMod
///  Blip:pictureTransparent
///  Callout:Callout Boolean Properties
///  Callout:dxyCalloutDropSpecified
///  Callout:dxyCalloutGap
///  Callout:dxyCalloutLengthSpecified
///  Callout:spcoa
///  Callout:spcod
///  FillStyle:Fill Style Boolean Properties
///  FillStyle:fillAngle
///  FillStyle:fillBackColor
///  FillStyle:fillBackOpacity
///  FillStyle:fillBlip
///  FillStyle:fillBlipFlags
///  FillStyle:fillBlipName
///  FillStyle:fillColor
///  FillStyle:fillCrMod
///  FillStyle:fillDztype
///  FillStyle:fillFocus
///  FillStyle:fillHeight
///  FillStyle:fillOpacity
///  FillStyle:fillOriginX
///  FillStyle:fillOriginY
///  FillStyle:fillRectBottom
///  FillStyle:fillRectLeft
///  FillStyle:fillRectRight
///  FillStyle:fillRectTop
///  FillStyle:fillShadeColors
///  FillStyle:fillShadePreset
///  FillStyle:fillShadeType
///  FillStyle:fillShapeOriginX
///  FillStyle:fillShapeOriginY
///  FillStyle:fillToBottom
///  FillStyle:fillToLeft
///  FillStyle:fillToRight
///  FillStyle:fillToTop
///  FillStyle:fillType
///  FillStyle:fillWidth
///  Geometry:adjust2Value
///  Geometry:adjust3Value
///  Geometry:adjust4Value
///  Geometry:adjust5Value
///  Geometry:adjust6Value
///  Geometry:adjust7Value
///  Geometry:adjust8Value
///  Geometry:adjustValue
///  Geometry:cxk
///  Geometry:geoBottom
///  Geometry:geoLeft
///  Geometry:Geometry Boolean Properties
///  Geometry:geoRight
///  Geometry:geoTop
///  Geometry:pAdjustHandles
///  Geometry:pConnectionSites
///  Geometry:pConnectionSitesDir
///  Geometry:pGuides
///  Geometry:pInscribe
///  Geometry:pSegmentInfo
///  Geometry:pVertices
///  Geometry:shapePath
///  Geometry:xLimo
///  Geometry:yLimo
///  GeoText:Geometry Text Boolean Properties
///  GeoText:gtextAlign
///  GeoText:gtextFont
///  GeoText:gtextSize
///  GeoText:gtextSpacing
///  GeoText:gtextUNICODE
///  GroupShape:dyWrapDistBottom
///  GroupShape:dxWrapDistLeft
///  GroupShape:dxWrapDistRight
///  GroupShape:dyWrapDistTop
///  GroupShape:Group Shape Boolean Properties
///  GroupShape:lidRegroup
///  GroupShape:pihlShape
///  GroupShape:pWrapPolygonVertices
///  GroupShape:wzDescription
///  GroupShape:wzName
///  LineStyle:Line Style Boolean Properties
///  LineStyle:lineBackColor
///  LineStyle:lineColor
///  LineStyle:lineCrMod
///  LineStyle:lineDashing
///  LineStyle:lineDashStyle
///  LineStyle:lineEndCapStyle
///  LineStyle:lineEndArrowhead
///  LineStyle:lineEndArrowLength
///  LineStyle:lineEndArrowWidth
///  LineStyle:lineFillBlip
///  LineStyle:lineFillBlipFlags
///  LineStyle:lineFillBlipName
///  LineStyle:lineFillDztype
///  LineStyle:lineFillHeight
///  LineStyle:lineOpacity
///  LineStyle:lineFillWidth
///  LineStyle:lineJoinStyle
///  LineStyle:lineMiterLimit
///  LineStyle:lineStartArrowhead
///  LineStyle:lineStartArrowLength
///  LineStyle:lineStartArrowWidth
///  LineStyle:lineStyle
///  LineStyle:lineWidth
///  LineStyle:lineType
///  PerspectiveStyle:Perspective Style Boolean Properties
///  PerspectiveStyle:perspectiveOffsetX
///  PerspectiveStyle:perspectiveOffsetY
///  PerspectiveStyle:perspectiveOriginX
///  PerspectiveStyle:perspectiveOriginY
///  PerspectiveStyle:perspectivePerspectiveX
///  PerspectiveStyle:perspectivePerspectiveY
///  PerspectiveStyle:perspectiveScaleXToX
///  PerspectiveStyle:perspectiveScaleXToY
///  PerspectiveStyle:perspectiveScaleYToX
///  PerspectiveStyle:perspectiveScaleYToY
///  PerspectiveStyle:perspectiveType
///  PerspectiveStyle:perspectiveWeight
///  Protection:Protection Boolean Properties
///  RelXfrm:gvRelPage
///  RelXfrm:Relative Transform Boolean Properties
///  RelXfrm:relBottom
///  RelXfrm:relLeft
///  RelXfrm:relRight
///  RelXfrm:relRotation
///  RelXfrm:relTop
///  ShadowStyle:Shadow Style Boolean Properties
///  ShadowStyle:shadowColor
///  ShadowStyle:shadowCrMod
///  ShadowStyle:shadowHighlight
///  ShadowStyle:shadowOffsetX
///  ShadowStyle:shadowOffsetY
///  ShadowStyle:shadowOpacity
///  ShadowStyle:shadowOriginX
///  ShadowStyle:shadowOriginY
///  ShadowStyle:shadowSecondOffsetX
///  ShadowStyle:shadowSecondOffsetY
///  ShadowStyle:shadowType
///  Shape:bWMode
///  Shape:bWModeBW
///  Shape:bWModePureBW
///  Shape:hspMaster
///  Shape:cxstyle
///  Shape:Shape Boolean Properties
///  Text:anchorText
///  Text:dyTextBottom
///  Text:dxTextLeft
///  Text:dxTextRight
///  Text:dyTextTop
///  Text:lTxid
///  Text:WrapText
///  Text:txflTextFlow
///  Text:cdirFont
///  Text:hspNext
///  Text:Text Boolean Properties
///  Text:txdir
///  3DObject:c3DCrMod
///  3DObject:c3DDiffuseAmt
///  3DObject:c3DEdgeThickness
///  3DObject:c3DExtrudeBackward
///  3DObject:c3DExtrudeForward
///  3DObject:c3DExtrusionColor
///  3DObject:c3DShininess
///  3DObject:c3DSpecularAmt
///  3DObject:3D-Object Boolean Properties
///  3DStyle:c3DAmbientIntensity
///  3DStyle:c3DFillIntensity
///  3DStyle:c3DFillX
///  3DStyle:c3DFillY
///  3DStyle:c3DFillZ
///  3DStyle:c3DKeyIntensity
///  3DStyle:c3DKeyX
///  3DStyle:c3DKeyY
///  3DStyle:c3DKeyZ
///  3DStyle:c3DOriginX
///  3DStyle:c3DOriginY
///  3DStyle:c3DRenderMode
///  3DStyle:c3DRotationAngle
///  3DStyle:c3DRotationAxisX
///  3DStyle:c3DRotationAxisY
///  3DStyle:c3DRotationAxisZ
///  3DStyle:c3DYRotationAngle
///  3DStyle:c3DXRotationAngle
///  3DStyle:c3DRotationCenterX
///  3DStyle:c3DRotationCenterY
///  3DStyle:c3DRotationCenterZ
///  3DStyle:c3DSkewAmount
///  3DStyle:c3DSkewAngle
///  3DStyle:c3DTolerance
///  3DStyle:c3DXViewpoint
///  3DStyle:c3DYViewpoint
///  3DStyle:c3DZViewpoint
///  3DStyle: 3D-Style Boolean Properties
///  Xfrm:bottom
///  Xfrm:gvPage
///  Xfrm:left
///  Xfrm:right
///  Xfrm:rotation
///  Xfrm:top
///  Xfrm:Transform Boolean Properties
public struct OfficeArtFOPT {
    public let rh: OfficeArtRecordHeader
    public let fopt: OfficeArtRGFOPTE
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x3.
        /// rh.recInstance An unsigned integer that specifies the number of properties in the table.
        /// rh.recType A value that MUST be 0xF00B.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header that contain property records. This value equals
        /// the number of properties multiplied by the size of the OfficeArtFOPTE type, as defined in section 2.2.7, plus the size of the complex
        /// property data.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x3 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF00B else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// fopt (variable): The OfficeArtRGFOPTE property, as defined in section 2.3.1, table that specifies the record data.
        self.fopt = try OfficeArtRGFOPTE(dataStream: &dataStream, count: Int(self.rh.recInstance))
        
        // TODO: found padding...
        if dataStream.position - startPosition < self.rh.recLen {
            let remainingBytes = Int(self.rh.recLen) - (dataStream.position - startPosition)
            if dataStream.position + remainingBytes > dataStream.count {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position += remainingBytes
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
