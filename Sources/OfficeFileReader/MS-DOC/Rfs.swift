//
//  Rfs.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.227 Rfs
/// The Rfs structure specifies record filtering and the other mail merge properties.
public struct Rfs {
    public let fShowData: Bool
    public let grfChkErr: ErrorCheckingAndReportingSetting
    public let fManDocSetup: Bool
    public let fMailAsText: Bool
    public let unused1: Bool
    public let fDefaultSQL: Bool
    public let fMailAsHtml: Bool
    public let unused2: UInt8
    public let hsttbRfs: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fShowData (1 bit): Specifies whether the data are shown in the merged fields. If this value is set to zero, only the merged field names are shown.
        self.fShowData = flags.readBit()
        
        /// B - grfChkErr (2 bits): An integer that specifies the settings for error checking and reporting. It MUST be one of the following values.
        let grfChkErrRaw = UInt8(flags.readBits(count: 2))
        guard let grfChkErr = ErrorCheckingAndReportingSetting(rawValue: grfChkErrRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.grfChkErr = grfChkErr
        
        /// C - fManDocSetup (1 bit): Specifies whether the main document envelope or mailing labels are set up.
        self.fManDocSetup = flags.readBit()
        
        /// D - fMailAsText (1 bit): Specifies whether the e-mail message is in plain text format.
        self.fMailAsText = flags.readBit()
        
        /// E - unused1 (1 bit): This bit is undefined and MUST be ignored.
        self.unused1 = flags.readBit()
        
        /// F - fDefaultSQL (1 bit): Specifies whether the default SQL query string is "SELECT * FROM x".
        self.fDefaultSQL = flags.readBit()
        
        /// G - fMailAsHtml (1 bit): Specifies whether the e-mail message is in HTML format.
        self.fMailAsHtml = flags.readBit()
        
        /// unused2 (8 bits): This field is undefined and MUST be ignored.
        self.unused2 = UInt8(flags.readRemainingBits())
        
        /// hsttbRfs (2 bytes): An unsigned integer that specifies whether SttbfRfs exists in Pms. If SttbfRfs does not exist in Pms, hsttbRfs MUST be zero.
        /// If Pms contains SttbfRfs, hsttbRfs MUST be nonzero (any nonzero value).
        self.hsttbRfs = try dataStream.read(endianess: .littleEndian)
    }
    
    /// B - grfChkErr (2 bits): An integer that specifies the settings for error checking and reporting. It MUST be one of the following values.
    public enum ErrorCheckingAndReportingSetting: UInt8 {
        /// 0 Simulate the merge and report errors in a new document.
        case simulateMergeAndReportErrorsInNewDocument = 0
        
        /// 1 Complete the merge and pause to report errors.
        case completeMergeAndPauseToReportErrors = 1
        
        /// 2 Complete the merge and report errors in a new document.
        case completeMergeAndReportErrorsInNewDocument = 2
    }
}
