//
//  TimeStringListContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.36 TimeStringListContainer
/// Referenced by: TimeBehaviorContainer
/// A container record that specifies a list of names of properties that are animated by an animation behavior.
public struct TimeStringListContainer {
    public let rh: RecordHeader
    public let rgChildRec: [TimeVariantString]

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be an RT_TimeVariantList.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeVariantList else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgChildRec (variable): An array of TimeVariantString record that specifies the list of names. The length, in bytes, of the array is specified
        /// by rh.recLen. The property names SHOULD be from the following list of possible names:
        /// ppt_x, ppt_y, ppt_w, ppt_h, ppt_c, ppt_r, xshear, yshear, image, ScaleX, ScaleY, r, fillcolor,
        /// style.opacity, style.rotation, style.visibility, style.color, style.fontSize, style.fontWeight,
        /// style.fontStyle, style.fontFamily, style.textEffectEmboss, style.textShadow, style.textTransform,
        /// style.textDecorationUnderline, style.textEffectOutline, style.textDecorationLineThrough,
        /// style.sRotation, imageData.cropTop, imageData.cropBottom, imageData.cropLeft,
        /// imageData.cropRight, imageData.gain, imageData.blacklevel, imageData.gamma,
        /// imageData.grayscale, imageData.chromakey, fill.on, fill.type, fill.color, fill.opacity, fill.color2,
        /// fill.method, fill.opacity2, fill.angle, fill.focus, fill.focusposition.x, fill.focusposition.y, fill.focussize.x,
        /// fill.focussize.y, stroke.on, stroke.color, stroke.weight, stroke.opacity, stroke.linestyle,
        /// stroke.dashstyle, stroke.filltype, stroke.src, stroke.color2, stroke.imagesize.x, stroke.imagesize.y,
        /// stroke.startArrow, stroke.endArrow, stroke.startArrowWidth, stroke.startArrowLength,
        /// stroke.endArrowWidth, stroke.endArrowLength, shadow.on, shadow.type, shadow.color,
        /// shadow.color2, shadow.opacity, shadow.offset.x, shadow.offset.y, shadow.offset2.x,
        /// shadow.offset2.y, shadow.origin.x, shadow.origin.y, shadow.matrix.xtox, shadow.matrix.ytox,
        /// shadow.matrix.xtox, shadow.matrix.ytoy, shadow.matrix.perspectiveX,
        /// shadow.matrix.perspectiveY, skew.on, skew.offset.x, skew.offset.y, skew.origin.x, skew.origin.y,
        /// skew.matrix.xtox, skew.matrix.ytox, skew.matrix.xtox, skew.matrix.ytoy,
        /// skew.matrix.perspectiveX, skew.matrix.perspectiveY, extrusion.on, extrusion.type,
        /// extrusion.render, extrusion.viewpointorigin.x, extrusion.viewpointorigin.y, extrusion.viewpoint.x,
        /// extrusion.viewpoint.y, extrusion.viewpoint.z, extrusion.plane, extrusion.skewangle,
        /// extrusion.skewamt, extrusion.backdepth, extrusion.foredepth, extrusion.orientation.x,
        /// extrusion.orientation.y, extrusion.orientation.z, extrusion.orientationangle, extrusion.color,
        /// extrusion.rotationangle.x, extrusion.rotationangle.y, extrusion.lockrotationcenter,
        /// extrusion.autorotationcenter, extrusion.rotationcenter.x, extrusion.rotationcenter.y,
        /// extrusion.rotationcenter.z, and extrusion.colormode
        var rgChildRec: [TimeVariantString] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgChildRec.append(try TimeVariantString(dataStream: &dataStream))
        }

        self.rgChildRec = rgChildRec
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
