//
//  Paragraph.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

public struct Paragraph {
    private let document: DocFile
    private let textPosition: UInt32
    private let count: UInt32
    private let fc: FileCharacterPosition
    private let papxInFkp: PapxInFkp
    
    internal init(document: DocFile, textPosition: UInt32, count: UInt32, fc: FileCharacterPosition, papxInFkp: PapxInFkp) {
        self.document = document
        self.textPosition = textPosition
        self.count = count
        self.fc = fc
        self.papxInFkp = papxInFkp
    }
    
    public var text: String {
        guard let text = document.characters?.text else {
            return ""
        }

        let startPosition = text.index(text.startIndex, offsetBy: Int(textPosition))
        let endPosition = text.index(text.startIndex, offsetBy: Int(textPosition + count))
        return String(text[startPosition..<endPosition])
    }
}
