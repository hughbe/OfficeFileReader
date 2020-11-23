//
//  Pmfs.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.204 Pmfs
/// The Pmfs structure specifies the mail merge data source connection properties.
public struct Pmfs {
    public let ipfnpmf: DataSource
    public let fLinkToFnm: Bool
    public let fLinkToConn: Bool
    public let fNoPromptQT: Bool
    public let fQuery: Bool
    public let unused: UInt8
    public let tkField: Int16
    public let tkRec: Int16
    public let fnpi: FNPI
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// ipfnpmf (8 bits): An unsigned integer value that specifies the type of data source for the mail merge. This MUST be one of the following values.
        let ipfnpmfRaw = UInt8(flags.readBits(count: 8))
        guard let ipfnpmf = DataSource(rawValue: ipfnpmfRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.ipfnpmf = ipfnpmf
        
        /// A - fLinkToFnm (1 bit): If the data source is not a data file, this bit MUST be ignored. ,When the data source is a data file, this bit specifies whether
        /// the file MUST exist as specified in fnpi.
        self.fLinkToFnm = flags.readBit()
        
        /// B - fLinkToConn (1 bit): Specifies whether an extra string is appended to the DDE initial connection string. This extra string is stored in the
        /// SttbfRfs structure in the Pms structure.
        self.fLinkToConn = flags.readBit()
        
        /// C - fNoPromptQT (1 bit): Specifies whether the user was already asked about whether to use Microsoft Query to edit ODBC.
        self.fNoPromptQT = flags.readBit()
        
        /// D - fQuery (1 bit): Specifies whether the mail merge uses a query (such as "SELECT * FROM x") to obtain the data. If this value is set to zero, the
        /// mail merge reads the data file directly.
        self.fQuery = flags.readBit()
        
        /// unused (4 bits): This field is undefined and MUST be ignored.
        self.unused = UInt8(flags.readRemainingBits())
        
        /// tkField (2 bytes): A signed integer that specifies the token to separate fields in the data file. If ipfnpmf is not 0x00 (data file), this value is undefined
        /// and MUST be ignored. Otherwise it MUST be one of the following tokens.
        /// Value Token
        /// 0x00 (none)
        /// 0x02 (enter)
        /// 0x06 (Tab)
        /// 0x0A ,
        /// 0x0B .
        /// 0x0C !
        /// 0x0D #
        /// 0x0E $
        /// 0x0F %
        /// 0x10 &
        /// 0x11 (
        /// 0x12 )
        /// 0x13 *
        /// 0x14 +
        /// 0x15 -
        /// 0x16 /
        /// 0x17 :
        /// 0x18 ;
        /// 0x19 <
        /// 0x1A =
        /// 0x1B >
        /// 0x1C ?
        /// 0x1D @
        /// 0x1E [
        /// 0x1F ]
        /// 0x21 ^
        /// 0x22 _
        /// 0x23 `
        /// 0x24 {
        /// 0x25 }
        /// 0x26 |
        /// 0x27 ~
        /// 0x46 (field end)
        /// 0x47 (table cell)
        /// 0x48 (table row)
        self.tkField = try dataStream.read(endianess: .littleEndian)
        
        /// tkRec (2 bytes): A signed integer that specifies the token to separate records in the data file. If ipfnpmf is not 0x00 (data file), this value is
        /// undefined and MUST be ignored. Otherwise, it MUST be one of the tokens shown in the table for tkField, MUST NOT be 0x00 (none) and
        /// MUST be different from tkField.
        self.tkRec = try dataStream.read(endianess: .littleEndian)
        
        /// fnpi (2 bytes): An FNPI that specifies the type and identifier of a data file. The fnpt inside this fnpi MUST be 0x3 for mail merge type. The string
        /// in the SttbFnm structure that has an appended FNIF structure with an fnpi that is identical to this one is the file name of this data file for mail
        /// merge.
        self.fnpi = try FNPI(dataStream: &dataStream)
    }
    
    /// ipfnpmf (8 bits): An unsigned integer value that specifies the type of data source for the mail merge. This MUST be one of the following values.
    public enum DataSource: UInt8 {
        /// 0xFF None.
        case none = 0xFF

        /// 0x00 Data file.
        case dataFile = 0x00

        /// 0x01 Microsoft Access database.
        case microsoftAccessDatabase = 0x01

        /// 0x02 Microsoft Excel file.
        case microsoftExcelFile = 0x02

        /// 0x03 Microsoft Query database.
        case microsoftQueryDatabase = 0x03

        /// 0x04 ODBC.
        case odbc = 0x04

        /// 0x05 Office Data Source Object (ODSO).
        case officeDataSourceObject = 0x05
    }
}
