//
//  REFERENCE.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.2.1 REFERENCE Record
/// Specifies a reference to an Automation type library or VBA project.
public struct REFERENCE {
    public let nameRecord: REFERENCENAME?
    public let referenceRecord: ReferenceRecord
    
    public init(dataStream: inout DataStream) throws {
        /// NameRecord (variable): A REFERENCENAME Record (section 2.3.4.2.2.2) that specifies the name of the referenced VBA project or
        /// Automation type library. This field is optional.
        if try dataStream.peek(endianess: .littleEndian) as UInt16 == 0x0016 {
            self.nameRecord = try REFERENCENAME(dataStream: &dataStream)
        } else {
            self.nameRecord = nil
        }
        
        /// ReferenceRecord (variable): The type of ReferenceRecord is determined by the unsigned 16-bit integer beginning this field. The meanings
        /// of the possible values are listed in the following table:
        self.referenceRecord = try ReferenceRecord(dataStream: &dataStream)
    }
    
    public enum ReferenceRecord {
        /// 0x002F ReferenceRecord is a REFERENCECONTROL (section 2.3.4.2.2.3).
        case referenceControl(data: REFERENCECONTROL)
        
        /// 0x0033 ReferenceRecord is a REFERENCEORIGINAL (section 2.3.4.2.2.4).
        case referenceOriginal(data: REFERENCEORIGINAL)
        
        /// 0x000D ReferenceRecord is a REFERENCEREGISTERED (section 2.3.4.2.2.5).
        case referenceRegistered(data: REFERENCEREGISTERED)

        /// 0x000E ReferenceRecord is a REFERENCEPROJECT (section 2.3.4.2.2.6).
        case referenceProject(data: REFERENCEPROJECT)
        
        public init(dataStream: inout DataStream) throws {
            switch try dataStream.peek(endianess: .littleEndian) as UInt16 {
            case 0x002F:
                self = .referenceControl(data: try REFERENCECONTROL(dataStream: &dataStream))
            case 0x0033:
                self = .referenceOriginal(data: try REFERENCEORIGINAL(dataStream: &dataStream))
            case 0x000D:
                self = .referenceRegistered(data: try REFERENCEREGISTERED(dataStream: &dataStream))
            case 0x000E:
                self = .referenceProject(data: try REFERENCEPROJECT(dataStream: &dataStream))
            default:
                throw OfficeFileError.corrupted
            }
        }
    }
}
