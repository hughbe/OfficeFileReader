//
//  TimeSetBehaviorContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.69 TimeSetBehaviorContainer
/// Referenced by: ExtTimeNodeContainer, SubEffectContainer
/// A container record that specifies a set behavior that assigns a value to a property. This animation behavior is applied to the object specified by the
/// behavior.clientVisualElement field and used to animate one property specified by the behavior.stringList field. The property MUST be from the list
/// that is specified in the TimeStringListContainer record (section 2.8.36).
public struct TimeSetBehaviorContainer {
    public let rh: RecordHeader
    public let setBehaviorAtom: TimeSetBehaviorAtom
    public let varTo: TimeVariantString?
    public let behavior: TimeBehaviorContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeSetBehaviorContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeSetBehaviorContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// setBehaviorAtom (16 bytes): A TimeSetBehaviorAtom record that specifies the type of the value to be set and which attributes of this field
        /// and this TimeSetBehaviorContainer are valid.
        self.setBehaviorAtom = try TimeSetBehaviorAtom(dataStream: &dataStream)
        
        /// varTo (variable): A TimeVariantString record that specifies the value that to be set to the property. The varTo.rh.recInstance subfield MUST
        /// be 0x001. It MUST be ignored if setBehaviorAtom.fToPropertyUsed is FALSE.
        /// The allowed set of strings depends on the specific attribute names used in the behavior.stringList field. The supported attribute names are
        /// specified by the TimeStringListContainer record. The varTo.stringValue MUST be a value as specified in the following tables.
        /// When using attribute names in the following table, the setBehaviorAtom.valueType field MUST be TL_TABVT_Number.
        /// Attribute Name varTo.stringValue Preset
        /// style.visibility "hidden", "visible"
        /// style.fontWeight "none", "normal", "bold"
        /// style.fontStyle "none", "normal", "italic"
        /// style.textEffectEmboss "none", "normal", "emboss"
        /// style.textShadow "none", "normal", "auto"
        /// style.textTransform "none", "normal", "sub", "super"
        /// style.textDecorationUnderline "false", "true"
        /// style.textEffectOutline "false", "true"
        /// style.textDecorationLineThrough "false", "true"
        /// imageData.grayscale "false", "true"
        /// fill.on "false", "f", "t", "true"
        /// fill.type "solid", "pattern", "tile", "frame",
        /// "gradientUnscaled", "gradient", "gradientCenter",
        /// "gradientRadial", "gradientTile", "background"
        /// fill.method "none", "linear", "sigma", "any"
        /// stroke.on "false", "f", "t", "true"
        /// stroke.linestyle "single", "thinThin", "thinThick", "thickThin",
        /// "thickBetweenThin"
        /// stroke.dashstyle "solid", "dot", "dash", "dashDot", "longDash",
        /// "longDashDot", "longDashDotDot"
        /// stroke.filltype "solid", "tile", "pattern", "frame"
        /// stroke.startArrow "none", "block", "classic", "diamond", "oval",
        /// "open", "chevron", "doublechevron"
        /// stroke.endArrow "none", "block", "classic", "diamond", "oval",
        /// "open", "chevron", "doublechevron"
        /// stroke.startArrowWidth "narrow", "medium", "wide"
        /// stroke.startArrowLength "short", "medium", "long"
        /// stroke.endArrowWidth "narrow", "medium", "wide"
        /// stroke.endArrowLength "short", "medium", "long"
        /// shadow.on "false", "f", "t", "true"
        /// shadow.type "single", "double", "emboss", "perspective"
        /// skew.on "false", "f", "t", "true"
        /// extrusion.on "false", "f", "t", "true"
        /// extrusion.type "parallel", "perspective"
        /// extrusion.render "solid", "wireframe", "boundingcube"
        /// extrusion.plane "xy", "zx", "yz"
        /// extrusion.lockrotationcenter "false", "true"
        /// extrusion.autorotationcenter "false", "true"
        /// extrusion.colormode "false", "true"
        /// When using attribute names in the following table, the setBehaviorAtom.valueType field MUST be TL_TABVT_Number.
        /// Attribute Name varTo.stringValue
        /// ppt_x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// ppt_y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// ppt_w MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// ppt_h MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// ppt_r MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// xshear MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// yshear MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// ScaleX MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// ScaleY MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// r MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// style.opacity MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// style.rotation MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// style.fontSize MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// style.sRotation MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// imageData.cropTop MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// imageData.cropBottom MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// imageData.cropLeft MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// imageData.cropRight MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// imageData.gain MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// imageData.blacklevel MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// imageData.gamma MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// fill.opacity MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// fill.opacity2 MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// fill.angle MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// fill.focus MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// fill.focusposition.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// fill.focusposition.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// fill.focussize.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// fill.focussize.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// stroke.weight MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// stroke.opacity MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// stroke.imagesize.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// stroke.imagesize.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// shadow.opacity MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// shadow.offset.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// shadow.offset.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// shadow.offset2.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// shadow.offset2.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// shadow.origin.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// shadow.origin.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// shadow.matrix.xtox MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// shadow.matrix.ytox MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// shadow.matrix.ytoy MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// shadow.matrix.perspectiveX MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// shadow.matrix.perspectiveY MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// skew.offset.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// skew.offset.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// skew.origin.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// skew.origin.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// skew.matrix.xtox MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// skew.matrix.ytox MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// skew.matrix.ytoy MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// skew.matrix.perspectiveX MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// skew.matrix.perspectiveY MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.viewpointorigin.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.viewpointorigin.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.viewpoint.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.viewpoint.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.viewpoint.z MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.skewangle MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.skewamt MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.backdepth MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.foredepth MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.orientation.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.orientation.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.orientation.z MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.orientationangle MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.rotationangle.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.rotationangle.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// extrusion.rotationcenter.x MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the
        /// TimeAnimationValueListEntry record.
        /// extrusion.rotationcenter.y MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// extrusion.rotationcenter.z MUST be a valid FORMULA_OR_NUMBER as specified in the following
        /// ABNF (specified in [RFC5234]) grammar:
        /// FORMULA_OR_NUMBER = SETFORMULA / REAL_NUMBER
        /// SETFORMULA = "(" FORMULA ")"
        /// REAL_NUMBER = DEC_REGULAR_VALUE / DEC_PURE_FLOATING
        /// DEC_REGULAR_VALUE = [ "-" ] DEC_NUMBER ["."]
        /// [DEC_NUMBER] [DEC_EXPONENT]
        /// DEC_PURE_FLOATING = [ "-" ] "." DEC_NUMBER
        /// [DEC_EXPONENT]
        /// DEC_NUMBER = 1*DIGIT
        /// DEC_EXPONENT = [ "-" ] ( "e" / "E") DEC_NUMBER
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// When using attribute names in the following table, the setBehaviorAtom.valueType field MUST be TL_TABVT_Color.
        /// Attribute Name varTo.stringValue
        /// ppt_c MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        /// fillcolor MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        /// style.color MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        /// imageData.chromakey MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        /// fill.color MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        /// fill.color2 MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        /// stroke.color MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        /// stroke.color2 MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        /// shadow.color MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        /// shadow.color2 MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        /// extrusion.color MUST be a valid SETCOLOR as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SETCOLOR = "#" RED GREEN BLUE
        /// RED = 2HEXDIG
        /// GREEN = 2HEXDIG
        /// BLUE = 2HEXDIG
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .timeVariant && nextAtom1.recInstance == 0x001 {
            self.varTo = try TimeVariantString(dataStream: &dataStream)
        } else {
            self.varTo = nil
        }
        
        /// behavior (variable): A TimeBehaviorContainer record (section 2.8.34) that specifies the common behavior information.
        self.behavior = try TimeBehaviorContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
