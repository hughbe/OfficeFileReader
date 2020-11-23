//
//  OfficeArtFOPTEOPID.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.8 OfficeArtFOPTEOPID
/// Referenced by: 3D-Object Boolean Properties, 3D-Style Boolean Properties, adjust2Value, adjust3Value, adjust4Value, adjust5Value, adjust6Value,
/// adjust7Value, adjust8Value, adjustValue, alignHR, anchorText, Blip Boolean Properties, borderBottomColor, borderLeftColor, borderRightColor,
/// borderTopColor, bottom, Bottom Line Style Boolean Properties, bWMode, bWModeBW, bWModePureBW, c3DAmbientIntensity, c3DCrMod,
/// c3DDiffuseAmt, c3DEdgeThickness, c3DExtrudeBackward, c3DExtrudeForward, c3DExtrusionColor, c3DExtrusionColorExt,
/// c3DExtrusionColorExtMod, c3DFillIntensity, c3DFillX, c3DFillY, c3DFillZ, c3DKeyIntensity, c3DKeyX, c3DKeyY, c3DKeyZ, c3DOriginX, c3DOriginY,
/// c3DRenderMode, c3DRotationAngle, c3DRotationAxisX, c3DRotationAxisY, c3DRotationAxisZ, c3DRotationCenterX, c3DRotationCenterY,
/// c3DRotationCenterZ, c3DShininess, c3DSkewAmount, c3DSkewAngle, c3DSpecularAmt, c3DTolerance, c3DXRotationAngle, c3DXViewpoint,
/// c3DYRotationAngle, c3DYViewpoint, c3DZViewpoint, Callout Boolean Properties, cdirFont, cropFromBottom, cropFromLeft, cropFromRight,
/// cropFromTop, cxk, cxstyle, dgmBaseTextScale, dgmConstrainBounds, dgmDefaultFontSize, dgmLayout, dgmLayoutMRU, dgmNodeKind,
/// dgmScaleX, dgmScaleY, dgmStyle, dgmt, dhgt, Diagram Boolean Properties, dxHeightHR, dxTextLeft, dxTextRight, dxWidthHR, dxWrapDistLeft,
/// dxWrapDistRight, dxyCalloutDropSpecified, dxyCalloutGap, dxyCalloutLengthSpecified, dyTextBottom, dyTextTop, dyWrapDistBottom,
/// dyWrapDistTop, equationXML, Fill Style Boolean Properties, fillAngle, fillBackColor, fillBackColorExt, fillBackColorExtMod, fillBackOpacity, fillBlip,
/// fillBlipFlags, fillBlipName, fillColor, fillColorExt, fillColorExtMod, fillCrMod, fillDztype, fillFocus, fillHeight, fillOpacity, fillOriginX, fillOriginY,
/// fillRectBottom, fillRectLeft, fillRectRight, fillRectTop, fillShadeColors, fillShadePreset, fillShadeType, fillShapeOriginX, fillShapeOriginY, fillToBottom,
/// fillToLeft, fillToRight, fillToTop, fillType, fillWidth, geoBottom, geoLeft, Geometry Boolean Properties, Geometry Text Boolean Properties, geoRight,
/// geoTop, Group Shape Boolean Properties, gtextAlign, gtextCSSFont, gtextFont, gtextSize, gtextSpacing, gtextUNICODE, gvPage, gvRelPage,
/// hspMaster, hspNext, idDiscussAnchor, Ink Boolean Properties, left, Left Line Style Boolean Properties, lidRegroup, Line Style Boolean Properties,
/// lineBackColor, lineBackColorExt, lineBackColorExtMod, lineBottomBackColor, lineBottomBackColorExt, lineBottomBackColorExtMod, lineBottomColor,
/// lineBottomColorExt, lineBottomColorExtMod, lineBottomCrMod, lineBottomDashing, lineBottomDashStyle, lineBottomEndArrowhead,
/// lineBottomEndArrowLength, lineBottomEndArrowWidth, lineBottomEndCapStyle, lineBottomFillBlip, lineBottomFillBlipFlags, lineBottomFillBlipName,
/// lineBottomFillDztype, lineBottomFillHeight, lineBottomFillWidth, lineBottomJoinStyle, lineBottomMiterLimit, lineBottomOpacity,
/// lineBottomStartArrowhead, lineBottomStartArrowLength, lineBottomStartArrowWidth, lineBottomStyle, lineBottomType, lineBottomWidth, lineColor,
/// lineColorExt, lineColorExtMod, lineCrMod, lineDashing, lineDashStyle, lineEndArrowhead, lineEndArrowLength, lineEndArrowWidth, lineEndCapStyle,
/// lineFillBlip, lineFillBlipFlags, lineFillBlipName, lineFillDztype, lineFillHeight, lineFillWidth, lineJoinStyle, lineLeftBackColor, lineLeftBackColorExt,
/// lineLeftBackColorExtMod, lineLeftColor, lineLeftColorExt, lineLeftColorExtMod, lineLeftCrMod, lineLeftDashing, lineLeftDashStyle,
/// lineLeftEndArrowhead, lineLeftEndArrowLength, lineLeftEndArrowWidth, lineLeftEndCapStyle, lineLeftFillBlip, lineLeftFillBlipFlags, lineLeftFillBlipName,
/// lineLeftFillDztype, lineLeftFillHeight, lineLeftFillWidth, lineLeftJoinStyle, lineLeftMiterLimit, lineLeftOpacity, lineLeftStartArrowhead,
/// lineLeftStartArrowLength, lineLeftStartArrowWidth, lineLeftStyle, lineLeftType, lineLeftWidth, lineMiterLimit, lineOpacity, lineRightBackColor,
/// lineRightBackColorExt, lineRightBackColorExtMod, lineRightColor, lineRightColorExt, lineRightColorExtMod, lineRightCrMod, lineRightDashing,
/// lineRightDashStyle, lineRightEndArrowhead, lineRightEndArrowLength, lineRightEndArrowWidth, lineRightEndCapStyle, lineRightFillBlip,
/// lineRightFillBlipFlags, lineRightFillBlipName, lineRightFillDztype, lineRightFillHeight, lineRightFillWidth, lineRightJoinStyle, lineRightMiterLimit,
/// lineRightOpacity, lineRightStartArrowhead, lineRightStartArrowLength, lineRightStartArrowWidth, lineRightStyle, lineRightType, lineRightWidth,
/// lineStartArrowhead, lineStartArrowLength, lineStartArrowWidth, lineStyle, lineTopBackColor, lineTopBackColorExt, lineTopBackColorExtMod,
/// lineTopColor, lineTopColorExt, lineTopColorExtMod, lineTopCrMod, lineTopDashing, lineTopDashStyle, lineTopEndArrowhead, lineTopEndArrowLength,
/// lineTopEndArrowWidth, lineTopEndCapStyle, lineTopFillBlip, lineTopFillBlipFlags, lineTopFillBlipName, lineTopFillDztype, lineTopFillHeight,
/// lineTopFillWidth, lineTopJoinStyle, lineTopMiterLimit, lineTopOpacity, lineTopStartArrowhead, lineTopStartArrowLength, lineTopStartArrowWidth,
/// lineTopStyle, lineTopType, lineTopWidth, lineType, lineWidth, lTxid, metroBlob, movie, OfficeArtFOPTE, pAdjustHandles, pConnectionSites,
/// pConnectionSitesDir, pctHoriz, pctHorizPos, pctHR, pctVert, pctVertPos, Perspective Style Boolean Properties, perspectiveOffsetX,
/// perspectiveOffsetY, perspectiveOriginX, perspectiveOriginY, perspectivePerspectiveX, perspectivePerspectiveY, perspectiveScaleXToX,
/// perspectiveScaleXToY, perspectiveScaleYToX, perspectiveScaleYToY, perspectiveType, perspectiveWeight, pGuides, pib, pibFlags, pibName,
/// pibPrint, pibPrintFlags, pibPrintName, pictureBrightness, pictureContrast, pictureDblCrMod, pictureFillCrMod, pictureId, pictureLineCrMod,
/// pictureRecolor, pictureRecolorExt, pictureRecolorExtMod, pictureTransparent, pictureTransparentExt, pictureTransparentExtMod, pihlShape,
/// pInkData, pInscribe, posh, posrelh, posrelv, posv, pRelationTbl, Protection Boolean Properties, pSegmentInfo, pVertices, pWrapPolygonVertices,
/// Relative Transform Boolean Properties, relBottom, relLeft, relRight, relRotation, relTop, reserved1370, reserved1372, reserved1374, reserved1376,
/// reserved1377, reserved1378, reserved1434, reserved1436, reserved1438, reserved1440, reserved1441, reserved1442, reserved1498, reserved1500,
/// reserved1502, reserved1504, reserved1505, reserved1506, reserved1562, reserved1564, reserved1566, reserved1568, reserved1569,
/// reserved1570, reserved278, reserved280, reserved281, reserved284, reserved286, reserved287, reserved415, reserved417, reserved419, reserved421,
/// reserved422, reserved423, reserved474, reserved476, reserved478, reserved480, reserved481, reserved482, reserved531, reserved533, reserved535,
/// reserved537, reserved538, reserved539, reserved646, reserved650, reserved652, reserved653, right, Right Line Style Boolean Properties, rotation,
/// scriptLang, Shadow Style Boolean Properties, shadowColor, shadowColorExt, shadowColorExtMod, shadowCrMod, shadowHighlight,
/// shadowHighlightExt, shadowHighlightExtMod, shadowOffsetX, shadowOffsetY, shadowOpacity, shadowOriginX, shadowOriginY,
/// shadowSecondOffsetX, shadowSecondOffsetY, shadowSoftness, shadowType, Shape Boolean Properties, shapePath, Signature Line Boolean
/// Properties, sizerelh, sizerelv, spcoa, spcod, tableProperties, tableRowProperties, Text Boolean Properties, top, Top Line Style Boolean Properties,
/// Transform Boolean Properties, txdir, txflTextFlow, Unknown HTML Boolean Properties, unused134, unused140, unused141, unused832, unused906,
/// Web Component Boolean Properties, webComponentWzHtml, webComponentWzName, webComponentWzUrl, WrapText, wzCalloutId,
/// wzDescription, wzFillId, wzFormulaeId, wzGtextId, wzHandlesId, wzLineId, wzLockId, wzName, wzPathId, wzPerspectiveId, wzPictureId, wzScript,
/// wzScriptExtAttr, wzScriptLangAttr, wzShadowId, wzSigSetupAddlXml, wzSigSetupId, wzSigSetupProvId, wzSigSetupProvUrl, wzSigSetupSignInst,
/// wzSigSetupSuggSigner, wzSigSetupSuggSigner2, wzSigSetupSuggSignerEmail, wzTextId, wzThreeDId, wzTooltip, wzWebBot, xLimo, yLimo
public struct OfficeArtFOPTEOPID {
    public let opid: UInt16
    public let fBid: Bool
    public let fComplex: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// opid (14 bits): An unsigned integer that specifies the identifier of the property in this entry.
        self.opid = flags.readBits(count: 14)
        
        /// A - fBid (1 bit): A bit that specifies whether the value in the op field is a BLIP identifier. If this value equals 0x1, the value in the op field
        /// specifies the BLIP identifier in the OfficeArtBStoreContainer record, as defined in section 2.2.20. If fComplex equals 0x1, this bit
        /// MUST be ignored.
        self.fBid = flags.readBit()
        
        /// B - fComplex (1 bit): A bit that specifies whether this property is a complex property. If this value equals 0x1, the op field specifies the
        /// size of the data for this property, rather than the property data itself.
        self.fComplex = flags.readBit()
        
    }
}
