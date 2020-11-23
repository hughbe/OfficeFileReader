//
//  MouseClickInteractiveInfoContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.6.8 MouseClickInteractiveInfoContainer
/// Referenced by: InteractiveInfoInstance, OfficeArtClientData
/// A container record that specifies what actions to perform when interacting with an object by means of a mouse click.
public struct MouseClickInteractiveInfoContainer {
    public let rh: RecordHeader
    public let interactiveInfoAtom: InteractiveInfoAtom
    public let macroNameAtom: MacroNameAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_InteractiveInfo.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .interactiveInfo else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// interactiveInfoAtom (24 bytes): An InteractiveInfoAtom record that specifies the type of action to be performed.
        self.interactiveInfoAtom = try InteractiveInfoAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.macroNameAtom = nil
            return
        }
        
        /// macroNameAtom (variable): An optional MacroNameAtom record that specifies the name of a macro, a file name, or a named show.
        /// It MUST be ignored unless interactiveInfoAtom.action is equal to "II_MacroAction", "II_RunProgramAction", or "II_CustomShowAction".
        self.macroNameAtom = try MacroNameAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
