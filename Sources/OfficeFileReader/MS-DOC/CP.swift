//
//  CP.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import Foundation

/// [MS-DOC] 2.2 Fundamental Concepts
/// [MS-DOC] 2.2.1 Character Position (CP)
/// A character position, which is also known as a CP, is an unsigned 32-bit integer that serves as the zero-based index of a character in the
/// document text. There is no requirement that the text at consecutive character positions be at adjacent locations in the file. The size of each
/// character in the file also varies. The location and size of each character in the file can be computed using the algorithm in section 2.4.1
/// (Retrieving Text).
/// Characters include the text of the document, anchors for objects such as footnotes or textboxes, and control characters such as paragraph
/// marks and table cell marks.
/// Unless otherwise specified by a particular usage, a CP MUST be greater than or equal to zero and less than 0x7FFFFFFF. The range of valid
/// character positions in a particular document is given by the algorithm in section 2.4.1 (Retrieving Text).
public typealias CP = UInt32
