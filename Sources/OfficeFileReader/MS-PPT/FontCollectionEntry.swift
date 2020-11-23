//
//  FontCollectionEntry.swift
//  
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.9 FontCollectionEntry
/// Referenced by: FontCollection10Container, FontCollectionContainer
/// A structure that specifies information about a font contained in the presentation
public struct FontCollectionEntry {
    public let fontEntityAtom: FontEntityAtom
    public let fontEmbedData1: FontEmbedDataBlob?
    public let fontEmbedData2: FontEmbedDataBlob?
    public let fontEmbedData3: FontEmbedDataBlob?
    public let fontEmbedData4: FontEmbedDataBlob?
    
    public init(dataStream: inout DataStream, startPosition: Int, size: Int) throws {
        /// fontEntityAtom (76 bytes): A FontEntityAtom record that specifies the required attributes of the font.
        self.fontEntityAtom = try FontEntityAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == size {
            self.fontEmbedData1 = nil
            self.fontEmbedData2 = nil
            self.fontEmbedData3 = nil
            self.fontEmbedData4 = nil
            return
        }
        
        /// fontEmbedData1 (variable): An optional FontEmbedDataBlob record that specifies the plain style data of an embedded font.
        if try dataStream.peekRecordHeader().recType == .fontEmbedDataBlob {
            self.fontEmbedData1 = try FontEmbedDataBlob(dataStream: &dataStream)
        } else {
            self.fontEmbedData1 = nil
        }
        
        if dataStream.position - startPosition == size {
            self.fontEmbedData2 = nil
            self.fontEmbedData3 = nil
            self.fontEmbedData4 = nil
            return
        }
        
        /// fontEmbedData2 (variable): An optional FontEmbedDataBlob record that specifies the bold style data of an embedded font.
        if try dataStream.peekRecordHeader().recType == .fontEmbedDataBlob {
            self.fontEmbedData2 = try FontEmbedDataBlob(dataStream: &dataStream)
        } else {
            self.fontEmbedData2 = nil
        }
        
        if dataStream.position - startPosition == size {
            self.fontEmbedData3 = nil
            self.fontEmbedData4 = nil
            return
        }
        
        /// fontEmbedData3 (variable): An optional FontEmbedDataBlob record that specifies the italic style data of an embedded font.
        if try dataStream.peekRecordHeader().recType == .fontEmbedDataBlob {
            self.fontEmbedData3 = try FontEmbedDataBlob(dataStream: &dataStream)
        } else {
            self.fontEmbedData3 = nil
        }
        
        if dataStream.position - startPosition == size {
            self.fontEmbedData4 = nil
            return
        }
        
        /// fontEmbedData4 (variable): An optional FontEmbedDataBlob record that specifies the bold and italic style data of an embedded font.
        if try dataStream.peekRecordHeader().recType == .fontEmbedDataBlob {
            self.fontEmbedData4 = try FontEmbedDataBlob(dataStream: &dataStream)
        } else {
            self.fontEmbedData4 = nil
        }
    }
}
