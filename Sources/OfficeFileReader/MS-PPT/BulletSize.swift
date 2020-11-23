//
//  BulletSize.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-PPT] 2.2.3 BulletSize
/// Referenced by: TextPFException
/// A 2-byte signed integer that specifies the bullet font size. It SHOULD<5> be a value from the following table:
/// Range Meaning
/// 25 to 400, inclusive. The value specifies bullet font size as a percentage of the font size of the first text run in the paragraph.
/// -4000 to -1, inclusive. The absolute value specifies the bullet font size in points.
public typealias BulletSize = Int16
