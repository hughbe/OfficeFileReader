//
//  TimeAnimationValueListEntry.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.32 TimeAnimationValueListEntry
/// Referenced by: TimeAnimationValueListContainer
/// A structure that specifies a key point in a property animation.
public struct TimeAnimationValueListEntry {
    public let timeAnimationValueAtom: TimeAnimationValueAtom
    public let varValue: TimeVariant?
    public let varFormula: TimeVariantString?
    
    public init(dataStream: inout DataStream, startPosition: Int, length: Int) throws {
        /// timeAnimationValueAtom (12 bytes): A TimeAnimationValueAtom record that specifies the time, as a percentage of the animation time,
        /// at which the property takes on the value specified by the varValue and varFormula fields.
        self.timeAnimationValueAtom = try TimeAnimationValueAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == length {
            self.varValue = nil
            self.varFormula = nil
            return
        }
        
        /// varValue (variable): An optional TimeVariant record that specifies a value that corresponds to the time as specified in the
        /// timeAnimationValueAtom.time field. The sub-field varValue.rh.recInstance MUST be 0x000. If the varFormula field exists, the property takes
        /// on the value specified by the formula; otherwise, the property takes on this value.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .timeVariant && nextAtom1.recInstance == 0x000 {
            self.varValue = try TimeVariant(dataStream: &dataStream)
        } else {
            self.varValue = nil
        }

        if dataStream.position - startPosition == length {
            self.varFormula = nil
            return
        }
        
        /// varFormula (variable): An optional TimeVariantString record that specifies a formula to be used to specify a complex animation for an object.
        /// The sub-field varFormula.rh.recInstance MUST be 0x001.
        /// The formula manipulates a property value of the object, over a specified period of time. Each formula has zero or more inputs specified by
        /// the ($) symbol, zero or more variables specified by the (#) symbol, and a target variable. In each instance, the special symbols are pre-pended
        /// to the variable name. The target variable is specified by the behavior.stringList.rgChildRec field of the TimeAnimateBehaviorContainer record
        /// (section 2.8.29) that also contains the TimeAnimationValueListContainer record (section 2.8.31) that contains this TimeAnimationValueListEntry
        /// record. The formula can contain one or more of any of the following constants, operators or functions. In addition, the formula can also
        /// contain floatingpoint numbers and parentheses.
        /// The varFormula.stringValue MUST be a valid FORMULA as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// FORMULA = TERM *(( "+" / "-" ) TERM)
        /// TERM = POWER *(( "*" / "/" / "%" ) POWER)
        /// POWER = UNARY *("^" UNARY)
        /// UNARY = ["+" / "-"] FACTOR
        /// FACTOR = VARIABLE / CONSTANT / FUNCTION / PARENS
        /// PARENS = "(" FORMULA ")"CHAR = "." / "_" / ALPHA / DIGIT
        /// NUMBER = 1*DIGIT
        /// EXPONENT = ( "e" / "E" ) ["-"] NUMBER
        /// VALUE = NUMBER ["." NUMBER] [EXPONENT]
        /// VARIABLE = "$" / ATTRIBUTE
        /// ATTRIBUTE = ["#"] ATTRNAME
        /// ATTRNAME = OFFICEART_CLIENT_ATTRNAME / OFFICEART_FOPT_ATTRNAME
        /// OFFICEART_CLIENT_ATTRNAME = "ppt_x" / "ppt_y" / "ppt_w" / "ppt_h" / "ScaleX" / "ScaleY"
        /// OFFICEART_FOPT_ATTRNAME = "stype.rotation" / "style.opacity" / "style.visibility" / "ppt_r" /
        /// "r" / "style.fontSize" / "style.fontWeight" / "style.fontStyle" / "style.fontFamily" /
        /// "style.textEffectEmboss" / "style.textShadow" / "style.textTransform" /
        /// "style.textDecorationUnderline" / "style.textEffectOutline" /
        /// "style.textDecorationLineThrough" / "style.sRotation" / "imageData.cropTop" /
        /// "imageData.cropBottom" / "imageData.cropLeft" / "imageData.cropRight" / "imageData.gain" /
        /// "imageData.blackleve" / "imageData.gamma" / "imageData.grayscale" / "fill.on" / "fill.type" /
        /// "fill.opacity" / "fill.method" / "fill.opacity2" / "fill.angle" / "fill.focus" /
        /// "fill.focusposition.x" / "fill.focusposition.y" / "fill.focussize.x" / "fill.focussize.y" /
        /// "stroke.on" / "stroke.weight" / "stroke.opacity" / "stroke.linestyle" / "stroke.dashstyle" /
        /// "stroke.filltype" / "stroke.imagesize.x" / "stroke.imagesize.y" / "stroke.startArrow" /
        /// "stroke.endArrow" / "stroke.startArrowWidth" / "stroke.startArrowLength" /
        /// "stroke.endArrowWidth" / "stroke.endArrowLength" / "shadow.on" / "shadow.type" /
        /// "shadow.opacity" / "shadow.offset.x" / "shadow.offset.y" / "shadow.offset2.x" /
        /// "shadow.offset2.y" / "shadow.origin.x" / "shadow.origin.y" / "shadow.matrix.xtox" /
        /// "shadow.matrix.ytox" / "shadow.matrix.xtox" / "shadow.matrix.ytoy" /
        /// "shadow.matrix.perspectiveX" / "shadow.matrix.perspectiveY" / "skew.on" / "skew.offset.x" /
        /// "skew.offset.y" / "skew.origin.x" / "skew.origin.y" / "skew.matrix.xtox" / "skew.matrix.ytox"
        /// / "skew.matrix.xtox" / "skew.matrix.ytoy" / "skew.matrix.perspectiveX" /
        /// "skew.matrix.perspectiveY" / "extrusion.on" / "extrusion.type" / "extrusion.render" /
        /// "extrusion.viewpointorigin.x" / "extrusion.viewpointorigin.y" / "extrusion.viewpoint.x" /
        /// "extrusion.viewpoint.y" / "extrusion.viewpoint.z" / "extrusion.plane" / "extrusion.skewangle"
        /// / "extrusion.skewamt" / "extrusion.backdepth" / "extrusion.foredepth" /
        /// "extrusion.orientation.x" / "extrusion.orientation.y" / "extrusion.orientation.z" /
        /// "extrusion.orientationangle" / "extrusion.rotationangle.x" / "extrusion.rotationangle.y" /
        /// "extrusion.lockrotationcenter" / "extrusion.autorotationcenter" /
        /// "extrusion.rotationcenter.x" / "extrusion.rotationcenter.y" / "extrusion.rotationcenter.z" /
        /// "extrusion.colormode"
        /// CONSTANT = VALUE / "pi" / "e"
        /// IDENT = "abs" / "acos" / "asin" / "atan" / "ceil" / "cos" / "cosh" / "deg" / "exp" / "floor"
        /// / "ln" / "max" / "min" / "rad" / "rand" / "sin" / "sinh" / "sqrt" / "tan" / "tanh"
        /// FUNCTION = IDENT "(" FORMULA ["," FORMULA] ")"
        /// Components of the preceding formula are further specified as follows.
        /// Operator precedence
        /// Mathematical operations have the following order of precedence, listed from lowest to highest.
        /// Operators listed on the same line have equal precedence.
        /// 1. "+" (Addition), "-" (Subtraction)
        /// 2. "*" (Multiplication), "/" (Division), "%" (Modulo)
        /// 3. "^" (Exponentiation)
        /// 4. "-" (Unary minus), "+" (Unary plus)
        /// 5. Variables, Constants (including numbers) and Functions
        /// Variables
        /// The symbol '$' represents the value of varValue.
        /// Attributes
        /// ATTRNAME MUST be one from the following two lists:
        ///  OFFICEART_CLIENT_ATTRNAME specifies the list of attributes that are translated from the OfficeArtClientAnchor record.
        ///  OFFICEART_FOPT_ATTRNAME specifies the list of attributes that are translated from the OfficeArtFOPT record ([MS-ODRAW] section 2.2.9).
        /// Constants
        /// Name Description
        /// pi Mathematical constant pi
        /// e Mathematical constant e
        /// Operators
        /// Name Description Usage
        /// + Addition "x+y", adds x to the value y
        /// - Subtraction "x-y", subtracts y from the value x
        /// * Multiplication "x*y", multiplies x by the value y
        /// / Division "x/y", divides x by the value y
        /// % Modulus "x%y", the remainder of x/y
        /// ^ Power "x^y", x raised to the power y
        /// Functions
        /// Name Description Usage
        /// abs Absolute value "abs(x)", absolute value of x
        /// acos Arc Cosine "acos(x)", arc cosine of the value x
        /// asin Arc Sine "asin(x)", arc sine of the value x
        /// atan Arc Tangent "atan(x)", arc tangent of the value x
        /// ceil Ceil value "ceil(x)", value of x rounded up
        /// cos Cosine "cos(x)", cosine of the value of x
        /// cosh Hyperbolic Cosine "cosh(x)", hyperbolic cosine of the value x
        /// deg Radiant to Degree convert "deg(x)", the degree value of radiant value x
        /// exp Exponent "exp(x)", value of constant e raised to the
        /// power of x
        /// floor Floor value "floor(x)", value of x rounded down
        /// ln Natural logarithm "ln(x)", natural logarithm of x
        /// max Maximum of two values "max(x,y)", returns x if (x > y) or returns y if (y > x)
        /// min Minimum of two values "min(x,y)", returns x if (x < y) or returns y if (y < x)
        /// rad Degree to Radiant convert "rad(x)", the radiant value of degree value x
        /// rand Random value "rand(x)", returns a random floating point
        /// value between 0 and x
        /// sin Sine "sin(x)", sine of the value x
        /// sinh Hyperbolic Sine "sinh(x)", hyperbolic sine of the value x
        /// sqrt Square root "sqrt(x)", square root of the value x
        /// tan Tangent "tan(x)", tangent of the value x
        /// tanh Hyperbolic Tangent "tanh(x)", hyperbolic tangent of the value x
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .timeVariant && nextAtom2.recInstance == 0x001 {
            self.varFormula = try TimeVariantString(dataStream: &dataStream)
        } else {
            self.varFormula = nil
        }
    }
}
