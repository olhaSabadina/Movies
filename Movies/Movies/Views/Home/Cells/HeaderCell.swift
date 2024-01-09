//
//  HeaderCell.swift
//  Movies
//
//  Created by Olga Sabadina on 09.01.2024.
//


import UIKit

class HeaderCell: UICollectionReusableView {
    
    static let identCell = "headerCell"
    
    var headerLabel = UILabel()
    let seeAllButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setHeaderLabel()
        setSeeAllButton()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHeaderLabel() {
        headerLabel.text = "What's Popular"
        headerLabel.font = UIFont(name: FontsConstants.openSansSemiBold, size: 18)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerLabel)
    }
    
    private func setSeeAllButton() {
        seeAllButton.backgroundColor = .clear
        seeAllButton.setTitle("See All", for: .normal)
        seeAllButton.titleLabel?.font = UIFont(name: FontsConstants.openSansSemiBold, size: 14)
        seeAllButton.tintColor = .systemBlue
        seeAllButton.titleLabel?.textAlignment = .right
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(seeAllButton)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
            
            seeAllButton.topAnchor.constraint(equalTo: topAnchor),
            seeAllButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            seeAllButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
        ])
    }
    
    
}
