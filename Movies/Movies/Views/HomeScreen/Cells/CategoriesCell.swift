//
//  CategoriesCell.swift
//  Movies
//
//  Created by Olga Sabadina on 09.01.2024.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    static var identCell = "categoriesCell"

    let categoriesButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setCategoriesButton()
        setConstraint()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoriesButton.setTitle("", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCategoriesButton() {
        categoriesButton.backgroundColor = .clear
        categoriesButton.titleLabel?.font = UIFont(name: FontConstants.openSansSemiBold, size: 14)
        categoriesButton.tintColor = .label
        categoriesButton.titleLabel?.textAlignment = .left
        categoriesButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(categoriesButton)
        
        let action = UIAction { _ in
            print("button category action") // left to see button action
        }
        categoriesButton.addAction(action, for: .touchUpInside)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            categoriesButton.topAnchor.constraint(equalTo: self.topAnchor),
            categoriesButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            categoriesButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoriesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
