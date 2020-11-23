//
//  OfficeArtSpContainer.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.14 OfficeArtSpContainer
/// Referenced by: OfficeArtDgContainer, OfficeArtInlineSpContainer, OfficeArtSpgrContainerFileBlock
/// The OfficeArtSpContainer record specifies a shape container.
public struct OfficeArtSpContainer {
    public let rh: OfficeArtRecordHeader
    public let shapeGroup: OfficeArtFSPGR?
    public let shapeProp: OfficeArtFSP?
    public let deletedShape: OfficeArtFPSPL?
    public let shapePrimaryOptions: OfficeArtFOPT?
    public let shapeSecondaryOptions1: OfficeArtSecondaryFOPT?
    public let shapeTertiaryOptions1: OfficeArtTertiaryFOPT?
    public let childAnchor: OfficeArtChildAnchor?
    public let clientAnchor: OfficeArtClientAnchorPpt?
    public let clientData: OfficeArtClientData?
    public let clientTextbox: OfficeArtClientTextboxPpt?
    public let shapeSecondaryOptions2: OfficeArtSecondaryFOPT?
    public let shapeTertiaryOptions2: OfficeArtTertiaryFOPT?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1 that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0xF.
        /// rh.recInstance A value that MUST be 0x000.
        /// rh.recType A value that MUST be 0xF004.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header that contain shape records.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// shapeGroup (24 bytes): An OfficeArtFSPGR record, as defined in section 2.2.38, that specifies the coordinate system of the group shape.
        /// The anchors of the child shape are expressed in this coordinate system. This record’s container MUST be a group shape.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF009 {
            self.shapeGroup = try OfficeArtFSPGR(dataStream: &dataStream)
        } else {
            self.shapeGroup = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.shapeProp = nil
            self.deletedShape = nil
            self.shapePrimaryOptions = nil
            self.shapeSecondaryOptions1 = nil
            self.shapeTertiaryOptions1 = nil
            self.childAnchor = nil
            self.clientAnchor = nil
            self.clientData = nil
            self.clientTextbox = nil
            self.shapeSecondaryOptions2 = nil
            self.shapeTertiaryOptions2 = nil
            return
        }
        
        /// shapeProp (16 bytes): An OfficeArtFSP record, as defined in section 2.2.40, that specifies an instance of a shape.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF00A {
            self.shapeProp = try OfficeArtFSP(dataStream: &dataStream)
        } else {
            self.shapeProp = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.deletedShape = nil
            self.shapePrimaryOptions = nil
            self.shapeSecondaryOptions1 = nil
            self.shapeTertiaryOptions1 = nil
            self.childAnchor = nil
            self.clientAnchor = nil
            self.clientData = nil
            self.clientTextbox = nil
            self.shapeSecondaryOptions2 = nil
            self.shapeTertiaryOptions2 = nil
            return
        }
        
        /// deletedShape (12 bytes): An OfficeArtFPSPL record, as defined in section 2.2.37, that specifies the former hierarchical position of the
        /// containing object. This record’s container MUST be a deleted shape. For more information, see OfficeArtFPSPL.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF11D {
            self.deletedShape = try OfficeArtFPSPL(dataStream: &dataStream)
        } else {
            self.deletedShape = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.shapePrimaryOptions = nil
            self.shapeSecondaryOptions1 = nil
            self.shapeTertiaryOptions1 = nil
            self.childAnchor = nil
            self.clientAnchor = nil
            self.clientData = nil
            self.clientTextbox = nil
            self.shapeSecondaryOptions2 = nil
            self.shapeTertiaryOptions2 = nil
            return
        }
        
        /// shapePrimaryOptions (variable): An OfficeArtFOPT record, as defined in section 2.2.9, that specifies the properties of this shape that
        /// do not contain default values.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF00B {
            self.shapePrimaryOptions = try OfficeArtFOPT(dataStream: &dataStream)
        } else {
            self.shapePrimaryOptions = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.shapeSecondaryOptions1 = nil
            self.shapeTertiaryOptions1 = nil
            self.childAnchor = nil
            self.clientAnchor = nil
            self.clientData = nil
            self.clientTextbox = nil
            self.shapeSecondaryOptions2 = nil
            self.shapeTertiaryOptions2 = nil
            return
        }
        
        /// shapeSecondaryOptions1 (variable): An OfficeArtSecondaryFOPT record, as defined in section 2.2.10, that specifies the properties of this
        /// shape that do not contain default values.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF121 {
            self.shapeSecondaryOptions1 = try OfficeArtSecondaryFOPT(dataStream: &dataStream)
        } else {
            self.shapeSecondaryOptions1 = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.shapeTertiaryOptions1 = nil
            self.childAnchor = nil
            self.clientAnchor = nil
            self.clientData = nil
            self.clientTextbox = nil
            self.shapeSecondaryOptions2 = nil
            self.shapeTertiaryOptions2 = nil
            return
        }
        
        /// shapeTertiaryOptions1 (variable): An OfficeArtTertiaryFOPT record, as defined in section 2.2.11, that specifies the properties of this shape
        /// that do not contain default values.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF122 {
            self.shapeTertiaryOptions1 = try OfficeArtTertiaryFOPT(dataStream: &dataStream)
        } else {
            self.shapeTertiaryOptions1 = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.childAnchor = nil
            self.clientAnchor = nil
            self.clientData = nil
            self.clientTextbox = nil
            self.shapeSecondaryOptions2 = nil
            self.shapeTertiaryOptions2 = nil
            return
        }
        
        /// childAnchor (24 bytes): An OfficeArtChildAnchor record, as defined in section 2.2.39, that specifies the anchor for this shape. This record’s
        /// container MUST be a member of a group of shapes.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF00F {
            self.childAnchor = try OfficeArtChildAnchor(dataStream: &dataStream)
        } else {
            self.childAnchor = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.clientAnchor = nil
            self.clientData = nil
            self.clientTextbox = nil
            self.shapeSecondaryOptions2 = nil
            self.shapeTertiaryOptions2 = nil
            return
        }
        
        /// clientAnchor (variable): An OfficeArtClientAnchor ([MS-PPT] section 2.7.1) record as specified by the host application.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF010 {
            self.clientAnchor = try OfficeArtClientAnchorPpt(dataStream: &dataStream)
        } else {
            self.clientAnchor = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.clientData = nil
            self.clientTextbox = nil
            self.shapeSecondaryOptions2 = nil
            self.shapeTertiaryOptions2 = nil
            return
        }
        
        /// clientData (variable): An OfficeArtClientData ([MS-PPT] section 2.7.3) record as specified by the host application.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF011 {
            self.clientData = try OfficeArtClientData(dataStream: &dataStream)
        } else {
            self.clientData = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.clientTextbox = nil
            self.shapeSecondaryOptions2 = nil
            self.shapeTertiaryOptions2 = nil
            return
        }
        
        /// clientTextbox (variable): An OfficeArtClientTextbox ([MS-PPT] section 2.9.76) record as specified by the host application.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF00D {
            self.clientTextbox = try OfficeArtClientTextboxPpt(dataStream: &dataStream)
        } else {
            self.clientTextbox = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.shapeSecondaryOptions2 = nil
            self.shapeTertiaryOptions2 = nil
            return
        }
    
        /// shapeSecondaryOptions2 (variable): An OfficeArtSecondaryFOPT record that specifies the properties of this shape that do not contain
        /// default values. This field MUST NOT exist if shapeSecondaryOptions1 exists.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF121 {
            self.shapeSecondaryOptions2 = try OfficeArtSecondaryFOPT(dataStream: &dataStream)
        } else {
            self.shapeSecondaryOptions2 = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.shapeTertiaryOptions2 = nil
            return
        }
        
        /// shapeTertiaryOptions2 (variable): An OfficeArtTertiaryFOPT record, as defined in section 2.2.11, that specifies the properties of this
        /// shape that do not contain default values. This field MUST NOT exist if shapeTertiaryOptions1 exists.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF122 {
            self.shapeTertiaryOptions2 = try OfficeArtTertiaryFOPT(dataStream: &dataStream)
        } else {
            self.shapeTertiaryOptions2 = nil
        }

        /*
        
        var shapeGroup: OfficeArtFSPGR?
        var shapeProp: OfficeArtFSP?
        var deletedShape: OfficeArtFPSPL?
        var shapePrimaryOptions: OfficeArtFOPT?
        var shapeSecondaryOptions1: OfficeArtSecondaryFOPT?
        var shapeTertiaryOptions1: OfficeArtTertiaryFOPT?
        var childAnchor: OfficeArtChildAnchor?
        var clientAnchor: OfficeArtClientAnchorPpt?
        var clientData: OfficeArtClientData?
        var clientTextbox: OfficeArtClientTextboxPpt?
        var shapeSecondaryOptions2: OfficeArtSecondaryFOPT?
        var shapeTertiaryOptions2: OfficeArtTertiaryFOPT?
        while dataStream.position - startPosition < self.rh.recLen {
            let record = try OfficeArtRecord(dataStream: &dataStream)
            switch record {
            case .fspgr(data: let data):
                /// shapeGroup (24 bytes): An OfficeArtFSPGR record, as defined in section 2.2.38, that specifies the coordinate system of the group shape.
                /// The anchors of the child shape are expressed in this coordinate system. This record’s container MUST be a group shape.
                shapeGroup = data
            case .fsp(data: let data):
                /// shapeProp (16 bytes): An OfficeArtFSP record, as defined in section 2.2.40, that specifies an instance of a shape.
                shapeProp = data
            case .fpspl(data: let data):
                /// deletedShape (12 bytes): An OfficeArtFPSPL record, as defined in section 2.2.37, that specifies the former hierarchical position of the
                /// containing object. This record’s container MUST be a deleted shape. For more information, see OfficeArtFPSPL.
                deletedShape = data
            case .fopt(data: let data):
                /// shapePrimaryOptions (variable): An OfficeArtFOPT record, as defined in section 2.2.9, that specifies the properties of this shape that
                /// do not contain default values.
                shapePrimaryOptions = data
            case .secondaryFOPT(data: let data):
                if shapeSecondaryOptions1 == nil {
                    /// shapeSecondaryOptions1 (variable): An OfficeArtSecondaryFOPT record, as defined in section 2.2.10, that specifies the properties of this
                    /// shape that do not contain default values.
                    shapeSecondaryOptions1 = data
                } else {
                    /// shapeSecondaryOptions2 (variable): An OfficeArtSecondaryFOPT record that specifies the properties of this shape that do not contain
                    /// default values. This field MUST NOT exist if shapeSecondaryOptions1 exists.
                    shapeSecondaryOptions2 = data
                }
            case .tertiaryFOPT(data: let data):
                if shapeTertiaryOptions1 == nil {
                    /// shapeTertiaryOptions1 (variable): An OfficeArtTertiaryFOPT record, as defined in section 2.2.11, that specifies the properties of this shape
                    /// that do not contain default values.
                    shapeTertiaryOptions1 = data
                } else {
                    /// shapeTertiaryOptions2 (variable): An OfficeArtTertiaryFOPT record, as defined in section 2.2.11, that specifies the properties of this
                    /// shape that do not contain default values. This field MUST NOT exist if shapeTertiaryOptions1 exists.
                    shapeTertiaryOptions2 = data
                }
            case .childAnchor(data: let data):
                /// childAnchor (24 bytes): An OfficeArtChildAnchor record, as defined in section 2.2.39, that specifies the anchor for this shape. This record’s
                /// container MUST be a member of a group of shapes.
                childAnchor = data
            case .clientAnchor(data: let data):
                /// clientAnchor (variable): An OfficeArtClientAnchor ([MS-PPT] section 2.7.1) record as specified by the host application.
                clientAnchor = data
            case .clientData(data: let data):
                /// clientData (variable): An OfficeArtClientData ([MS-PPT] section 2.7.3) record as specified by the host application.
                clientData = data
            case .clientTextbox(data: let data):
                /// clientTextbox (variable): An OfficeArtClientTextbox ([MS-PPT] section 2.9.76) record as specified by the host application.
                clientTextbox = data
            default:
                continue
            }
        }
        
        self.shapeGroup = shapeGroup
        self.shapeProp = shapeProp
        self.deletedShape = deletedShape
        self.shapePrimaryOptions = shapePrimaryOptions
        self.shapeSecondaryOptions1 = shapeSecondaryOptions1
        self.shapeTertiaryOptions1 = shapeTertiaryOptions1
        self.childAnchor = childAnchor
        self.clientAnchor = clientAnchor
        self.clientData = clientData
        self.clientTextbox = clientTextbox
        self.shapeSecondaryOptions2 = shapeSecondaryOptions2
        self.shapeTertiaryOptions2 = shapeTertiaryOptions2
         */
 
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
