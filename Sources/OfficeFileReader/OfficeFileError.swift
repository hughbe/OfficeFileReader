//
//  DocFileError.swift
//  
//
//  Created by Hugh Bellamy on 05/11/2020.
//

public enum OfficeFileError: Error {
    case missingStream(name: String)
    case corrupted
}
