//
//  flt.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import Foundation

/// [MS-DOC] 2.9.90 flt
/// The flt enumeration is an index to a field type. Most of the field type indices that are listed in the following table are mapped to entries in
/// [ECMA-376] part 4, section 2.16.5. Values that are not specified following MUST NOT be used.
public enum flt: UInt8 {
    /// 0x01 Not Named Specifies that the field was unable to be parsed.
    case unableToBeParsed = 0x01

    /// 0x02 Not Named Specifies that the field represents a REF field where the keyword has been omitted. The REF field is specified in
    /// [ECMA-376] part 4, section 2.16.5.58.
    case keywordOmmitted = 0x02

    /// 0x03 REF Specified in [ECMA-376] part 4, section 2.16.5.58
    case REF = 0x03

    /// 0x05 FTNREF This field is identical to NOTEREF specified in [ECMA-376] part 4, section 2.16.5.47.
    case FTNREF = 0x05

    /// 0x06 SET Specified in [ECMA-376] part 4, section 2.16.5.64.
    case SET = 0x06

    /// 0x07 IF Specified in [ECMA-376] part 4, section 2.16.5.32.
    case IF = 0x07

    /// 0x08 INDEX Specified in [ECMA-376] part 4, section 2.16.5.35.
    case INDEX = 0x08

    /// 0x0A STYLEREF Specified in [ECMA-376] part 4, section 2.16.5.66.
    case STYLEREF = 0x0A

    /// 0x0C SEQ Specified in [ECMA-376] part 4, section 2.16.5.63.
    case SEQ = 0x0C

    /// 0x0D TOC Specified in [ECMA-376] part 4, section 2.16.5.75.
    case TOC = 0x0D

    /// 0x0E INFO Specified in [ECMA-376] part 4, section 2.16.5.36.
    case INFO = 0x0E

    /// 0x0F TITLE Specified in [ECMA-376] part 4, section 2.16.5.73.
    case TITLE = 0x0F

    /// 0x10 SUBJECT Specified in [ECMA-376] part 4, section 2.16.5.67.
    case SUBJECT = 0x10

    /// 0x11 AUTHOR Specified in [ECMA-376] part 4, section 2.16.5.4.
    case AUTHOR = 0x11

    /// 0x12 KEYWORDS Specified in [ECMA-376] part 4, section 2.16.5.37.
    case KEYWORDS = 0x12

    /// 0x13 COMMENTS Specified in [ECMA-376] part 4, section 2.16.5.14.
    case COMMENTS = 0x13

    /// 0x14 LASTSAVEDBY Specified in [ECMA-376] part 4, section 2.16.5.38.
    case LASTSAVEDBY = 0x14

    /// 0x15 CREATEDATE Specified in [ECMA-376] part 4, section 2.16.5.16.
    case CREATEDATE = 0x15

    /// 0x16 SAVEDATE Specified in [ECMA-376] part 4, section 2.16.5.60.
    case SAVEDATE = 0x16

    /// 0x17 PRINTDATE Specified in [ECMA-376] part 4, section 2.16.5.54.
    case PRINTDATE = 0x17

    /// 0x18 REVNUM Specified in [ECMA-376] part 4, section 2.16.5.59.
    case REVNUM = 0x18

    /// 0x19 EDITTIME Specified in [ECMA-376] part 4, section 2.16.5.21.
    case EDITTIME = 0x19

    /// 0x1A NUMPAGES Specified in [ECMA-376] part 4, section 2.16.5.49.
    case NUMPAGES = 0x1A

    /// 0x1B NUMWORDS Specified in [ECMA-376] part 4, section 2.16.5.50.
    case NUMWORDS = 0x1B

    /// 0x1C NUMCHARS Specified in [ECMA-376] part 4, section 2.16.5.48.
    case NUMCHARS = 0x1C

    /// 0x1D FILENAME Specified in [ECMA-376] part 4, section 2.16.5.23.
    case FILENAME = 0x1D

    /// 0x1E TEMPLATE Specified in [ECMA-376] part 4, section 2.16.5.71.
    case TEMPLATE = 0x1E

    /// 0x1F DATE Specified in [ECMA-376] part 4, section 2.16.5.18.
    case DATE = 0x1F

    /// 0x20 TIME Specified in [ECMA-376] part 4, section 2.16.5.72.
    case TIME = 0x20

    /// 0x21 PAGE Specified in [ECMA-376] part 4, section 2.16.5.51.
    case PAGE = 0x21

    /// 0x22 = Specified in [ECMA-376]part 4, section 2.16.3.3.
    case equals = 0x22

    /// 0x23 QUOTE Specified in [ECMA-376] part 4, section 2.16.5.56.
    case QUOTE = 0x23

    /// 0x24 INCLUDE This field is identical to INCLUDETEXT specified in [ECMA-376] part 4, section 2.16.5.34.
    case INCLUDE = 0x24

    /// 0x25 PAGEREF Specified in [ECMA-376] part 4, section 2.16.5.52.
    case PAGEREF = 0x25

    /// 0x26 ASK Specified in [ECMA-376] part 4, section 2.16.5.3.
    case ASK = 0x26

    /// 0x27 FILLIN Specified in [ECMA-376] part 4, section 2.16.5.25.
    case FILLIN = 0x27

    /// 0x28 DATA Usage: DATA datafile [headerfile] Specifies that this field SHOULD<224> redirect the mail merge data and header files to the
    /// ones specified.
    case DATA = 0x28

    /// 0x29 NEXT Specified in [ECMA-376] part 4, section 2.16.5.45.
    case NEXT = 0x29

    /// 0x2A NEXTIF Specified in [ECMA-376] part 4, section 2.16.5.46.
    case NEXTIF = 0x2A

    /// 0x2B SKIPIF Specified in [ECMA-376] part 4, section 2.16.5.65.
    case SKIPIF = 0x2B

    /// 0x2C MERGEREC Specified in [ECMA-376] part 4, section 2.16.5.43.
    case MERGEREC = 0x2C

    /// 0x2D DDE Specified in [MS-OE376] part 2, section 1.3.2.1.
    case DDE = 0x2D

    /// 0x2E DDEAUTO Specified in [MS-OE376] part 2, section 1.3.2.2.
    case DDEAUTO = 0x2E

    /// 0x2F GLOSSARY This field is identical to AUTOTEXT specified in [ECMA-376] part 4, section 2.16.5.8.
    case GLOSSARY = 0x2F

    /// 0x30 PRINT Specified in [ECMA-376] part 4, section 2.16.5.53.
    case PRINT = 0x30

    /// 0x31 EQ Specified in [ECMA-376] part 4, section 2.16.5.22.
    case EQ = 0x31

    /// 0x32 GOTOBUTTON Specified in [ECMA-376] part 4, section 2.16.5.29.
    case GOTOBUTTON = 0x32

    /// 0x33 MACROBUTTON Specified in [ECMA-376] part 4, section 2.16.5.41.
    case MACROBUTTON = 0x33

    /// 0x34 AUTONUMOUT Specified in [ECMA-376] part 4, section 2.16.5.7.
    case AUTONUMOUT = 0x34

    /// 0x35 AUTONUMLGL Specified in [ECMA-376] part 4, section 2.16.5.6.
    case AUTONUMLGL = 0x35

    /// 0x36 AUTONUM Specified in [ECMA-376] part 4, section 2.16.5.5.
    case AUTONUM = 0x36

    /// 0x37 IMPORT Identical to the INCLUDEPICTURE field specified in [ECMA-376] part 4, section 2.16.5.33.
    case IMPORT = 0x37

    /// 0x38 LINK Specified in [ECMA-376] part 4, section 2.16.5.39.
    case LINK = 0x38

    /// 0x39 SYMBOL Specified in [ECMA-376] part 4, section 2.16.5.68.
    case SYMBOL = 0x39

    /// 0x3A EMBED Specifies that the field represents an embedded OLE object.
    case EMBED = 0x3A

    /// 0x3B MERGEFIELD Specified in [ECMA-376] part 4, section 2.16.5.42.
    case MERGEFIELD = 0x3B

    /// 0x3C USERNAME Specified in [ECMA-376] part 4, section 2.16.5.78.
    case USERNAME = 0x3C

    /// 0x3D USERINITIALS Specified in [ECMA-376] part 4, section 2.16.5.77.
    case USERINITIALS = 0x3D

    /// 0x3E USERADDRESS Specified in [ECMA-376] part 4, section 2.16.5.76.
    case USERADDRESS = 0x3E

    /// 0x3F BARCODE Specified in [ECMA-376] part 4, section 2.16.5.10.
    case BARCODE = 0x3F

    /// 0x40 DOCVARIABLE Specified in [ECMA-376] part 4, section 2.16.5.20.
    case DOCVARIABLE = 0x40

    /// 0x41 SECTION Specified in [ECMA-376] part 4, section 2.16.5.61.
    case SECTION = 0x41

    /// 0x42 SECTIONPAGES Specified in [ECMA-376] part 4, section 2.16.5.62.
    case SECTIONPAGES = 0x42

    /// 0x43 INCLUDEPICTURE Specified in [ECMA-376] part 4, section 2.16.5.33.
    case INCLUDEPICTURE = 0x43

    /// 0x44 INCLUDETEXT Specified in [ECMA-376] part 4, section 2.16.5.34.
    case INCLUDETEXT = 0x44

    /// 0x45 FILESIZE Specified in [ECMA-376] part 4, section 2.16.5.24.
    case FILESIZE = 0x45

    /// 0x46 FORMTEXT Specified in [ECMA-376] part 4, section 2.16.5.28.
    case FORMTEXT = 0x46

    /// 0x47 FORMCHECKBOX Specified in [ECMA-376] part 4, section 2.16.5.26.
    case FORMCHECKBOX = 0x47

    /// 0x48 NOTEREF Specified in [ECMA-376] part 4, section 2.16.5.47.
    case NOTEREF = 0x48

    /// 0x49 TOA Specified in [ECMA-376] part 4, section 2.16.5.74.
    case TOA = 0x49

    /// 0x4B MERGESEQ Specified in [ECMA-376] part 4, section 2.16.5.44.
    case MERGESEQ = 0x4B

    /// 0x4F AUTOTEXT Specified in [ECMA-376] part 4, section 2.16.5.8.
    case AUTOTEXT = 0x4F

    /// 0x50 COMPARE Specified in [ECMA-376] part 4, section 2.16.5.15.
    case COMPARE = 0x50

    /// 0x51 ADDIN Specifies that the field contains data created by an add-in.
    case ADDIN = 0x51

    /// 0x53 FORMDROPDOWN Specified in [ECMA-376] part 4, section 2.16.5.27.
    case FORMDROPDOWN = 0x53

    /// 0x54 ADVANCE Specified in [ECMA-376] part 4, section 2.16.5.2.
    case ADVANCE = 0x54

    /// 0x55 DOCPROPERTY Specified in [ECMA-376] part 4, section 2.16.5.19.
    case DOCPROPERTY = 0x55

    /// 0x57 CONTROL Specifies that the field represents an OCX control.
    case CONTROL = 0x57

    /// 0x58 HYPERLINK Specified in [ECMA-376] part 4, section 2.16.5.31.
    case HYPERLINK = 0x58

    /// 0x59 AUTOTEXTLIST Specified in [ECMA-376] part 4, section 2.16.5.9.
    case AUTOTEXTLIST = 0x59

    /// 0x5A LISTNUM Specified in [ECMA-376] part 4, section 2.16.5.40.
    case LISTNUM = 0x5A

    /// 0x5B HTMLCONTROL Specifies the field represents an HTML control.
    case HTMLCONTROL = 0x5B

    /// 0x5C BIDIOUTLINE Specified in [ECMA-376] part 4, section 2.16.5.12.
    case BIDIOUTLINE = 0x5C

    /// 0x5D ADDRESSBLOCK Specified in [ECMA-376] part 4, section 2.16.5.1.
    case ADDRESSBLOCK = 0x5D

    /// 0x5E GREETINGLINE Specified in [ECMA-376] part 4, section 2.16.5.30.
    case GREETINGLINE = 0x5E

    /// 0x5F SHAPE This field is identical to QUOTE specified in [ECMA-376] part 4, section 2.16.5.56.
    case SHAPE = 0x5F
}
