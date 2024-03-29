//
//  UIImageExtension.swift
//  Movieooze
//
//  Created by Artem Shcherban on 14.11.2021.
//

import UIKit

extension UIImage {
    
    func addShadow(blurSize: CGFloat = 3.0) -> UIImage {
                    
//        let shadowColor = UIColor(white: 0.0, alpha:0.8).cgColor
        let shadowColor = UIColor.black.cgColor
        let context = CGContext(data: nil,
                                width: Int(self.size.width + blurSize),
                                height: Int(self.size.height + blurSize),
                                bitsPerComponent: self.cgImage!.bitsPerComponent,
                                bytesPerRow: 0,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        context.setShadow(offset: CGSize(width: blurSize/2,height: -blurSize/2),
                          blur: blurSize,
                          color: shadowColor)
        context.draw(self.cgImage!,
                     in: CGRect(x: 0, y: blurSize, width: self.size.width, height: self.size.height),
                     byTiling:false)
        
        return UIImage(cgImage: context.makeImage()!)
    }
}
