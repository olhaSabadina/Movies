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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCategoriesButton() {
        categoriesButton.backgroundColor = .clear
        categoriesButton.setTitle("Movies", for: .normal)
        categoriesButton.titleLabel?.font = UIFont(name: FontsConstants.openSansSemiBold, size: 14)
        categoriesButton.tintColor = .label
        categoriesButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(categoriesButton)
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
