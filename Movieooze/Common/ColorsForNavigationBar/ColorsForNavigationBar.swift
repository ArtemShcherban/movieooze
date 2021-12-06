//
//  ColorsForNavigationBar.swift
//  Movieooze
//
//  Created by Artem Shcherban on 15.11.2021.
//

import Foundation
import UIKit
import UIImageColors

struct ColorsForNavigationBar {
    
    static func getColorsForNavigationBarButtons(posterImage: UIImage) -> (colorsRight: UIImageColors, colorsLeft: UIImageColors) {
        let arrayOfFragments = cropImages(posterImage: posterImage)
        if arrayOfFragments.isEmpty != true {
            let colors = getColorsFromPoster(arrayOfImages: arrayOfFragments)
            return (colors.colorsRight, colors.colorsLeft)
        } else {
            return (UIImageColors(background: .black, primary: .black, secondary: .black, detail: .black), UIImageColors(background: .black, primary: .black, secondary: .black, detail: .black))
        }
    }
    
    private static func cropImages(posterImage: UIImage) -> ([UIImage]){
        var images: [UIImage] = []
        for each in 1...2 {
            var  x = 440, width = 30
            if each == 2 {
                x = 20
                width = 100
            }
            let imageForCrop = posterImage
            let cgImageForCrop = imageForCrop.cgImage
            let cropRect = CGRect (
                x: x, y: 75, width: width, height: 30).integral
            guard let croppedCgImge = cgImageForCrop?.cropping(to: cropRect) else {break}
            let croppedImage = UIImage(cgImage: croppedCgImge, scale: imageForCrop.scale, orientation: imageForCrop.imageOrientation)
            images.append(croppedImage)
        }
        return images
    }
    
    private static  func getColorsFromPoster(arrayOfImages: [UIImage]) -> (colorsRight: UIImageColors, colorsLeft: UIImageColors) {
        
        let quality = UIImageColorsQuality.low
        let start = DispatchTime.now()
        if  let colorsRight = arrayOfImages[0].getColors(quality: quality), let colorsLeft = arrayOfImages[1].getColors(quality: quality) {
            let end = DispatchTime.now()
            //🧐 убрать подсчет времени
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            print("\(timeInterval) s.")
            return (colorsRight, colorsLeft)
        }
        
        return (UIImageColors(background: .black, primary: .black, secondary: .black, detail: .black), UIImageColors(background: .black, primary: .black, secondary: .black, detail: .black))
    }
}
