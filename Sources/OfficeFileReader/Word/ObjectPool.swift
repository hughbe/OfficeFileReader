//
//  ObjectPool.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import CompoundFileReader
import DataStream
import OleDataTypes

/// [MS-DOC] 2.1.4 ObjectPool Storage
/// The Object Pool storage contains storages for embedded OLE objects. This storage need not be present if there are no embedded OLE objects
/// in the document.
public struct ObjectPool {
    public let embeddedObjects: [EmbeddedOleObject]
    
    internal init(storage: CompoundFileStorage) throws {
        var storage = storage

        var embeddedObjects: [EmbeddedOleObject] = []
        embeddedObjects.reserveCapacity(storage.children.count)
        for child in storage.children.values {
            embeddedObjects.append(try EmbeddedOleObject(storage: child))
        }
        
        self.embeddedObjects = embeddedObjects
    }
    
    public struct EmbeddedOleObject {
        public let printStream: PrintStream?
        public let ePrintStream: PrintStream?
        public let oleStream: OLEStream?
        public let compObjStream: CompObjStream?
        public let objInfo: ODT?
        public let oleNativeStream: OLENativeStream?
        public let oleItemName: LengthPrefixedAnsiString?
        
        internal init(storage: CompoundFileStorage) throws {
            var storage = storage
            
            /// [MS-DOC] 2.1.4.2 Print Stream
            /// Each storage within the ObjectPool storage optionally contains a stream whose name is "\003PRINT" where \003 is the character
            /// with value 0x0003, not the string literal "\003". This stream contains an MFPF followed immediately by a Metafile as specified in
            /// [MS-WMF]. If no PRINT or EPRINT stream is present, then the object does not have a print presentation distinct from its screen
            /// presentation.
            if let child = storage.children["\u{0003}PRINT"] {
                var dataStream = child.dataStream
                self.printStream = try PrintStream(dataStream: &dataStream, count: dataStream.count)
            } else {
                self.printStream = nil
            }
            
            /// [MS-DOC] 2.1.4.3 EPrint Stream
            /// Each storage within the ObjectPool storage optionally contains a stream whose name is "\003EPRINT" where \003 is the character
            /// with value 0x0003, not the string literal "\003".<2> This stream contains an Enhanced Metafile, as specified in [MS-EMF], to be
            /// used when printing the object. If no EPRINT or PRINT stream is present, then the object does not have a print presentation distinct
            /// from its screen presentation.
            if let child = storage.children["\u{0003}EPRINT"] {
                var dataStream = child.dataStream
                self.ePrintStream = try PrintStream(dataStream: &dataStream, count: dataStream.count)
            } else {
                self.ePrintStream = nil
            }
            
            if let child = storage.children["\u{0001}Ole"] {
                var dataStream = child.dataStream
                self.oleStream = try OLEStream(dataStream: &dataStream, count: dataStream.count)
            } else {
                self.oleStream = nil
            }
            
            if let child = storage.children["\u{0001}CompObj"] {
                var dataStream = child.dataStream
                self.compObjStream = try CompObjStream(dataStream: &dataStream, count: dataStream.count)
            } else {
                self.compObjStream = nil
            }
            
            /// [MS-DOC] 2.1.4.1 ObjInfo Stream
            /// Each storage within the ObjectPool storage contains a stream whose name is "\003ObjInfo" where \003 is the character with value
            /// 0x0003, not the string literal "\003". This stream contains an ODT structure which specifies information about that embedded
            /// OLE object.
            if let child = storage.children["\u{0003}ObjInfo"] {
                var dataStream = child.dataStream
                self.objInfo = try ODT(dataStream: &dataStream, count: dataStream.count)
            } else {
                self.objInfo = nil
            }

            if let child = storage.children["\u{0001}Ole10Native"] {
                var dataStream = child.dataStream
                self.oleNativeStream = try OLENativeStream(dataStream: &dataStream, count: dataStream.count)
            } else {
                self.oleNativeStream = nil
            }
            
            if let child = storage.children["\u{0001}Ole10ItemName"] {
                var dataStream = child.dataStream
                self.oleItemName = try LengthPrefixedAnsiString(dataStream: &dataStream)
            } else {
                self.oleItemName = nil
            }
        }
        
        /// [MS-DOC] 2.1.4.2 Print Stream
        /// Each storage within the ObjectPool storage optionally contains a stream whose name is "\003PRINT" where \003 is the character
        /// with value 0x0003, not the string literal "\003". This stream contains an MFPF followed immediately by a Metafile as specified in
        /// [MS-WMF]. If no PRINT or EPRINT stream is present, then the object does not have a print presentation distinct from its screen
        /// presentation.
        public struct PrintStream {
            public let type: MFPF
            public let metafile: [UInt8]
            
            public init(dataStream: inout DataStream, count: Int) throws {
                let startPosition = dataStream.position
                
                guard count >= 8 else {
                    throw OfficeFileError.corrupted
                }

                self.type = try MFPF(dataStream: &dataStream)
                
                let remainingBytes = count - (dataStream.position - startPosition)
                self.metafile = try dataStream.readBytes(count: remainingBytes)
            }
        }
    }
}
