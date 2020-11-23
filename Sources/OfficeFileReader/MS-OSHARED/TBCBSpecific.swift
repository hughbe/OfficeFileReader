//
//  TBCBSpecific.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-SHARED] 2.3.1.17 TBCBSpecific
/// Contains information specific to button and ExpandingGrid type toolbar controls.
public struct TBCBSpecific {
    public let bFlags: TBCBSFlags
    public let icon: TBCBitmap?
    public let iconMask: TBCBitmap?
    public let iBtnFace: UInt16?
    public let wstrAcc: WString?
    
    public init(dataStream: inout DataStream) throws {
        /// bFlags (1 byte): Structure of type TBCBSFlags section 2.3.1.18) that specifies which fields of this structure are saved to the file.
        self.bFlags = try TBCBSFlags(dataStream: &dataStream)
        
        /// icon (variable): Structure of type TBCBitmap (section 2.3.1.1) that specifies the icon data for this toolbar control. MUST exist if
        /// bFlags.fCustomBitmap equals 1. MUST NOT exist if bFlags.fCustomBitmap equals 0.
        if self.bFlags.fCustomBitmap {
            self.icon = try TBCBitmap(dataStream: &dataStream)
        } else {
            self.icon = nil
        }
        
        /// iconMask (variable): Structure of type TBCBitmap (section 2.3.1.1) that specifies the icon data mask for this toolbar control. MUST exist
        /// if bFlags.fCustomBitmap equals 1. MUST NOT exist if bFlags.fCustomBitmap equals 0. The value of the biBitCount field of the
        /// BITMAPINFOHEADER (section 2.3.1.2) contained by this TBCBitmap MUST be 0x01. The iconMask is used to specify the transparency
        /// of the icon. The iconMask is white in all the areas in which the icon is displayed as transparent and is black in all other areas.
        if self.bFlags.fCustomBitmap {
            self.iconMask = try TBCBitmap(dataStream: &dataStream)
            if self.iconMask?.biHeader.biBitCount != 0x01 {
                throw OfficeFileError.corrupted
            }
        } else {
            self.iconMask = nil
        }
        
        /// iBtnFace (2 bytes): Unsigned integer that specifies the icon of the toolbar control. When this value is set, the toolbar control will use the
        /// icon of the toolbar control whose toolbar control identifier (TCID) equals this value. MUST exist if bFlags.fCustomBtnFace equals 1.
        /// MUST NOT exist if bFlags.fCustomBtnFace equals 0.
        if self.bFlags.fCustomBtnFace {
            self.iBtnFace = try dataStream.read(endianess: .littleEndian)
        } else {
            self.iBtnFace = nil
        }
        
        /// wstrAcc (variable): Structure of type WString (section 2.3.1.4) that specifies the accelerator keys for this toolbar control. MUST exist
        /// if bFlags.fAccelerator equals 1. MUST NOT exist if bFlags.fAccelerator equals 0.
        if self.bFlags.fAccelerator {
            self.wstrAcc = try WString(dataStream: &dataStream)
        } else {
            self.wstrAcc = nil
        }
    }
}
