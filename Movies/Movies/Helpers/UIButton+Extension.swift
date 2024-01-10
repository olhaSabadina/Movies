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
        button.titleLabel?.font = UIFont(name: FontsConstants.openSansRegular, size: 13)
        button.setTitleColor(.black, for: .normal)
        return button
    }
    
    func buttonIsActive(_ isSelected: Bool) {
        var font = UIFont()
        if isSelected {
            font = UIFont(name: FontsConstants.openSansSemiBold, size: 13) ?? .boldSystemFont(ofSize: 13)
        } else {
            font = UIFont(name: FontsConstants.openSansRegular, size: 13) ?? .systemFont(ofSize: 13)
        }
        self.titleLabel?.font = font
    }
}
