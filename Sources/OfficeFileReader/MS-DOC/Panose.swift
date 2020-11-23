//
//  PANOSE.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.173 PANOSE
/// The PANOSE structure defines the PANOSE font classification values for a TrueType font, as specified in [PANOSE]. These characteristics are
/// used to associate the font with other fonts of similar appearance but different names.
public struct PANOSE {
    public let bFamilyType: UInt8
    public let bSerifStyle: UInt8
    public let bWeight: UInt8
    public let bProportion: UInt8
    public let bContrast: UInt8
    public let bStrokeVariation: UInt8
    public let bArmStyle: UInt8
    public let bLetterform: UInt8
    public let bMidline: UInt8
    public let bHeight: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// bFamilyType (1 byte): For Latin fonts, this field MUST have one of the following values.
        /// Value Meaning
        /// PAN_ANY (0) Any.
        /// PAN_NO_FIT (1) No fit.
        /// PAN_SERIF_COVE (2) Cove.
        /// PAN_SERIF_OBTUSE_COVE (3) Obtuse cove.
        /// PAN_SERIF_SQUARE_COVE (4) Square cove.
        /// PAN_SERIF_OBTUSE_SQUARE_COVE (5) Obtuse square cove.
        /// PAN_SERIF_SQUARE (6) Square.
        /// PAN_SERIF_THIN (7) Thin.
        /// PAN_SERIF_BONE (8) Bone.
        /// PAN_SERIF_EXAGGERATED (9) Exaggerated.
        /// PAN_SERIF_TRIANGLE (10) Triangle.
        /// PAN_SERIF_NORMAL_SANS (11) Normal sans serif.
        /// PAN_SERIF_OBTUSE_SANS (12) Obtuse sans serif.
        /// PAN_SERIF_PERP_SANS (13) Perp sans serif.
        /// PAN_SERIF_FLARED (14) Flared.
        /// PAN_SERIF_ROUNDED (15) Rounded.
        self.bFamilyType = try dataStream.read()
        
        /// bSerifStyle (1 byte): Specifies the serif style. For Latin fonts, this field MUST have one of the following values.
        /// Value Meaning
        /// PAN_ANY (0) Any.
        /// PAN_NO_FIT (1) No fit.
        /// PAN_SERIF_COVE (2) Cove.
        /// PAN_SERIF_OBTUSE_COVE (3) Obtuse cove.
        /// PAN_SERIF_SQUARE_COVE (4) Square cove.
        /// PAN_SERIF_OBTUSE_SQUARE_COVE (5) Obtuse square cove.
        /// PAN_SERIF_SQUARE (6) Square.
        /// PAN_SERIF_THIN (7) Thin.
        /// PAN_SERIF_BONE (8) Bone.
        /// PAN_SERIF_EXAGGERATED (9) Exaggerated.
        /// PAN_SERIF_TRIANGLE (10) Triangle.
        /// PAN_SERIF_NORMAL_SANS (11) Normal sans serif.
        /// PAN_SERIF_OBTUSE_SANS (12) Obtuse sans serif.
        /// PAN_SERIF_PERP_SANS (13) Perp sans serif.
        /// PAN_SERIF_FLARED (14) Flared.
        /// PAN_SERIF_ROUNDED (15) Rounded
        self.bSerifStyle = try dataStream.read()
        
        /// bWeight (1 byte): For Latin fonts, this field MUST have one of the following values.
        /// Value Meaning
        /// PAN_ANY (0) Any.
        /// PAN_NO_FIT (1) No fit.
        /// PAN_WEIGHT_VERY_LIGHT (2) Very light.
        /// PAN_WEIGHT_LIGHT (3) Light.
        /// PAN_WEIGHT_THIN (4) Thin.
        /// PAN_WEIGHT_BOOK (5) Book.
        /// PAN_WEIGHT_MEDIUM (6) Medium.
        /// PAN_WEIGHT_DEMI (7) Demibold.
        /// PAN_WEIGHT_BOLD (8) Bold.
        /// PAN_WEIGHT_HEAVY (9) Heavy.
        /// PAN_WEIGHT_BLACK (10) Black
        /// PAN_WEIGHT_NORD (11) Nord.
        self.bWeight = try dataStream.read()
        
        /// bProportion (1 byte): For Latin fonts, this field MUST have one of the following values.
        /// Value Meaning
        /// PAN_ANY (0) Any.
        /// PAN_NO_FIT (1) No fit.
        /// PAN_PROP_OLD_STYLE (2) Old Style.
        /// PAN_PROP_MODERN (3) Modern.
        /// PAN_PROP_EVEN_WIDTH (4) Even Width.
        /// PAN_PROP_EXPANDED (5) Expanded.
        /// PAN_PROP_CONDENSED (6) Condensed.
        /// PAN_PROP_VERY_EXPANDED (7) Very Expanded.
        /// PAN_PROP_VERY_CONDENSED (8) Very Condensed.
        /// PAN_PROP_MONOSPACED (9) Monospaced.
        self.bProportion = try dataStream.read()
        
        /// bContrast (1 byte): For Latin fonts, this field MUST have one of the following values.
        /// Value Meaning
        /// PAN_ANY (0) Any.
        /// PAN_NO_FIT (1) No fit.
        /// PAN_CONTRAST_NONE (2) None.
        /// PAN_CONTRAST_VERY_LOW (3) Very low.
        /// PAN_CONTRAST_LOW (4) Low.
        /// PAN_CONTRAST_MEDIUM_LOW (5) Medium low.
        /// PAN_CONTRAST_MEDIUM (6) Medium.
        /// PAN_CONTRAST_MEDIUM_HIGH (7) Medium high.
        /// PAN_CONTRAST_HIGH (8) High.
        /// PAN_CONTRAST_VERY_HIGH (9) Very high.
        self.bContrast = try dataStream.read()
        
        /// bStrokeVariation (1 byte): For Latin fonts, this field MUST have one of the following values.
        /// Value Meaning
        /// PAN_ANY (0) Any.
        /// PAN_NO_FIT (1) No fit.
        /// 2 No Variation.
        /// 3 Gradual/diagonal.
        /// 4 Gradual/transitional.
        /// 5 Gradual/vertical.
        /// 6 Gradual/horizontal.
        /// 7 Rapid/vertical.
        /// 8 Rapid/horizontal.
        /// 9 Instant/Vertical.
        /// 10 Instant/Horizontal.
        self.bStrokeVariation = try dataStream.read()
        
        /// bArmStyle (1 byte): For Latin fonts, this field MUST have one of the following values.
        /// Value Meaning
        /// PAN_ANY (0) Any.
        /// PAN_NO_FIT (1) No fit.
        /// PAN_STRAIGHT_ARMS_HORZ (2) Straight arms/horizontal.
        /// PAN_STRAIGHT_ARMS_WEDGE (3) Straight arms/wedge.
        /// PAN_STRAIGHT_ARMS_VERT (4) Straight arms/vertical.
        /// PAN_STRAIGHT_ARMS_SINGLE_SERIF (5) Straight arms/single-serif.
        /// PAN_STRAIGHT_ARMS_DOUBLE_SERIF (6) Straight arms/double-serif.
        /// PAN_BENT_ARMS_HORZ (7) Non-straight arms/horizontal.
        /// PAN_BENT_ARMS_WEDGE (8) Non-straight arms/wedge.
        /// PAN_BENT_ARMS_VERT (9) Non-straight arms/vertical.
        /// PAN_BENT_ARMS_SINGLE_SERIF (10) Non-straight arms/single-serif.
        /// PAN_BENT_ARMS_DOUBLE_SERIF (11) Non-straight arms/double-serif.
        self.bArmStyle = try dataStream.read()
        
        /// bLetterform (1 byte): For Latin fonts, this field MUST have one of the following values.
        /// Value Meaning
        /// PAN_ANY (0) Any.
        /// PAN_NO_FIT (1) No fit.
        /// PAN_LETT_NORMAL_CONTACT (2) Normal/Contact.
        /// PAN_LETT_NORMAL_WEIGHTED (3) Normal/Weighted.
        /// PAN_LETT_NORMAL_BOXED (4) Normal/Boxed.
        /// PAN_LETT_NORMAL_FLATTENED (5) Normal/Flattened.
        /// PAN_LETT_NORMAL_ROUNDED (6) Normal/Rounded.
        /// PAN_LETT_NORMAL_OFF_CENTER (7) Normal/Off-Center.
        /// PAN_LETT_NORMAL_SQUARE (8) Normal/Square.
        /// PAN_LETT_OBLIQUE_CONTACT (9) Oblique/Contact.
        /// PAN_LETT_OBLIQUE_WEIGHTED (10) Oblique/Weighted.
        /// PAN_LETT_OBLIQUE_BOXED (11) Oblique/Boxed.
        /// PAN_LETT_OBLIQUE_FLATTENED (12) Oblique/Flattened.
        /// PAN_LETT_OBLIQUE_ROUNDED (13) Oblique/Rounded.
        /// PAN_LETT_OBLIQUE_OFF_CENTER (14) Oblique/Off-Center.
        /// PAN_LETT_OBLIQUE_SQUARE (15) Oblique/Square.
        self.bLetterform = try dataStream.read()
        
        /// bMidline (1 byte): For Latin fonts, this field MUST have one of the following values.
        /// Value Meaning
        /// PAN_ANY (0) Any.
        /// PAN_NO_FIT (1) No fit.
        /// PAN_MIDLINE_STANDARD_TRIMMED (2) Standard/Trimmed.
        /// PAN_MIDLINE_STANDARD_POINTED (3) Standard/Pointed.
        /// PAN_MIDLINE_STANDARD_SERIFED (4) Standard/Serifed.
        /// PAN_MIDLINE_HIGH_TRIMMED (5) High/Trimmed.
        /// PAN_MIDLINE_HIGH_POINTED (6) High/Pointed.
        /// PAN_MIDLINE_HIGH_SERIFED (7) High/Serifed.
        /// PAN_MIDLINE_CONSTANT_TRIMMED (8) Constant/Trimmed.
        /// PAN_MIDLINE_CONSTANT_POINTED (9) Constant/Pointed.
        /// PAN_MIDLINE_CONSTANT_SERIFED (10) Constant/Serifed.
        /// PAN_MIDLINE_LOW_TRIMMED (11) Low/Trimmed.
        /// PAN_MIDLINE_LOW_POINTED (12) Low/Pointed.
        /// PAN_MIDLINE_LOW_SERIFED (13) Low/Serifed.
        self.bMidline = try dataStream.read()
        
        /// bHeight (1 byte): For Latin fonts, this field MUST have one of the following values.
        /// PAN_ANY (0) Any.
        /// PAN_NO_FIT (1) No fit.
        /// PAN_XHEIGHT_CONSTANT_SMALL (2) Constant/small.
        /// PAN_XHEIGHT_CONSTANT_STD (3) Constant/standard.
        /// PAN_XHEIGHT_CONSTANT_LARGE (4) Constant/large.
        /// PAN_XHEIGHT_DUCKING_SMALL (5) Ducking/small.
        /// PAN_XHEIGHT_DUCKING_STD (6) Ducking/standard.
        /// PAN_XHEIGHT_DUCKING_LARGE (7) Ducking/large.
        self.bHeight = try dataStream.read()
    }
}
