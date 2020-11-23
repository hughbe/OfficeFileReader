//
//  AtrdExtra.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.5 AtrdExtra
/// The AtrdExtra structure is an array of information about comments that are kept parallel to the array of ATRDPre10s in the PlcfandRef specified by
/// fcPlcfandRef in FibRgFcLcb97.
public struct AtrdExtra {
    public let commentTree: [ATRDPost10]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        /// commentTree (variable): An array of ATRDPost10s. The number of elements in this array MUST be equal to the number of ATRDPre10s in the
        /// PlcfandRef referenced by the fcPlcfandRef member of FibRgFcLcb97. This array is a tree that contains information about the comments in the
        /// document.
        /// The order of the comments in this array is determined by a pre-order traversal of the comment tree. A comment is considered a parent of a
        /// second comment if the second is a comment on the first. The depth of the comment in the tree is specified by cDepth in ATRDPost10. The
        /// location of the parent comment is specified by diatrdParent in ATRDPost10.
        var commentTree: [ATRDPost10] = []
        while dataStream.position - startPosition < size {
            commentTree.append(try ATRDPost10(dataStream: &dataStream))
        }
        
        self.commentTree = commentTree
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
