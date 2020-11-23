//
//  ChartBuildEnum.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

/// [MS-PPT] 2.13.4 ChartBuildEnum
/// Referenced by: ChartBuildAtom
/// An enumeration that specifies different types of chart builds.
public enum ChartBuildEnum: UInt32 {
    /// TLCB_AsOneObject 0x00000000 Chart animates in its entirety.
    case asOneObject = 0x00000000

    /// TLCB_BySeries 0x00000001 Each series animates separately, and all elements in each series animate at the same time.
    case bySeries = 0x00000001
    
    /// TLCB_ByCategory 0x00000002 Each category animates separately, and all elements in each category animate at the same time.
    case byCategory = 0x00000002
    
    /// TLCB_ByElementInSeries 0x00000003
    /// Elements in the chart animate in the following order:
    /// Element in series 1 and category 1
    /// Element in series 1 and category 2
    /// Element in series 1 and category 3
    /// …
    /// Element in series 2 and category 1
    /// Element in series 2 and category 2
    /// Element in series 2 and category 3
    /// …
    /// Element in series 3 and category 1
    /// Element in series 3 and category 2
    /// Element in series 3 and category 3
    /// …
    case byElementInSeries = 0x00000003
    
    /// TLCB_ByElementInCategory 0x00000004
    /// Elements in the chart animate in the following order:
    /// Element in category 1 and series 1
    /// Element in category 1 and series 2
    /// Element in category 1 and series 3
    /// …
    /// Element in category 2 and series 1
    /// Element in category 2 and series 2
    /// Element in category 2 and series 3
    /// …
    /// Element in category 3 and series 1
    /// Element in category 3 and series 2
    /// Element in category 3 and series 3
    /// …
    case byElementInCategory = 0x00000004
    
    /// TLCB_Custom 0x00000005 Custom chart build type
    case custom = 0x00000005
}
