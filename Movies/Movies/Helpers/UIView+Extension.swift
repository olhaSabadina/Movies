//
//  UIView+Extension.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import UIKit

extension UIView {
    
    func setBorderLayer(backgroundColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat, tintColor: UIColor?) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }
    
    func setShadow(colorShadow: UIColor, offset: CGSize, opacity: Float, radius: CGFloat, cornerRadius: CGFloat ) {
        layer.shadowColor = colorShadow.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
    }
}
