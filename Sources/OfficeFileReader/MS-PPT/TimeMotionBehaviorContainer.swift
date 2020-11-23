//
//  TimeMotionBehaviorContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.63 TimeMotionBehaviorContainer
/// Referenced by: ExtTimeNodeContainer
/// A container record that specifies a motion behavior that moves an object along a path. This animation behavior is applied to the object specified by
/// the timeBehavior.clientVisualElement field and used to animate two properties specified by the timeBehavior.stringList field. The properties
/// MUST be ones from the list that is specified in the TimeStringListContainer record (section 2.8.36).
/// If no properties are specified, "ppt_x" and "ppt_y" will be used. If only one property is specified, "ppt_y" will be used as the second property.
public struct TimeMotionBehaviorContainer {
    public let rh: RecordHeader
    public let motionBehaviorAtom: TimeMotionBehaviorAtom
    public let varPath: TimeVariantString?
    public let reserved: TimeVariantInt?
    public let timeBehavior: TimeBehaviorContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeMotionBehaviorContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeMotionBehaviorContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// motionBehaviorAtom (40 bytes): A TimeMotionBehaviorAtom record that specifies the origin of the path, which attributes of this field and
        /// this TimeMotionBehaviorContainer record are valid, and a path specified by a starting point, an endpoint, and an offset value.
        self.motionBehaviorAtom = try TimeMotionBehaviorAtom(dataStream: &dataStream)
        
        /// varPath (variable): An optional TimeVariantString record that specifies the path for the animation motion. The varPath.rh.recInstance
        /// sub-field MUST be 0x001. It MUST be a valid
        /// MOTION_PATH as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// MOTION_PATH = 1*PATH_COMMAND
        /// PATH_COMMAND = MOVE_COMMAND / LINE_COMMAND / CURVE_COMMAND / CLOSE_COMMAND
        /// MOVE_COMMAND = ("m" / "M") SPACE COORD_NUMBER SPACE COORD_NUMBER
        /// LINE_COMMAND = ("l" / "L") SPACE COORD_NUMBER SPACE COORD_NUMBER
        /// CURVE_COMMAND = ("c" / "C") SPACE COORD_NUMBER SPACE COORD_NUMBER SPACE COORD_NUMBER SPACE
        /// COORD_NUMBER SPACE COORD_NUMBER SPACE COORD_NUMBER
        /// CLOSE_COMMAND = ("z" / "Z")
        /// COORD_NUMBER = (DEC_NUMBER ["." DEC_NUMBER]) / ("(" FORMULA ")")
        /// DEC_NUMBER = 1*DIGIT
        /// SPACE = 1*" "
        /// The FORMULA rule is specified by the varFormula field of the TimeAnimationValueListEntry record.
        /// The path is specified by defining an action and coordinates that go along with the action. The allowed action types that are understood within
        /// a path are listed in the following table. If the action is expressed in uppercase, the following point(s) are to be interpreted as absolute
        /// coordinates, or a point on the slide. If the action is expressed in lowercase, the point(s) are to be interpreted as relative coordinates, or an
        /// offset from the current position.
        /// Action Meaning
        /// M = move to This action requires a point specified by two coordinates.
        /// Move to will move the object to the specified point. It does not animate the object to that point; rather, the object will snap to the given point.
        /// L = line to This action requires a point specified by two coordinates.
        /// Line to will move the object to the specified point along the shortest line between the current point and the specified point.
        /// C = curve to This action requires three points specified by six coordinates.
        /// Curve to will move the object along a cubic Bezier curve specified by the current point and the three provided points.
        /// Z=close loop This action requires no points.
        /// Close loop will move the object back to where it was before the path began along the shortest line between the current point and the
        /// starting point.
        /// The relative and absolute versions of this action are identical.
        /// E=end This action requires no points.
        /// End will terminate the motion path. Any action specified in the string after the End action is ignored. If this action is not present at the end
        /// of a string and the string ends, this action will be implied.
        /// The relative and absolute versions of this action are identical.
        /// Thus the total allowed set is {M,L,C,Z,E,m,l,c,z,e).
        /// Points are expressed as normalized values of the slide size, for example, 1,1 means the lowerright corner of the slide in absolute coordinates,
        /// or the slide width and height in relative coordinates. Expressing a coordinate less than 1 but greater than 0 MUST be prefixed with 0 before
        /// the decimal point.
        /// Formulas can also be used for any coordinate. To use a formula, the entire formula MUST be inside parentheses. Formula syntax is specified
        /// in the varFormula field of the TimeAnimationValueListEntry record.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .timeVariant && nextAtom1.recInstance == 0x001 {
            self.varPath = try TimeVariantString(dataStream: &dataStream)
        } else {
            self.varPath =  nil
        }
        
        /// reserved (13 bytes): An optional TimeVariantInt record that MUST be ignored.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .timeVariant {
            self.reserved = try TimeVariantInt(dataStream: &dataStream)
        } else {
            self.reserved =  nil
        }
        
        /// timeBehavior (variable): A TimeBehaviorContainer record (section 2.8.34) that specifies the common behavior information.
        self.timeBehavior = try TimeBehaviorContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
