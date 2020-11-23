//
//  OfficeArtDgContainer.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.13 OfficeArtDgContainer
/// The OfficeArtDgContainer record specifies the container for all the file records for the objects in a drawing
public struct OfficeArtDgContainer {
    public let rh: OfficeArtRecordHeader
    public let drawingData: OfficeArtFDG?
    public let regroupItems: OfficeArtFRITContainer?
    public let groupShape: OfficeArtSpgrContainer?
    public let shape: OfficeArtSpContainer?
    public let solvers1: OfficeArtSolverContainer?
    public let deletedShapes: [OfficeArtSpgrContainerFileBlock]
    public let solvers2: OfficeArtSolverContainer?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0xF.
        /// rh.recInstance A value that MUST be 0x000.
        /// rh.recType A value that MUST be 0xF002.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header that contain drawingwide file records.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF002 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.drawingData = nil
            self.regroupItems = nil
            self.groupShape = nil
            self.shape = nil
            self.solvers1 = nil
            self.deletedShapes = []
            self.solvers2 = nil
            return
        }
        
        /// drawingData (16 bytes): An OfficeArtFDG record, as defined in section 2.2.49, that specifies the shape count, drawing identifier, and shape
        /// identifier of the last shape in this drawing.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF008 {
            self.drawingData = try OfficeArtFDG(dataStream: &dataStream)
        } else {
            self.drawingData = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.regroupItems = nil
            self.groupShape = nil
            self.shape = nil
            self.solvers1 = nil
            self.deletedShapes = []
            self.solvers2 = nil
            return
        }
        
        /// regroupItems (variable): An OfficeArtFRITContainer record, as defined in section 2.2.41, that specifies a container for the table of group identifiers
        /// for regrouping ungrouped shapes.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF118 {
            self.regroupItems = try OfficeArtFRITContainer(dataStream: &dataStream)
        } else {
            self.regroupItems = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.groupShape = nil
            self.shape = nil
            self.solvers1 = nil
            self.deletedShapes = []
            self.solvers2 = nil
            return
        }
        
        /// groupShape (variable): An OfficeArtSpgrContainer record, as defined in section 2.2.16, that specifies a container for groups of shapes.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF003 {
            self.groupShape = try OfficeArtSpgrContainer(dataStream: &dataStream)
        } else {
            self.groupShape = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.shape = nil
            self.solvers1 = nil
            self.deletedShapes = []
            self.solvers2 = nil
            return
        }
        
        /// shape (variable): An OfficeArtSpContainer record, as defined in section 2.2.14, that specifies a container for the shapes that are not contained
        /// in a group.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF004 {
            self.shape = try OfficeArtSpContainer(dataStream: &dataStream)
        } else {
            self.shape = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.solvers1 = nil
            self.deletedShapes = []
            self.solvers2 = nil
            return
        }
        
        /// solvers1 (variable): An OfficeArtSolverContainer record, as defined in section 2.2.18, that specifies a container for the rules that are applicable
        /// to the shapes contained in this drawing.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF005 {
            self.solvers1 = try OfficeArtSolverContainer(dataStream: &dataStream)
        } else {
            self.solvers1 = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.deletedShapes = []
            self.solvers2 = nil
            return
        }
        
        /// deletedShapes (variable): An array of OfficeArtSpgrContainerFileBlock records, as defined in section 2.2.17, that specifies the deleted shapes.
        /// For more information, see section 2.2.37. The array continues if the rh.recType field of the OfficeArtSpgrContainerFileBlock record, as
        /// defined in section 2.2.17, equals 0xF003 or 0xF004. This array MAY<3> exist.
        var deletedShapes: [OfficeArtSpgrContainerFileBlock] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let record = try dataStream.peekOfficeArtRecordHeader()
            guard record.recType == 0xF003 || record.recType == 0xF004 else {
                break
            }
            
            deletedShapes.append(try OfficeArtSpgrContainerFileBlock(dataStream: &dataStream))
        }
        
        self.deletedShapes = deletedShapes
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.solvers2 = nil
            return
        }
        
        /// solvers2 (variable): An OfficeArtSolverContainer record, as defined in section 2.2.18, that specifies a container for additional rules that are
        /// applicable to the shapes contained in this drawing.
        if try dataStream.peekOfficeArtRecordHeader().recType == 0xF005 {
            self.solvers2 = try OfficeArtSolverContainer(dataStream: &dataStream)
        } else {
            self.solvers2 = nil
        }

        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
