//
//  Dop.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.1 Dop
/// The Dop structure contains the document and compatibility settings for the document.
/// Based on the value of Fib.cswNew, the Dop is a structure from the following table.
/// Value Meaning
/// 0 Dop97
/// otherwise Based on the value of FibRgCswNew.nFibNew the Dop is a structure from the following:
///  0x00D9 Dop2000
///  0x0101 Dop2002
///  0x010C Dop2003
///  0x0112 if FibRgFcLcb97.lcbDop is 674, then the Dop is a Dop2007. If FibRgFcLcb97.
/// lcbDop is 690, then the Dop is a Dop2010. If FibRgFcLcb97.lcbDop is 694, then the Dop is a section Dop2013. FibRgFcLcb97.lcbDop MUST be one of
/// these three values.
public struct Dop {
    public let dop97: Dop97
    public let dop2000: Dop2000?
    public let dop2002: Dop2002?
    public let dop2003: Dop2003?
    public let dop2007: Dop2007?
    public let dop2010: Dop2010?
    public let dop2013: Dop2013?
    
    public init(dataStream: inout DataStream, fib: Fib, size: UInt32) throws {
        if fib.cswNew == 0 {
            self.dop97 = try Dop97(dataStream: &dataStream)
            self.dop2000 = nil
            self.dop2002 = nil
            self.dop2003 = nil
            self.dop2007 = nil
            self.dop2010 = nil
            self.dop2013 = nil
        } else if fib.fibRgCswNew?.nFibNew == 0x00D9 {
            let dop2000 = try Dop2000(dataStream: &dataStream)
            self.dop97 = dop2000.dop97
            self.dop2000 = dop2000
            self.dop2002 = nil
            self.dop2003 = nil
            self.dop2007 = nil
            self.dop2010 = nil
            self.dop2013 = nil
        } else if fib.fibRgCswNew?.nFibNew == 0x0101 {
            let dop2002 = try Dop2002(dataStream: &dataStream)
            self.dop97 = dop2002.dop2000.dop97
            self.dop2000 = dop2002.dop2000
            self.dop2002 = dop2002
            self.dop2003 = nil
            self.dop2007 = nil
            self.dop2010 = nil
            self.dop2013 = nil
        } else if fib.fibRgCswNew?.nFibNew == 0x010C {
            let dop2003 = try Dop2003(dataStream: &dataStream)
            self.dop97 = dop2003.dop2002.dop2000.dop97
            self.dop2000 = dop2003.dop2002.dop2000
            self.dop2002 = dop2003.dop2002
            self.dop2003 = dop2003
            self.dop2007 = nil
            self.dop2010 = nil
            self.dop2013 = nil
        } else if fib.fibRgCswNew?.nFibNew == 0x0112 {
            /// FibRgFcLcb97.lcbDop is 674, then the Dop is a Dop2007. If FibRgFcLcb97.
            /// lcbDop is 690, then the Dop is a Dop2010. If FibRgFcLcb97.lcbDop is 694, then the Dop is a section Dop2013. FibRgFcLcb97.lcbDop MUST be one of
            
            if fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbDop == 674 {
                let dop2007 = try Dop2007(dataStream: &dataStream)
                self.dop97 = dop2007.dop2003.dop2002.dop2000.dop97
                self.dop2000 = dop2007.dop2003.dop2002.dop2000
                self.dop2002 = dop2007.dop2003.dop2002
                self.dop2003 = dop2007.dop2003
                self.dop2007 = dop2007
                self.dop2010 = nil
                self.dop2013 = nil
            } else if fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbDop == 690 {
                let dop2010 = try Dop2010(dataStream: &dataStream)
                self.dop97 = dop2010.dop2007.dop2003.dop2002.dop2000.dop97
                self.dop2000 = dop2010.dop2007.dop2003.dop2002.dop2000
                self.dop2002 = dop2010.dop2007.dop2003.dop2002
                self.dop2003 = dop2010.dop2007.dop2003
                self.dop2007 = dop2010.dop2007
                self.dop2010 = dop2010
                self.dop2013 = nil
            } else if fib.fibRgFcLcbBlob.fibRgFcLcb97.lcbDop == 694 {
                let dop2013 = try Dop2013(dataStream: &dataStream)
                self.dop97 = dop2013.dop2010.dop2007.dop2003.dop2002.dop2000.dop97
                self.dop2000 = dop2013.dop2010.dop2007.dop2003.dop2002.dop2000
                self.dop2002 = dop2013.dop2010.dop2007.dop2003.dop2002
                self.dop2003 = dop2013.dop2010.dop2007.dop2003
                self.dop2007 = dop2013.dop2010.dop2007
                self.dop2010 = dop2013.dop2010
                self.dop2013 = dop2013
            } else {
                throw OfficeFileError.corrupted
            }
            
        } else {
            throw OfficeFileError.corrupted
        }
    }
}
