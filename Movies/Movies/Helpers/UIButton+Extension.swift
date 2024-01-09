//
//  UIButton+Extension.swift
//  Movies
//
//  Created by Yura Sabadin on 09.01.2024.
//

import UIKit

extension UIButton {
    
    static func createSegmentButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }
    
    func buttonIsActive(_ isSelected: Bool) {
        var font = UIFont()
        if isSelected {
            font = UIFont.systemFont(ofSize: 18, weight: .bold)
        } else {
            font = UIFont.systemFont(ofSize: 18)
        }
        self.titleLabel?.font = font
    }
}
