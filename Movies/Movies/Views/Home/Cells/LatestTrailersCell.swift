//
//  LatestTrailersCell.swift
//  Movies
//
//  Created by Olga Sabadina on 11.01.2024.
//

import UIKit

class LatestTrailersCell: BaseHomeCell {
    
    static var identCell = "latestTrailersCell"
    
    override func setPersentLabel() {
        persentLabel.font = UIFont(name: FontsConstants.openSansSemiBold, size: 14)
        persentLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(persentLabel)
    }
    
    override func setMoviesNameLabel() {
        moviesNameLabel.textColor = ColorConstans.latestTrailers
        moviesNameLabel.font = UIFont(name: FontsConstants.openSansRegular, size: 14)
        moviesNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moviesNameLabel)
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            bacgroundView.topAnchor.constraint(equalTo: topAnchor),
            bacgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bacgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            persentLabel.topAnchor.constraint(equalTo: bacgroundView.bottomAnchor, constant: 5),
            persentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            persentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            moviesNameLabel.topAnchor.constraint(equalTo: persentLabel.bottomAnchor, constant: 5),
            moviesNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: bacgroundView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: bacgroundView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: bacgroundView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bacgroundView.bottomAnchor)
        ])
    }
    
}
