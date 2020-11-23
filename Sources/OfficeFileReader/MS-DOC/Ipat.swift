//
//  Ipat.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.121 Ipat
/// The Ipat enumeration is an index to a shading pattern. Most pattern indices listed in the following table are mapped to entries of ST_Shd, as specified in
/// [ECMA-376] part 4, section 2.18.85 ST_Shd (Shading Patterns). All pattern indices that are not mapped to an ST_Shd value are not supported by
/// the [ECMA-376] format and are lost if converted from the MS-DOC format to the [ECMA-376] format; these pattern values SHOULD NOT<226> be used.
public enum Ipat: UInt16 {
    /// ipatAuto 0x0000 Clear, ST_Shd: clea
    case auto = 0x0000

    /// ipatSolid 0x0001 Solid ST_Shd: soli
    case solid = 0x0001

    /// ipatPct5 0x0002 5%, ST_Shd: pct
    case pct5 = 0x0002

    /// ipatPct10 0x0003 10%, ST_Shd: pct1
    case pct10 = 0x0003

    /// ipatPct20 0x0004 20%, ST_Shd: pct2
    case pct20 = 0x0004

    /// ipatPct25 0x0005 25%, ST_Shd: pct2
    case pct25 = 0x0005

    /// ipatPct30 0x0006 30%, ST_Shd: pct3
    case pct30 = 0x0006

    /// ipatPct40 0x0007 40%, ST_Shd: pct4
    case pct40 = 0x0007

    /// ipatPct50 0x0008 50%, ST_Shd: pct5
    case pct50 = 0x0008

    /// ipatPct60 0x0009 60%, ST_Shd: pct6
    case pct60 = 0x0009

    /// ipatPct70 0x000A 70%, ST_Shd: pct7
    case pct70 = 0x000A

    /// ipatPct75 0x000B 75%, ST_Shd: pct7
    case pct75 = 0x000B

    /// ipatPct80 0x000C 80%, ST_Shd: pct8
    case pct80 = 0x000C

    /// ipatPct90 0x000D 90%, ST_Shd: pct9
    case pct90 = 0x000D

    /// ipatDkHorizontal 0x000E Horizontal Stripe, ST_Shd: horzStrip
    case dkHorizontal = 0x000E

    /// ipatDkVertical 0x000F Vertical Stripe, ST_Shd: vertStrip
    case dkVertical = 0x000F

    /// ipatDkForeDiag 0x0010 Reverse Diagonal Stripe, ST_Shd: reverseDiagStrip
    case dkForeDiag = 0x0010

    /// ipatDkBackDiag 0x0011 Diagonal Stripe, ST_Shd: diagStrip
    case dkBackDiag = 0x0011

    /// ipatDkCross 0x0012 Horizontal Cross, ST_Shd: horzCros
    case dkCross = 0x0012

    /// ipatDkDiagCross 0x0013 Diagonal Cross, ST_Shd: diagCros
    case dkDiagCross = 0x0013

    /// ipatHorizontal 0x0014 Thin Horizontal Stripe, ST_Shd: thinHorzStrip
    case horizontal = 0x0014

    /// ipatVertical 0x0015 Thin Vertical Stripe, ST_Shd: thinVertStrip
    case vertical = 0x0015

    /// ipatForeDiag 0x0016 Thin Reverse Diagonal Stripe, ST_Shd: thinReverseDiagStrip
    case foreDiag = 0x0016

    /// ipatBackDiag 0x0017 Thin Diagonal Stripe, ST_Shd: thinDiagStrip
    case backDiag = 0x0017

    /// ipatCross 0x0018 Thin Horizontal Cross, ST_Shd: thinHorzCros
    case cross = 0x0018

    /// ipatDiagCross 0x0019 Thin Diagonal Cross, ST_Shd: thinDiagCros
    case diagCross = 0x0019

    /// ipatPctNew2 0x0023 Specifies that the pattern used for the current shaded region shall be a 2.5% fill pattern, as follows
    case pctNew2 = 0x0023

    /// ipatPctNew7 0x0024 Specifies that the pattern used for the current shaded region shall be a 7.5% fill pattern, as follows
    case pctNew7 = 0x0024

    /// ipatPctNew12 0x0025 12.5%, ST_Shd: pct1
    case pctNew12 = 0x0025

    /// ipatPctNew15 0x0026 15%, ST_Shd: pct15
    case pctNew15 = 0x0026

    /// ipatPctNew17 0x0027 Specifies that the pattern used for the current shaded region shall be a 17.5% fill pattern, as follows
    case pctNew17 = 0x0027

    /// ipatPctNew22 0x0028 Specifies that the pattern used for the current shaded region shall be a 22.5% fill pattern, as follows
    case pctNew22 = 0x0028

    /// ipatPctNew27 0x0029 Specifies that the pattern used for the current shaded region shall be a 27.5% fill pattern, as follows
    case pctNew27 = 0x0029

    /// ipatPctNew32 0x002A Specifies that the pattern used for the current shaded region shall be a 32.5% fill pattern, as follows
    case pctNew32 = 0x002A

    /// ipatPctNew35 0x002B 35%, ST_Shd: pct3
    case pctNew35 = 0x002B

    /// ipatPctNew37 0x002C 37.5%, ST_Shd: pct3
    case pctNew37 = 0x002C

    /// ipatPctNew42 0x002D Specifies that the pattern used for the current shaded region shall be a 42.5% fill pattern, as follows
    case pctNew42 = 0x002D

    /// ipatPctNew45 0x002E 45%, ST_Shd: pct4
    case pctNew45 = 0x002E

    /// ipatPctNew47 0x002F Specifies that the pattern used for the current shaded region shall be a 47.5% fill pattern, as follows
    case pctNew47 = 0x002F

    /// ipatPctNew52 0x0030 Specifies that the pattern used for the current shaded region shall be a 52.5% fill pattern, as follows
    case pctNew52 = 0x0030

    /// ipatPctNew55 0x0031 55%, ST_Shd: pct5
    case pctNew55 = 0x0031

    /// ipatPctNew57 0x0032 Specifies that the pattern used for the current shaded region shall be a 57.5% fill pattern, as follows
    case pctNew57 = 0x0032

    /// ipatPctNew62 0x0033 62.5%, ST_Shd: pct6
    case pctNew62 = 0x0033

    /// ipatPctNew65 0x0034 65%, ST_Shd: pct6
    case pctNew65 = 0x0034

    /// ipatPctNew67 0x0035 Specifies that the pattern used for the current shaded region shall be a 67.5% fill pattern, as follows
    case pctNew67 = 0x0035

    /// ipatPctNew72 0x0036 Specifies that the pattern used for the current shaded region shall be a 72.5% fill pattern, as follows
    case pctNew72 = 0x0036

    /// ipatPctNew77 0x0037 Specifies that the pattern used for the current shaded region shall be a 77.5% fill pattern, as follows
    case pctNew77 = 0x0037

    /// ipatPctNew82 0x0038 Specifies that the pattern used for the current shaded region shall be an 82.5% fill pattern, as follows
    case pctNew82 = 0x0038

    /// ipatPctNew85 0x0039 85%, ST_Shd: pct8
    case pctNew85 = 0x0039

    /// ipatPctNew87 0x003A 87.5%, ST_Shd: pct8
    case pctNew87 = 0x003A

    /// ipatPctNew92 0x003B Specifies that the pattern used for the current shaded region shall be a 92.5% fill pattern, as follows
    case pctNew92 = 0x003B

    /// ipatPctNew95 0x003C 95%, ST_Shd: pct9
    case pctNew95 = 0x003C

    /// ipatPctNew97 0x003D Specifies that the pattern used for the current shaded region shall be a 97.5% fill pattern, as follows
    case pctNew97 = 0x003D

    /// ipatNil 0xFFFF Nil, ST_Shd: nil
    case `nil` = 0xFFFF
}
