//
//  PhotoAlbumFrameShapeEnum.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.13.19 PhotoAlbumFrameShapeEnum
/// Referenced by: PhotoAlbumInfo10Atom
/// An enumeration that specifies how the frames around the pictures in the photo album are drawn.
/// Some frames are created by cropping the photos to a certain shape, and others involve putting a frame image on top of them without modifying them.
public enum PhotoAlbumFrameShapeEnum: UInt16 {
    /// PA_Rectangle 0x0000 The pictures are drawn normally.
    case rectangle = 0x0000
    
    /// PA_RoundedRectangle 0x0001 The pictures are drawn with their edges cropped such that the shape of the frame of the pictures is a rounded
    /// rectangle.
    case roundedRectangle = 0x0001
    
    /// PA_Beveled 0x0002 The pictures are drawn to look like the frame has a beveled edge.
    case beveled = 0x0002
    
    /// PA_Oval 0x0003 The pictures are drawn with their edges cropped such that the shape of the frame of the pictures is an oval.
    case oval = 0x0003
    
    /// PA_Octagon 0x0004 The pictures are drawn with triangular shapes covering the four corners of the frame.
    case octagon = 0x0004
    
    /// PA_Cross 0x0005 The pictures are drawn with square shapes covering the four corners of the frame.
    case cross = 0x0005
    
    /// PA_Plaque 0x0006 The pictures are drawn with rounded shapes covering the four corners of the frame.
    case plaque = 0x0006
}
