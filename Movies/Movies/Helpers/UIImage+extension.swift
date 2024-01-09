//
//  UIImage+extension.swift
//  Movies
//
//  Created by Yura Sabadin on 10.01.2024.
//

import UIKit


extension UIImage {
    static func getPersonImage() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: TitleConstants.userImage) {
            let image = UIImage(data: imageData)
            
            
            return image
        } else {
            return ImageConstants.person
        }
    }
    
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func resized(to newSize: CGSize) -> UIImage {
            return UIGraphicsImageRenderer(size: newSize).image { _ in
                let hScale = newSize.height / size.height
                let vScale = newSize.width / size.width
                let scale = min(hScale, vScale) // scaleToFill
                let resizeSize = CGSize(width: size.width*scale, height: size.height*scale)
                var middle = CGPoint.zero
                if resizeSize.width > newSize.width {
                    middle.x -= (resizeSize.width-newSize.width)/2.0
                }
                if resizeSize.height > newSize.height {
                    middle.y -= (resizeSize.height-newSize.height)/1.0
                }
                
                draw(in: CGRect(origin: .zero, size: resizeSize))
            }
        }
}
