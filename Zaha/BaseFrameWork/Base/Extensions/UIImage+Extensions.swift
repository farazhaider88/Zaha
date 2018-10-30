//
//  UIImage+Extensions.swift


import UIKit

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    static func multiplyImageByConstantColor(image:UIImage,color:UIColor)-> UIImage {
        
        let backgroundSize = image.size
        UIGraphicsBeginImageContext(backgroundSize)
        
        let ctx = UIGraphicsGetCurrentContext()!
        
        var backgroundRect = CGRect()
        backgroundRect.size = backgroundSize
        backgroundRect.origin.x = 0
        backgroundRect.origin.y = 0
        
        let myFloatForR = 0
        var r = CGFloat(myFloatForR)
        let myFloatForG = 0
        var g = CGFloat(myFloatForG)
        let myFloatForB = 0
        var b = CGFloat(myFloatForB)
        let myFloatForA = 0
        var a = CGFloat(myFloatForA)
        
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        ctx.setFillColor(red: r, green: g, blue: b, alpha: a)
        ctx.fill(backgroundRect)
        
        var imageRect=CGRect()
        imageRect.size = image.size
        imageRect.origin.x = (backgroundSize.width - image.size.width)/2
        imageRect.origin.y = (backgroundSize.height - image.size.height)/2
        
        // Unflip the image
        ctx.translateBy(x: 0, y: backgroundSize.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        
        ctx.setBlendMode(.multiply)
        ctx.draw(image.cgImage!, in: imageRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
