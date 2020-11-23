//
//  OfficeArtClientDataPpt.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.3 OfficeArtClientData
/// A container record that specifies information about a shape.
public struct OfficeArtClientDataPpt {
    public let rh: OfficeArtRecordHeader
    public let shapeFlagsAtom: ShapeFlagsAtom?
    public let shapeFlags10Atom: ShapeFlags10Atom?
    public let exObjRefAtom: ExObjRefAtom?
    public let animationInfo: AnimationInfoContainer?
    public let mouseClickInteractiveInfo: MouseClickInteractiveInfoContainer?
    public let mouseOverInteractiveInfo: MouseOverInteractiveInfoContainer?
    public let placeholderAtom: PlaceholderAtom?
    public let recolorInfoAtom: RecolorInfoAtom?
    public let rgShapeClientRoundtripData: [ShapeClientRoundtripDataSubContainerOrAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader ([MS-ODRAW] section 2.2.1) that specifies the header for this record. Sub-fields are further
        /// specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be 0xF011.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF011 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.shapeFlagsAtom = nil
            self.shapeFlags10Atom = nil
            self.exObjRefAtom = nil
            self.animationInfo = nil
            self.mouseClickInteractiveInfo = nil
            self.mouseOverInteractiveInfo = nil
            self.placeholderAtom = nil
            self.recolorInfoAtom = nil
            self.rgShapeClientRoundtripData = []
            return
        }
        
        /// shapeFlagsAtom (9 bytes): An optional ShapeFlagsAtom record that specifies flags for the shape.
        if try dataStream.peekRecordHeader().recType == .shapeAtom {
            self.shapeFlagsAtom = try ShapeFlagsAtom(dataStream: &dataStream)
        } else {
            self.shapeFlagsAtom = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.shapeFlags10Atom = nil
            self.exObjRefAtom = nil
            self.animationInfo = nil
            self.mouseClickInteractiveInfo = nil
            self.mouseOverInteractiveInfo = nil
            self.placeholderAtom = nil
            self.recolorInfoAtom = nil
            self.rgShapeClientRoundtripData = []
            return
        }
        
        /// shapeFlags10Atom (9 bytes): An optional ShapeFlags10Atom record that specifies flags for the shape.
        if try dataStream.peekRecordHeader().recType == .shapeFlags10Atom {
            self.shapeFlags10Atom = try ShapeFlags10Atom(dataStream: &dataStream)
        } else {
            self.shapeFlags10Atom = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.exObjRefAtom = nil
            self.animationInfo = nil
            self.mouseClickInteractiveInfo = nil
            self.mouseOverInteractiveInfo = nil
            self.placeholderAtom = nil
            self.recolorInfoAtom = nil
            self.rgShapeClientRoundtripData = []
            return
        }
        
        /// exObjRefAtom (12 bytes): An optional ExObjRefAtom record that specifies a reference to an external object.
        if try dataStream.peekRecordHeader().recType == .externalObjectRefAtom {
            self.exObjRefAtom = try ExObjRefAtom(dataStream: &dataStream)
        } else {
            self.exObjRefAtom = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.animationInfo = nil
            self.mouseClickInteractiveInfo = nil
            self.mouseOverInteractiveInfo = nil
            self.placeholderAtom = nil
            self.recolorInfoAtom = nil
            self.rgShapeClientRoundtripData = []
            return
        }
        
        /// animationInfo (variable): An optional AnimationInfoContainer record that specifies animation information for the shape.
        if try dataStream.peekRecordHeader().recType == .animationInfo {
            self.animationInfo = try AnimationInfoContainer(dataStream: &dataStream)
        } else {
            self.animationInfo = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.mouseClickInteractiveInfo = nil
            self.mouseOverInteractiveInfo = nil
            self.placeholderAtom = nil
            self.recolorInfoAtom = nil
            self.rgShapeClientRoundtripData = []
            return
        }
        
        /// mouseClickInteractiveInfo (variable): An optional MouseClickInteractiveInfoContainer record that specifies information about interacting
        /// with the shape by clicking the mouse on the shape.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .interactiveInfo && nextAtom1.recInstance == 0x000 {
            self.mouseClickInteractiveInfo = try MouseClickInteractiveInfoContainer(dataStream: &dataStream)
        } else {
            self.mouseClickInteractiveInfo = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.mouseOverInteractiveInfo = nil
            self.placeholderAtom = nil
            self.recolorInfoAtom = nil
            self.rgShapeClientRoundtripData = []
            return
        }
        
        /// mouseOverInteractiveInfo (variable): An optional MouseOverInteractiveInfoContainer record that specifies information about interacting
        /// with the shape by moving the mouse over the shape.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .interactiveInfo && nextAtom2.recInstance == 0x001 {
            self.mouseOverInteractiveInfo = try MouseOverInteractiveInfoContainer(dataStream: &dataStream)
        } else {
            self.mouseOverInteractiveInfo = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.placeholderAtom = nil
            self.recolorInfoAtom = nil
            self.rgShapeClientRoundtripData = []
            return
        }
        
        /// placeholderAtom (16 bytes): An optional PlaceholderAtom record that specifies whether the shape is a placeholder shape.
        if try dataStream.peekRecordHeader().recType == .placeholderAtom {
            self.placeholderAtom = try PlaceholderAtom(dataStream: &dataStream)
        } else {
            self.placeholderAtom = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.recolorInfoAtom = nil
            self.rgShapeClientRoundtripData = []
            return
        }
        
        /// recolorInfoAtom (variable): An optional RecolorInfoAtom record that specifies a collection of recolor mappings for the shape.
        if try dataStream.peekRecordHeader().recType == .recolorInfoAtom {
            self.recolorInfoAtom = try RecolorInfoAtom(dataStream: &dataStream)
        } else {
            self.recolorInfoAtom = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.rgShapeClientRoundtripData = []
            return
        }
        
        /// rgShapeClientRoundtripData (variable): An array of ShapeClientRoundtripDataSubContainerOrAtom records that specifies additional
        /// information about a shape. The array continues while rh.recType of the ShapeClientRoundtripDataSubContainerOrAtom item is equal
        /// to one of the following record types: RT_ProgTags, RT_RoundTripNewPlaceholderId12Atom, RT_RoundTripShapeId12Atom,
        /// RT_RoundTripHFPlaceholder12Atom, or RT_RoundTripShapeCheckSumForCL12Atom. Each record type MUST NOT appear more than
        /// once.
        var rgShapeClientRoundtripData: [ShapeClientRoundtripDataSubContainerOrAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let recordHeader = try dataStream.peekRecordHeader()
            guard recordHeader.recType == .progTags ||
                    recordHeader.recType == .roundTripNewPlaceholderId12Atom ||
                    recordHeader.recType == .roundTripShapeId12Atom ||
                    recordHeader.recType == .roundTripHFPlaceholder12Atom ||
                    recordHeader.recType == .roundTripShapeCheckSumForCL12Atom else {
                break
            }
            
            rgShapeClientRoundtripData.append(try ShapeClientRoundtripDataSubContainerOrAtom(dataStream: &dataStream))
        }
        
        self.rgShapeClientRoundtripData = rgShapeClientRoundtripData
        
        try dataStream.skipUnknownRecords(startPosition: startPosition, length: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
