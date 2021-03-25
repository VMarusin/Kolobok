//
//  UIImage + Extension.swift
//  Kolobok
//
//  Created by Виктор Марусин on 19.01.2021.
//

import UIKit

extension UIImage {
    /*
     Create a context by using UIGraphicsBeginImageContextWithOptions
     size：size of the input image
     opaque：to decide if the image will contain transparent component, none transparent has a faster processing speed
     scale：same as the scale property under UIImage. By giving, it makes picture auto select factor by screen (@x2 @x3 ...)
     */
    func resizeUI(size: CGSize) -> UIImage? {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

//функция сжимает изображение до нужных размеров подгоняя их под один размер
extension UIImage {

    var scaledToSafeUploadSize: UIImage? {
      let maxImageSideLength: CGFloat = 480

      let largerSide: CGFloat = max(size.width, size.height)
      let ratioScale: CGFloat = largerSide > maxImageSideLength ? largerSide / maxImageSideLength : 1
      let newImageSize = CGSize(width: size.width / ratioScale, height: size.height / ratioScale)

      return image(scaledTo: newImageSize)
    }

    func image(scaledTo size: CGSize) -> UIImage? {
      defer {
        UIGraphicsEndImageContext()
      }

      UIGraphicsBeginImageContextWithOptions(size, true, 0)
      draw(in: CGRect(origin: .zero, size: size))

      return UIGraphicsGetImageFromCurrentImageContext()
    }
}


//// здесь через let color = yourImageView.image!.getPixelColor(atLocation: location, withFrameSize: yourImageView.frame.size) можем получить код цвета нужной точки
//extension UIImage {
//
//  func resizeImage(targetSize: CGSize) -> UIImage {
//    let size = self.size
//    let widthRatio  = targetSize.width  / size.width
//    let heightRatio = targetSize.height / size.height
//    let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
//
//    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//    self.draw(in: rect)
//    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//
//    return newImage!
//  }
//}


