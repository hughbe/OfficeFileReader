//
//  PhotoAlbumLayoutEnum.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.13.20 PhotoAlbumLayoutEnum
/// Referenced by: PhotoAlbumInfo10Atom
/// An enumeration that specifies how the pictures are arranged on each presentation slide.
public enum PhotoAlbumLayoutEnum: UInt8 {
    /// PA_FitToSlide 0x00 Each presentation slide contains one picture that is scaled as large as will fit within the bounds of the slides while still
    /// preserving the aspect ratio.
    case fitToSlide = 0x00
    
    /// PA_OnePicture 0x01 Each presentation slide contains one picture.
    case onePicture = 0x01
    
    /// PA_TwoPictures 0x02 Each presentation slide contains two pictures.
    case twoPictures = 0x02
    
    /// PA_FourPictures 0x03 Each presentation slide contains four pictures
    case fourPictures = 0x03
    
    /// PA_OnePictureAndTitle 0x04 Each presentation slide contains one picture and a title placeholder shape.
    case onePictureAndTitle = 0x04
    
    /// PA_TwoPicturesAndTitle 0x05 Each presentation slide contains two pictures and a title placeholder shape.
    case twoPicturesAndTitle = 0x05
    
    /// PA_FourPicturesAndTitle 0x06 Each presentation slide contains four pictures and a title placeholder shape.
    case fourPicturesAntTitle = 0x06
}
