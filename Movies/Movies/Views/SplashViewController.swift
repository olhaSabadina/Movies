//
//  SplashViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let titleImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorConstans.splashColor
        setTitleImageView()
        setConstraint()
    }
    
    private func setTitleImageView() {
        titleImageView.backgroundColor = .clear
        titleImageView.image = ImageConstants.logoImage
        titleImageView.contentMode = .scaleAspectFill
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImageView)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            titleImageView.heightAnchor.constraint(equalToConstant: 36),
            titleImageView.widthAnchor.constraint(equalToConstant: 274),
            titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 1/3)
        ])
    }
}
