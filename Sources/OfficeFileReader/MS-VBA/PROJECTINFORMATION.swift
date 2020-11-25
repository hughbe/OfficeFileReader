//
//  PROJECTINFORMATION.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1 PROJECTINFORMATION Record
/// Specifies version-independent information for the VBA project.
public struct PROJECTINFORMATION {
    public let sysKindRecord: PROJECTSYSKIND
    public let lcidRecord: PROJECTLCID
    public let lcidInvokeRecord: PROJECTLCIDINVOKE
    public let codePageRecord: PROJECTCODEPAGE
    public let nameRecord: PROJECTNAME
    public let docStringRecord: PROJECTDOCSTRING
    public let helpFilePathRecord: PROJECTHELPFILEPATH
    public let helpContextRecord: PROJECTHELPCONTEXT
    public let libFlagsRecord: PROJECTLIBFLAGS
    public let versionRecord: PROJECTVERSION
    public let constantsRecord: PROJECTCONSTANTS
    
    public init(dataStream: inout DataStream) throws {
        /// SysKindRecord (10 bytes): A PROJECTSYSKIND Record (section 2.3.4.2.1.1).
        self.sysKindRecord = try PROJECTSYSKIND(dataStream: &dataStream)
        
        /// LcidRecord (10 bytes): A PROJECTLCID Record (section 2.3.4.2.1.2).
        self.lcidRecord = try PROJECTLCID(dataStream: &dataStream)
        
        /// LcidInvokeRecord (10 bytes): A PROJECTLCIDINVOKE Record (section 2.3.4.2.1.3).
        self.lcidInvokeRecord = try PROJECTLCIDINVOKE(dataStream: &dataStream)
        
        /// CodePageRecord (8 bytes): A PROJECTCODEPAGE Record (section 2.3.4.2.1.4).
        self.codePageRecord = try PROJECTCODEPAGE(dataStream: &dataStream)
        
        /// NameRecord (variable): A PROJECTNAME Record (section 2.3.4.2.1.5).
        self.nameRecord = try PROJECTNAME(dataStream: &dataStream)
        
        /// DocStringRecord (variable): A PROJECTDOCSTRING Record (section 2.3.4.2.1.6).
        self.docStringRecord = try PROJECTDOCSTRING(dataStream: &dataStream)
        
        /// HelpFilePathRecord (variable): A PROJECTHELPFILEPATH Record (section 2.3.4.2.1.7).
        self.helpFilePathRecord = try PROJECTHELPFILEPATH(dataStream: &dataStream)
        
        /// HelpContextRecord (10 bytes): A PROJECTHELPCONTEXT Record (section 2.3.4.2.1.8).
        self.helpContextRecord = try PROJECTHELPCONTEXT(dataStream: &dataStream)
        
        /// LibFlagsRecord (10 bytes): A PROJECTLIBFLAGS Record (section 2.3.4.2.1.9).
        self.libFlagsRecord = try PROJECTLIBFLAGS(dataStream: &dataStream)
        
        /// VersionRecord (12 bytes): A PROJECTVERSION Record (section 2.3.4.2.1.10).
        self.versionRecord = try PROJECTVERSION(dataStream: &dataStream)
        
        /// ConstantsRecord (variable): A PROJECTCONSTANTS Record (section 2.3.4.2.1.11). This field is optional.
        self.constantsRecord = try PROJECTCONSTANTS(dataStream: &dataStream)
    }
}
